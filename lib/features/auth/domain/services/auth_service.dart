import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keodam_app/core/error/failures.dart';
import 'package:keodam_app/features/auth/data/repositories/auth_repository.dart';
import 'package:keodam_app/features/auth/data/token_provider.dart';
import 'package:keodam_app/features/auth/domain/entities/auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_service.g.dart';

@riverpod
AuthService authService(Ref ref) {
  return AuthService(ref: ref);
}

class AuthService {
  final Ref ref;

  AuthService({
    required this.ref,
  });

  /// 현재 인증 정보 조회
  Future<Either<Failure, Auth>> getCurrentAuth() async {
    final repository = ref.read(authRepositoryProvider);
    final result = await repository.getCurrentAuth();

    return result.fold(
      (failure) => Left(failure),
      (authDTO) => Right(authDTO.toEntity()),
    );
  }

  /// 토큰 존재 여부 확인
  bool hasTokens() {
    final tokenNotifier = ref.read(tokenNotifierProvider.notifier);
    return tokenNotifier.hasTokens;
  }

  /// 인증 상태 확인 (토큰 존재 + 사용자 정보 유효성)
  Future<Either<Failure, Auth>> checkAuthStatus() async {
    // 1. 토큰 존재 여부 확인
    if (!hasTokens()) {
      return const Left(Failure.unauthorizedFailure(message: '토큰이 존재하지 않습니다.'));
    }

    // 2. 인증 정보 조회 (토큰 유효성 검증)
    return await getCurrentAuth();
  }

  /// 로그아웃 처리
  Future<void> logout() async {
    final tokenNotifier = ref.read(tokenNotifierProvider.notifier);
    await tokenNotifier.clearTokens();
  }
}