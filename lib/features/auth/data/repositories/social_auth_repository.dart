import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keodam_app/core/error/failures.dart';
import 'package:keodam_app/dio/dio.dart';
import 'package:keodam_app/features/auth/data/dtos/auth_dto.dart';
import 'package:keodam_app/features/auth/data/token_provider.dart';
import 'package:keodam_app/features/user/data/dtos/user_dto.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'social_auth_repository.g.dart';

@riverpod
SocialAuthRepository socialAuthRepository(Ref ref) {
  return SocialAuthRepository(ref: ref);
}

class SocialAuthRepository {
  final Ref ref;

  SocialAuthRepository({
    required this.ref,
  });

  /// 소셜 로그인 (카카오, 구글, 애플 등)
  Future<Either<Failure, AuthDTO>> loginWithSocial({
    required String provider,
    required String socialToken,
  }) async {
    try {
      final dio = ref.read(dioProvider);
      final response = await dio.post(
        '/api/auth/login',
        data: {
          'idToken': socialToken,
          'provider': provider,
        },
      );



      // 헤더에서 JWT 토큰 획득
      final String? authorization = response.headers['authorization']?.first;
      final String? refreshtoken = response.headers['refreshtoken']?.first;

      print('서버 응답 확인');
      print('Authorization: $authorization');
      print('RefreshToken: $refreshtoken');

      if (authorization != null && refreshtoken != null) {
        final tokenNotifier = ref.read(tokenNotifierProvider.notifier);
        await tokenNotifier.saveTokens(
          accessToken: authorization,
          refreshToken: refreshtoken,
        );
      } else {
        return const Left(
          Failure.serverFailure(message: '서버에서 인증 토큰을 받지 못했습니다.'),
        );
      }

      // 임시로 빈 사용자 정보로 AuthDTO 생성 (나중에 사용자 정보 API로 가져올 예정)
      const userDTO = UserDTO();
      final authDTO = AuthDTO(user: userDTO, provider: provider);
      
      return Right(authDTO);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        return const Left(Failure.unauthorizedFailure(message: '소셜 로그인 인증에 실패했습니다.'));
      }
      return Left(Failure.networkFailure(message: e.message));
    } catch (e) {
      return Left(Failure.unknownFailure(message: e.toString()));
    }
  }
}