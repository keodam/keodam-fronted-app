import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:keodam/core/theme/colors.dart';
import 'package:keodam/core/theme/text_styles.dart';
import 'package:keodam/features/mypage/data/model/shop_product_data.dart';

class ShopProductTile extends ConsumerWidget {
  final ShopProduct item;
  final bool isPromotion;
  const ShopProductTile({
    super.key,
    required this.item,
    required this.isPromotion,
  });

  static final _currencyFormatter = NumberFormat.currency(
    locale: 'ko_KR',
    symbol: '₩',
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(item.itemType.imageAssetName, width: 55),
              SizedBox(width: 11),
              Text(
                item.itemName,
                style: AppTextStyle.semiBold16.copyWith(color: textBlack),
              ),
            ],
          ),
          Column(
            children: [
              SizedBox(height: 15),
              Container(
                constraints: const BoxConstraints(minWidth: 95.53),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: pointColor529DFF,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  item.itemPrice == 0
                      ? '무료'
                      : _currencyFormatter.format(item.itemPrice),
                  textAlign: TextAlign.center,
                  style: AppTextStyle.regular14.copyWith(color: pureWhite),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                isPromotion
                    ? "1회 한정"
                    : _currencyFormatter.format(item.itemDiscountLabel),
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  decoration:
                      isPromotion
                          ? TextDecoration.none
                          : TextDecoration.lineThrough,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
