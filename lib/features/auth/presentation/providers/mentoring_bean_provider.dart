import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:keodam_app/features/auth/domain/services/mentoring_bean_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'mentoring_bean_provider.freezed.dart';
part 'mentoring_bean_provider.g.dart';

enum MentoringBeanStatus {
  idle,
  loading,
  success,
  error,
}

@freezed
sealed class MentoringBeanState with _$MentoringBeanState {
  const factory MentoringBeanState({
    @Default(MentoringBeanStatus.idle) MentoringBeanStatus status,
    @Default(false) bool hasAttempted,
    @Default(false) bool isUpdated,
    int? selectedBean,
    String? errorMessage,
  }) = _MentoringBeanState;

  const MentoringBeanState._();

  bool get isLoading => status == MentoringBeanStatus.loading;
  bool get isSuccess => status == MentoringBeanStatus.success;
  bool get isError => status == MentoringBeanStatus.error;
  bool get canProceed => isSuccess && isUpdated;
}

@Riverpod(keepAlive: true)
class MentoringBeanNotifier extends _$MentoringBeanNotifier {
  @override
  MentoringBeanState build() {
    return const MentoringBeanState(selectedBean: 500);
  }

  /// 선택된 빈 값 설정
  void setSelectedBean(int bean) {
    state = state.copyWith(
      selectedBean: bean,
    );
  }

  /// 멘토링 빈 업데이트
  Future<void> updateMentoringBean() async {
    if (state.selectedBean == null) {
      state = state.copyWith(
        status: MentoringBeanStatus.error,
        hasAttempted: true,
        errorMessage: '빈 개수를 선택해주세요.',
      );
      return;
    }

    state = state.copyWith(
      status: MentoringBeanStatus.loading,
      hasAttempted: true,
      errorMessage: null,
    );

    final service = ref.read(mentoringBeanServiceProvider);
    final result = await service.updateMentoringBean(state.selectedBean!);

    result.fold(
      (failure) {
        state = state.copyWith(
          status: MentoringBeanStatus.error,
          isUpdated: false,
          errorMessage: failure.message ?? '멘토링 빈 설정에 실패했습니다.',
        );
      },
      (isSuccess) {
        state = state.copyWith(
          status: MentoringBeanStatus.success,
          isUpdated: isSuccess,
          errorMessage: null,
        );
      },
    );
  }

  /// 상태 초기화
  void reset() {
    state = const MentoringBeanState(selectedBean: 500);
  }
}