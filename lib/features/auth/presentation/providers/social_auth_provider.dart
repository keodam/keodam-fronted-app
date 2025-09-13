import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:keodam_app/core/error/failures.dart';
import 'package:keodam_app/features/auth/domain/services/kakao_auth_service.dart';
import 'package:keodam_app/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'social_auth_provider.freezed.dart';
part 'social_auth_provider.g.dart';

enum SocialProvider {
  kakao('kakao'),
  google('google'),
  apple('apple');

  const SocialProvider(this.value);
  final String value;
}

@freezed
sealed class SocialAuthState with _$SocialAuthState {
  const factory SocialAuthState.initial() = _Initial;
  const factory SocialAuthState.loading() = _Loading;
  const factory SocialAuthState.success() = _Success;
  const factory SocialAuthState.error(Failure failure) = _Error;
}

@riverpod
class SocialAuthNotifier extends _$SocialAuthNotifier {
  @override
  SocialAuthState build() {
    return const SocialAuthState.initial();
  }

  /// 소셜 로그인 실행
  Future<void> loginWithSocial(SocialProvider provider) async {
    state = const SocialAuthState.loading();

    try {
      switch (provider) {
        case SocialProvider.kakao:
          await _loginWithKakao();
          break;
        case SocialProvider.google:
          // TODO: 구글 로그인 구현 예정
          state = const SocialAuthState.error(
            Failure.unknownFailure(message: '구글 로그인은 아직 구현되지 않았습니다.'),
          );
          break;
        case SocialProvider.apple:
          // TODO: 애플 로그인 구현 예정
          state = const SocialAuthState.error(
            Failure.unknownFailure(message: '애플 로그인은 아직 구현되지 않았습니다.'),
          );
          break;
      }
    } catch (e) {
      state = SocialAuthState.error(
        Failure.unknownFailure(message: '소셜 로그인 중 예상치 못한 오류가 발생했습니다: $e'),
      );
    }
  }

  /// 카카오 로그인 처리
  Future<void> _loginWithKakao() async {
    final kakaoAuthService = ref.read(kakaoAuthServiceProvider);
    final result = await kakaoAuthService.loginWithKakao();

    result.fold(
      (failure) {
        state = SocialAuthState.error(failure);
      },
      (auth) {
        // 로그인 성공 시 AuthStateNotifier에 인증 정보 설정
        ref.read(authStateNotifierProvider.notifier).setAuthenticated(auth);
        state = const SocialAuthState.success();
      },
    );
  }

  /// 상태 초기화
  void reset() {
    state = const SocialAuthState.initial();
  }
}