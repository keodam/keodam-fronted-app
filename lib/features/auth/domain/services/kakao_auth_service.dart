import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:keodam_app/core/error/failures.dart';
import 'package:keodam_app/features/auth/data/repositories/social_auth_repository.dart';
import 'package:keodam_app/features/auth/domain/entities/auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'kakao_auth_service.g.dart';

@riverpod
KakaoAuthService kakaoAuthService(Ref ref) {
  return KakaoAuthService(ref: ref);
}

class KakaoAuthService {
  final Ref ref;

  KakaoAuthService({
    required this.ref,
  });

  /// 카카오 로그인
  Future<Either<Failure, Auth>> loginWithKakao() async {
    try {
      OAuthToken token;

      // 카카오톡 설치 여부 확인
      bool isInstalled = false;
      try {
        isInstalled = await isKakaoTalkInstalled();
      } catch (e) {
        log('카카오톡 설치 확인 실패: $e');
        isInstalled = false;
      }
      
      // SDK 호출 전 약간의 딜레이를 추가하여 안정성 확보
      await Future.delayed(const Duration(milliseconds: 100));

      if (isInstalled) {
        log('카카오톡으로 로그인 시도');
        token = await UserApi.instance.loginWithKakaoTalk()
            .timeout(const Duration(seconds: 30));
      } else {
        log('카카오 계정으로 로그인 시도');
        token = await UserApi.instance.loginWithKakaoAccount()
            .timeout(const Duration(seconds: 30));
      }

      final String? idToken = token.idToken;
      if (idToken == null) {
        return const Left(Failure.unknownFailure(message: 'idToken을 가져올 수 없습니다.'));
      }

      log('카카오 로그인 성공, idToken: $idToken');

      // 서버에 idToken 전송하여 JWT 토큰 획득
      final repository = ref.read(socialAuthRepositoryProvider);
      final result = await repository.loginWithSocial(
        provider: 'kakao',
        socialToken: idToken,
      );

      return result.fold(
        (failure) => Left(failure),
        (authDTO) => Right(authDTO.toEntity()),
      );
    } catch (kakaoError) {
      log('카카오 SDK 에러: $kakaoError');
      
      // 카카오 SDK 에러를 명확히 처리
      if (kakaoError.toString().contains('User cancelled') || 
          kakaoError.toString().contains('KakaoClientException') ||
          kakaoError.toString().contains('user_cancelled')) {
        return const Left(Failure.unknownFailure(message: '로그인이 취소되었습니다.'));
      } else if (kakaoError.toString().contains('Future already completed')) {
        // Future already completed 에러 특별 처리
        log('Future already completed 에러 감지 - 재시도 필요');
        return const Left(Failure.unknownFailure(message: '로그인 처리 중 오류가 발생했습니다. 다시 시도해주세요.'));
      } else if (kakaoError.toString().contains('TimeoutException')) {
        return const Left(Failure.unknownFailure(message: '로그인 시간이 초과되었습니다. 다시 시도해주세요.'));
      } else {
        return Left(Failure.unknownFailure(message: '카카오 로그인 실패: $kakaoError'));
      }
    }
  }
}