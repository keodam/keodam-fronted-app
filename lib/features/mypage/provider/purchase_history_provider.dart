import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keodam/features/mypage/data/model/purchase_data.dart';
import 'package:keodam/features/mypage/data/model/refund_item_type.dart';
import 'package:keodam/features/mypage/data/model/refund_status.dart';

final purchaseHistoryProvider =
    StateNotifierProvider<PurchaseHistoryNotifier, List<PurchaseList>>(
      (ref) => PurchaseHistoryNotifier(),
    );

class PurchaseHistoryNotifier extends StateNotifier<List<PurchaseList>> {
  PurchaseHistoryNotifier() : super(dummyPurchaseHistory);

  void updateRefundStatus(int index, RefundStatus newStatus) {
    final updated = state.toList();
    updated[index] = updated[index].copyWith(refundStatus: newStatus);
    state = updated;
  }
}

final dummyPurchaseHistory = <PurchaseList>[
  PurchaseList(
    itemName: '1000 원두',
    itemType: RefundItemType.beans1000,
    itemPrice: 14000,
    date: DateTime(2025, 7, 21),
    refundStatus: RefundStatus.refundable,
    paymentMethod: '카카오페이',
  ),
  PurchaseList(
    itemName: '500 원두',
    itemType: RefundItemType.beans500,
    itemPrice: 7000,
    date: DateTime(2025, 7, 20),
    refundStatus: RefundStatus.pending,
    paymentMethod: '카드',
  ),
  PurchaseList(
    itemName: '1500 원두',
    itemType: RefundItemType.beans1500,
    itemPrice: 21000,
    date: DateTime(2025, 7, 15),
    refundStatus: RefundStatus.completed,
    paymentMethod: '네이버페이',
  ),
  PurchaseList(
    itemName: '3000 원두',
    itemType: RefundItemType.beans3000,
    itemPrice: 30000,
    date: DateTime(2025, 7, 24),
    refundStatus: RefundStatus.notRefundable,
    paymentMethod: '토스페이',
  ),
];
