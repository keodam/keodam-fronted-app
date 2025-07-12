import 'dart:ui';

class MentoLevelInfo {
  final int level;
  final String title;
  final int minExp;
  final int maxExp;
  final Color color;
  final String image;

  const MentoLevelInfo({
    required this.level,
    required this.title,
    required this.minExp,
    required this.maxExp,
    required this.color,
    required this.image,
  });

  bool containsExp(int exp) {
    return exp >= minExp && exp < maxExp;
  }
}
