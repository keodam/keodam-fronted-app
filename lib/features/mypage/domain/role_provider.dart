import 'package:flutter_riverpod/flutter_riverpod.dart';

class RoleNotifier extends StateNotifier<bool> {
  RoleNotifier() : super(false); // true: 멘티, false: 멘토

  void toggle() => state = !state;
}

final isMenteeProvider = StateNotifierProvider<RoleNotifier, bool>(
  (ref) => RoleNotifier(),
);
