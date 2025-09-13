import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'home_navigation_notifier.g.dart';

@riverpod
class HomeNavigationNotifier extends _$HomeNavigationNotifier {
  @override
  int build() {
    return 0;
  }

  void selectTab(int index) {
    if (index >= 0 && index < 4) {
      state = index;
    }
  }

}