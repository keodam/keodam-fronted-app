import 'package:keodam/features/mypage/data/model/mento_level.dart';
import 'package:keodam/features/mypage/data/model/mento_level_table.dart';

MentoLevelInfo getMentoLevelInfo(int exp) {
  return levelTable.firstWhere(
    (level) => level.containsExp(exp),
    orElse: () => levelTable.last,
  );
}
