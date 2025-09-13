import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keodam_app/features/auth/data/token_provider.dart';
import 'package:keodam_app/features/auth/domain/services/education_status_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'education_status_provider.freezed.dart';
part 'education_status_provider.g.dart';

enum EducationStatusUploadStatus {
  idle,
  loading,
  success,
  error,
}

@freezed
sealed class EducationStatusState with _$EducationStatusState {
  const factory EducationStatusState({
    @Default(EducationStatusUploadStatus.idle) EducationStatusUploadStatus status,
    @Default(false) bool hasAttempted,
    StudentStatus? selectedStatus,
    String? errorMessage,
  }) = _EducationStatusState;

  const EducationStatusState._();

  bool get isLoading => status == EducationStatusUploadStatus.loading;
  bool get isSuccess => status == EducationStatusUploadStatus.success;
  bool get isError => status == EducationStatusUploadStatus.error;
  bool get canProceed => isSuccess && selectedStatus != null;
  bool get hasSelected => selectedStatus != null;
}

@Riverpod(keepAlive: true)
class EducationStatusNotifier extends _$EducationStatusNotifier {
  @override
  EducationStatusState build() {
    return const EducationStatusState();
  }

  /// 선택된 재학상태 설정
  void setSelectedStatus(StudentStatus? status) {
    print('재학상태 설정: ${status?.name}');
    
    state = state.copyWith(
      selectedStatus: status,
      status: EducationStatusUploadStatus.idle,
      hasAttempted: false,
      errorMessage: null,
    );
  }

  /// 재학상태 업데이트 (API 호출)
  Future<void> updateStudentStatus() async {

    if (state.selectedStatus == null) {
      state = state.copyWith(
        status: EducationStatusUploadStatus.error,
        hasAttempted: true,
        errorMessage: '재학상태를 선택해주세요.',
      );
      return;
    }

    // 인증 토큰 확인 (비동기로 초기화 대기)
    final tokenState = await ref.read(tokenNotifierProvider.future);
    final accessToken = tokenState.$1;

    if (accessToken == null || accessToken.isEmpty) {
      state = state.copyWith(
        status: EducationStatusUploadStatus.error,
        hasAttempted: true,
        errorMessage: '로그인이 필요합니다. 다시 로그인해주세요.',
      );
      return;
    }

    state = state.copyWith(
      status: EducationStatusUploadStatus.loading,
      hasAttempted: true,
      errorMessage: null,
    );

    final service = ref.read(educationStatusServiceProvider);
    final result = await service.updateStudentStatus(state.selectedStatus);

    result.fold(
      (failure) {
        state = state.copyWith(
          status: EducationStatusUploadStatus.error,
          errorMessage: failure.message ?? '재학상태 업데이트에 실패했습니다.',
        );
      },
      (isSuccess) {
        state = state.copyWith(
          status: EducationStatusUploadStatus.success,
          errorMessage: null,
        );
      },
    );
  }

  /// 상태 초기화
  void reset() {
    state = const EducationStatusState();
  }
}