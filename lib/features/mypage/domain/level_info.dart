// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';
import 'package:keodam/core/theme/colors.dart';

class LevelInfo {
  final int level;
  final String title;
  final int minExp;
  final int maxExp;
  final Color color;
  final String image;

  const LevelInfo({
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

const List<LevelInfo> levelTable = [
  LevelInfo(
    level: 0,
    title: '초심자',
    minExp: 0,
    maxExp: 500,
    color: mentoProgressColor00,
    image: 'assets/images/mypage/mento_level_0.png',
  ),
  LevelInfo(
    level: 1,
    title: '학습자',
    minExp: 500,
    maxExp: 1300,
    color: mentoProgressColor01,
    image: 'assets/images/mypage/mento_level_1.png',
  ),
  LevelInfo(
    level: 2,
    title: '실행자',
    minExp: 1300,
    maxExp: 2500,
    color: mentoProgressColor02,
    image: 'assets/images/mypage/mento_level_2.png',
  ),
  LevelInfo(
    level: 3,
    title: '전문가',
    minExp: 2500,
    maxExp: 4000,
    color: mentoProgressColor03,
    image: 'assets/images/mypage/mento_level_3.png',
  ),
  LevelInfo(
    level: 4,
    title: '조언자',
    minExp: 4000,
    maxExp: 6000,
    color: mentoProgressColor04,
    image: 'assets/images/mypage/mento_level_4.png',
  ),
  LevelInfo(
    level: 5,
    title: '리더',
    minExp: 6000,
    maxExp: 8200,
    color: mentoProgressColor05,
    image: 'assets/images/mypage/mento_level_5.png',
  ),
  LevelInfo(
    level: 6,
    title: '레전드',
    minExp: 8200,
    maxExp: 10000,
    color: mentoProgressColor06,
    image: 'assets/images/mypage/mento_level_6.png',
  ),
];

LevelInfo getLevelInfo(int exp) {
  return levelTable.firstWhere(
    (level) => level.containsExp(exp),
    orElse: () => levelTable.last,
  );
}
