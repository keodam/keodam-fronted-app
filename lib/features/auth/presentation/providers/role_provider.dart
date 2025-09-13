import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keodam_app/features/auth/domain/services/role_service.dart';
import 'package:keodam_app/features/auth/presentation/states/role_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'role_provider.g.dart';

@riverpod
class RoleNotifier extends _$RoleNotifier {
  @override
  RoleState build() {
    return const RoleState();
  }

  /// 역할 선택
  void selectRole(String role) {
    state = state.copyWith(
      selectedRole: role,
      isSuccess: false,
      errorMessage: null,
    );
  }

  /// 역할 업데이트 API 호출
  Future<void> updateUserRole() async {
    state = state.copyWith(
      isLoading: true,
      isSuccess: false,
      errorMessage: null,
    );

    final service = ref.read(roleServiceProvider);
    final result = await service.updateUserRole(state.selectedRole);

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          isSuccess: false,
          errorMessage: failure.message,
        );
      },
      (success) {
        state = state.copyWith(
          isLoading: false,
          isSuccess: true,
          errorMessage: null,
        );
      },
    );
  }

  /// 상태 초기화
  void resetState() {
    state = const RoleState();
  }
}