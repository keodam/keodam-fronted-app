import 'dart:ui';
import 'package:keodam/core/theme/colors.dart';

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

const List<MentoLevelInfo> levelTable = [
  MentoLevelInfo(
    level: 0,
    title: '초심자',
    minExp: 0,
    maxExp: 500,
    color: mentoProgressColor00,
    image: 'assets/images/mypage/mento_level_0.png',
  ),
  MentoLevelInfo(
    level: 1,
    title: '학습자',
    minExp: 500,
    maxExp: 1300,
    color: mentoProgressColor01,
    image: 'assets/images/mypage/mento_level_1.png',
  ),
  MentoLevelInfo(
    level: 2,
    title: '실행자',
    minExp: 1300,
    maxExp: 2500,
    color: mentoProgressColor02,
    image: 'assets/images/mypage/mento_level_2.png',
  ),
  MentoLevelInfo(
    level: 3,
    title: '전문가',
    minExp: 2500,
    maxExp: 4000,
    color: mentoProgressColor03,
    image: 'assets/images/mypage/mento_level_3.png',
  ),
  MentoLevelInfo(
    level: 4,
    title: '조언자',
    minExp: 4000,
    maxExp: 6000,
    color: mentoProgressColor04,
    image: 'assets/images/mypage/mento_level_4.png',
  ),
  MentoLevelInfo(
    level: 5,
    title: '리더',
    minExp: 6000,
    maxExp: 8200,
    color: mentoProgressColor05,
    image: 'assets/images/mypage/mento_level_5.png',
  ),
  MentoLevelInfo(
    level: 6,
    title: '레전드',
    minExp: 8200,
    maxExp: 10000,
    color: mentoProgressColor06,
    image: 'assets/images/mypage/mento_level_6.png',
  ),
];

MentoLevelInfo getLevelInfo(int exp) {
  return levelTable.firstWhere(
    (level) => level.containsExp(exp),
    orElse: () => levelTable.last,
  );
}
