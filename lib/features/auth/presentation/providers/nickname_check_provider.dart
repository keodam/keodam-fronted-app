import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keodam_app/features/auth/domain/services/nickname_check_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'nickname_check_provider.freezed.dart';
part 'nickname_check_provider.g.dart';

enum NicknameCheckStatus {
  idle,
  loading,
  success,
  error,
}

@freezed
sealed class NicknameCheckState with _$NicknameCheckState {
  const factory NicknameCheckState({
    @Default(NicknameCheckStatus.idle) NicknameCheckStatus status,
    @Default(false) bool isChecked,
    @Default(false) bool hasAttempted,
    String? checkedNickname,
    String? currentNickname,
    String? errorMessage,
  }) = _NicknameCheckState;

  const NicknameCheckState._();

  bool get isLoading => status == NicknameCheckStatus.loading;
  bool get isSuccess => status == NicknameCheckStatus.success;
  bool get isError => status == NicknameCheckStatus.error;
  bool get canProceed => isChecked && isSuccess;
}

@Riverpod(keepAlive: true)
class NicknameCheckNotifier extends _$NicknameCheckNotifier {
  @override
  NicknameCheckState build() {
    return const NicknameCheckState();
  }

  /// 닉네임 중복 확인
  Future<void> checkNickname(String nickname) async {
    state = state.copyWith(
      status: NicknameCheckStatus.loading,
      hasAttempted: true,
      errorMessage: null,
    );

    final service = ref.read(nicknameCheckServiceProvider);
    final result = await service.checkNickname(nickname);

    result.fold(
      (failure) {
        state = state.copyWith(
          status: NicknameCheckStatus.error,
          isChecked: false,
          checkedNickname: null,
          errorMessage: failure.message ?? '닉네임 중복 확인에 실패했습니다.',
        );
      },
      (isAvailable) {
        if (isAvailable) {
          state = state.copyWith(
            status: NicknameCheckStatus.success,
            isChecked: true,
            checkedNickname: nickname,
            errorMessage: null,
          );
        } else {
          state = state.copyWith(
            status: NicknameCheckStatus.error,
            isChecked: false,
            checkedNickname: null,
            errorMessage: '이미 사용 중인 닉네임입니다.',
          );
        }
      },
    );
  }

  /// 닉네임 변경 시 중복확인 상태 초기화
  void onNicknameChanged(String newNickname) {
    // 현재 닉네임 값 업데이트
    state = state.copyWith(currentNickname: newNickname);
    
    // 현재 확인된 닉네임과 다른 경우에만 초기화
    if (state.checkedNickname != null && state.checkedNickname != newNickname) {
      state = state.copyWith(
        status: NicknameCheckStatus.idle,
        isChecked: false,
        hasAttempted: false,
        checkedNickname: null,
        errorMessage: null,
      );
    }
  }

  /// 상태 초기화
  void reset() {
    state = const NicknameCheckState();
  }
}