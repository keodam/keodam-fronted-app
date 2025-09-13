import 'package:freezed_annotation/freezed_annotation.dart';

part 'navigation_tab.freezed.dart';

@freezed
sealed class NavigationTab with _$NavigationTab {
  const factory NavigationTab({
    required String label,
    required String iconPath,
    required int index,
  }) = _NavigationTab;

  const NavigationTab._();
}