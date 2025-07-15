import 'package:keodam/features/mypage/data/model/mentee_level_table.dart';
import 'package:keodam/features/mypage/data/model/mentee_level.dart';

MenteeLevelInfo getMenteeLevelInfo(int degree) {
  return levelTable.firstWhere(
    (level) => degree >= level.minDegree && degree < level.maxDegree,
    orElse: () => levelTable.last,
  );
}
