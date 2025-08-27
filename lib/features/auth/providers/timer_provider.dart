import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'timer_provider.g.dart';

@riverpod
class TimerNotifier extends _$TimerNotifier {
  Timer? _timer;

  @override
  int build() {
    return 0;
  }

  void startTimer(int duration) {
    state = duration;
    _timer?.cancel();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (state == 0) {
          _timer?.cancel();
        } else {
          state = state - 1;
        }
      },
    );
  }

  void stopTimer() {
    _timer?.cancel();
    state = 0;
  }

  void dispose() {
    _timer?.cancel();
  }
}
