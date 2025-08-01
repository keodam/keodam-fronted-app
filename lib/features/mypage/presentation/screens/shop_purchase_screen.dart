import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keodam/core/theme/colors.dart';
import 'package:keodam/core/theme/text_styles.dart';
import 'package:keodam/features/mypage/data/model/shop_product_data.dart';
import 'package:keodam/features/mypage/presentation/widgets/basic_appbar.dart';
import 'package:intl/intl.dart';

class ShopPurchaseScreen extends ConsumerWidget {
  final ShopProduct shopProductItem;

  const ShopPurchaseScreen({super.key, required this.shopProductItem});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: BasicAppBar(title: '결제'),
      body: Center(child: PurchaseSection(shopProductItem: shopProductItem)),
    );
  }
}

class PurchaseSection extends ConsumerWidget {
  final ShopProduct shopProductItem;

  const PurchaseSection({super.key, required this.shopProductItem});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formatter = NumberFormat.currency(locale: 'ko_KR', symbol: '₩');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Row(
            children: [
              Image.asset(shopProductItem.itemType.imageAssetName, width: 63),
              const SizedBox(width: 10),
              Text(
                shopProductItem.itemName,
                style: AppTextStyle.bold18.copyWith(color: textBlack),
              ),
              const Spacer(),
              Text(
                formatter.format(shopProductItem.itemPrice),
                style: AppTextStyle.bold24.copyWith(color: textBlack),
              ),
              SizedBox(width: 10),
            ],
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '원두는 별도의 유효기간이 없습니다.',
              style: AppTextStyle.regular12.copyWith(color: textGray),
            ),
          ),
        ],
      ),
    );
  }
}
