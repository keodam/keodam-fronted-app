import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keodam/features/mypage/data/model/roulette_info.dart';

final rouletteProvider = StateProvider<RouletteInfo>((ref) {
  return RouletteInfo(rouletteCoupon: 1, coffeeCoupon: 3);
});
