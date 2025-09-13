import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keodam_app/features/auth/data/token_provider.dart';
import 'package:keodam_app/features/auth/domain/services/referral_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'referral_provider.freezed.dart';
part 'referral_provider.g.dart';

enum ReferralStatus {
  idle,
  loading,
  success,
  error,
}

@freezed
sealed class ReferralState with _$ReferralState {
  const factory ReferralState({
    @Default(ReferralStatus.idle) ReferralStatus status,
    @Default(false) bool hasAttempted,
    @Default(false) bool isRegistered,
    String? refereeNickname,
    String? errorMessage,
  }) = _ReferralState;

  const ReferralState._();

  bool get isLoading => status == ReferralStatus.loading;
  bool get isSuccess => status == ReferralStatus.success;
  bool get isError => status == ReferralStatus.error;
  bool get canProceed => isSuccess && isRegistered;
  bool get hasReferee => refereeNickname != null && refereeNickname!.trim().isNotEmpty;
}

@Riverpod(keepAlive: true)
class ReferralNotifier extends _$ReferralNotifier {
  @override
  ReferralState build() {
    return const ReferralState();
  }

  /// 추천인 닉네임 설정
  void setRefereeNickname(String? nickname) {
    print('추천인 닉네임 설정: $nickname');
    
    state = state.copyWith(
      refereeNickname: nickname?.trim(),
      status: ReferralStatus.idle,
      hasAttempted: false,
      isRegistered: false,
      errorMessage: null,
    );
  }

  /// 추천인 등록 (API 호출)
  Future<void> registerReferral() async {
    final nickname = state.refereeNickname?.trim();
    
    if (nickname == null || nickname.isEmpty) {
      state = state.copyWith(
        status: ReferralStatus.error,
        hasAttempted: true,
        errorMessage: '추천인 닉네임을 입력해주세요.',
      );
      return;
    }

    // 인증 토큰 확인 (비동기로 초기화 대기)
    final tokenState = await ref.read(tokenNotifierProvider.future);
    final accessToken = tokenState.$1;

    print('토큰 확인 - accessToken: ${accessToken != null ? "존재함" : "없음"}');

    if (accessToken == null || accessToken.isEmpty) {
      print('에러: 인증 토큰이 없음');
      state = state.copyWith(
        status: ReferralStatus.error,
        hasAttempted: true,
        errorMessage: '로그인이 필요합니다. 다시 로그인해주세요.',
      );
      return;
    }

    state = state.copyWith(
      status: ReferralStatus.loading,
      hasAttempted: true,
      errorMessage: null,
    );

    final service = ref.read(referralServiceProvider);
    final result = await service.registerReferral(nickname);

    result.fold(
      (failure) {
        state = state.copyWith(
          status: ReferralStatus.error,
          isRegistered: false,
          errorMessage: failure.message ?? '추천인 등록에 실패했습니다.',
        );
      },
      (isSuccess) {
        state = state.copyWith(
          status: ReferralStatus.success,
          isRegistered: isSuccess,
          errorMessage: null,
        );
      },
    );
  }

  /// 상태 초기화
  void reset() {
    state = const ReferralState();
  }
}