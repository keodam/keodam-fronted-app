import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/material.dart';

part 'roulette_info.freezed.dart';

@freezed
abstract class RouletteInfo with _$RouletteInfo {
  const factory RouletteInfo({
    required int rouletteCoupon,
    required int coffeeCoupon,
  }) = _RouletteInfo;
}
