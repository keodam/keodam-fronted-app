// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:keodam/core/theme/colors.dart';

class MenteeLevelInfo {
  final int level;
  final Color color;
  final int minDegree;
  final int maxDegree;
  final String image;

  const MenteeLevelInfo({
    required this.level,
    required this.color,
    required this.minDegree,
    required this.maxDegree,
    required this.image,
  });
}

const List<MenteeLevelInfo> levelTable = [
  MenteeLevelInfo(
    level: 0,
    minDegree: 10,
    maxDegree: 20,
    color: menteeProgressColor00,
    image: 'assets/images/mypage/mentee_level_0.png',
  ),
  MenteeLevelInfo(
    level: 1,
    minDegree: 20,
    maxDegree: 30,
    color: menteeProgressColor01,
    image: 'assets/images/mypage/mentee_level_1.png',
  ),
  MenteeLevelInfo(
    level: 2,
    minDegree: 30,
    maxDegree: 40,
    color: menteeProgressColor02,
    image: 'assets/images/mypage/mentee_level_2.png',
  ),
  MenteeLevelInfo(
    level: 3,
    minDegree: 40,
    maxDegree: 50,
    color: menteeProgressColor03,
    image: 'assets/images/mypage/mentee_level_3.png',
  ),
  MenteeLevelInfo(
    level: 4,
    minDegree: 50,
    maxDegree: 60,
    color: menteeProgressColor04,
    image: 'assets/images/mypage/mentee_level_4.png',
  ),
  MenteeLevelInfo(
    level: 5,
    minDegree: 60,
    maxDegree: 70,
    color: menteeProgressColor05,
    image: 'assets/images/mypage/mentee_level_5.png',
  ),
  MenteeLevelInfo(
    level: 6,
    minDegree: 70,
    maxDegree: 75,
    color: menteeProgressColor06,
    image: 'assets/images/mypage/mentee_level_6.png',
  ),
];

MenteeLevelInfo getMenteeLevelInfo(int degree) {
  return levelTable.firstWhere(
    (level) => degree >= level.minDegree && degree < level.maxDegree,
    orElse: () => levelTable.last,
  );
}
