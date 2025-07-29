import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:keodam/features/mypage/data/model/refund_item_type.dart';
import 'package:keodam/features/mypage/data/model/refund_status.dart';

part 'purchase_data.freezed.dart';

@freezed
abstract class PurchaseList with _$PurchaseList {
  const factory PurchaseList({
    required String itemName,
    required RefundItemType itemType,
    required int itemPrice,
    required DateTime date,
    required RefundStatus refundStatus,
    String? paymentMethod,
  }) = _PurchaseList;
}
