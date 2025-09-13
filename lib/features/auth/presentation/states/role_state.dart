import 'package:freezed_annotation/freezed_annotation.dart';

part 'role_state.freezed.dart';

@freezed
sealed class RoleState with _$RoleState {
  const factory RoleState({
    @Default('MENTOR') String selectedRole,
    @Default(false) bool isLoading,
    @Default(false) bool isSuccess,
    String? errorMessage,
  }) = _RoleState;

  const RoleState._();

  bool get canProceed => isSuccess && !isLoading;
}