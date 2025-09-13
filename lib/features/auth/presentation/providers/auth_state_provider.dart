import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:keodam_app/core/error/failures.dart';
import 'package:keodam_app/features/auth/domain/entities/auth.dart';
import 'package:keodam_app/features/auth/domain/services/auth_service.dart';
import 'package:keodam_app/features/user/presentation/providers/user_state_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_state_provider.freezed.dart';
part 'auth_state_provider.g.dart';

@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.authenticated(Auth auth) = _Authenticated;
  const factory AuthState.unauthenticated() = _Unauthenticated;
  const factory AuthState.error(Failure failure) = _Error;
}

@riverpod
class AuthStateNotifier extends _$AuthStateNotifier {
  @override
  AuthState build() {
    return const AuthState.initial();
  }

  /// 인증 상태 초기화 (앱 시작 시 호출)
  Future<void> initializeAuth() async {
    state = const AuthState.loading();

    final authService = ref.read(authServiceProvider);
    final userStateNotifier = ref.read(userStateNotifierProvider.notifier);

    final result = await authService.checkAuthStatus();

    result.fold(
      (failure) {
        userStateNotifier.clearUser();
        if (failure is UnauthorizedFailure) {
          state = const AuthState.unauthenticated();
        } else {
          state = AuthState.error(failure);
        }
      },
      (auth) {
        userStateNotifier.setUser(auth.user);
        state = AuthState.authenticated(auth);
      },
    );
  }

  /// 로그인 성공 시 호출
  void setAuthenticated(Auth auth) {
    final userStateNotifier = ref.read(userStateNotifierProvider.notifier);
    userStateNotifier.setUser(auth.user);
    state = AuthState.authenticated(auth);
  }

  /// 로그아웃 처리
  Future<void> logout() async {
    final authService = ref.read(authServiceProvider);
    final userStateNotifier = ref.read(userStateNotifierProvider.notifier);

    await authService.logout();
    userStateNotifier.clearUser();
    state = const AuthState.unauthenticated();
  }

  /// 에러 상태에서 재시도
  Future<void> retry() async {
    await initializeAuth();
  }
}