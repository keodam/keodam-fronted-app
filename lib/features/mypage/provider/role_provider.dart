import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Role { mentee, mentor }

class RoleNotifier extends StateNotifier<Role> {
  //초기 상태 is mentor
  RoleNotifier() : super(Role.mentor);

  void toggle() {
    state = state == Role.mentee ? Role.mentor : Role.mentee;
  }
}

final userRoleProvider = StateNotifierProvider<RoleNotifier, Role>(
  (ref) => RoleNotifier(),
);
