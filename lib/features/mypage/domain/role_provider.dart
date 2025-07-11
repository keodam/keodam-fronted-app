import 'package:riverpod/riverpod.dart';

enum Role { mentee, mentor }

class RoleNotifier extends StateNotifier<Role> {
  RoleNotifier() : super(Role.mentee);

  void toggle() {
    state = state == Role.mentee ? Role.mentor : Role.mentee;
  }
}

final userRoleProvider = StateNotifierProvider<RoleNotifier, Role>(
  (ref) => RoleNotifier(),
);
