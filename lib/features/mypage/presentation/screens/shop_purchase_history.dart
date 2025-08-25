import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:keodam/core/router/routes.dart';
import 'package:keodam/core/theme/colors.dart';
import 'package:keodam/core/theme/text_styles.dart';
import 'package:keodam/features/mypage/data/model/refund_item_type.dart';
import 'package:keodam/features/mypage/data/model/refund_status.dart';
import 'package:keodam/features/mypage/presentation/widgets/basic_appbar.dart';
import 'package:keodam/features/mypage/presentation/widgets/section_divider.dart';
import 'package:keodam/features/mypage/provider/purchase_history_provider.dart';

class PurchaseHistoryScreen extends ConsumerWidget {
  const PurchaseHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: BasicAppBar(title: '구매내역'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PurchaseHistoryItem(),
            SizedBox(height: 40),
            NoticeScript(),
          ],
        ),
      ),
    );
  }
}

class PurchaseHistoryItem extends ConsumerWidget {
  const PurchaseHistoryItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currencyFormatter = NumberFormat.currency(
      locale: 'ko_KR',
      symbol: '₩',
    );
    final purchaseList = ref.watch(purchaseHistoryProvider);

    final sortedPurchaseList = [...purchaseList]
      ..sort((a, b) => b.date.compareTo(a.date));

    return SizedBox(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: sortedPurchaseList.length,
        itemBuilder: (context, index) {
          final item = sortedPurchaseList[index];

          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap:
                item.refundStatus == RefundStatus.refundable
                    ? () {
                      context.go(
                        '${Routes.mypage}/${Routes.mypageShopScreen}/${Routes.mypagePurchaseHistory}/${Routes.mypageRefundDetail}',
                        extra: item,
                      );
                    }
                    : null,

            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${item.date.year}.${item.date.month}.${item.date.day}',
                        style: AppTextStyle.regular12.copyWith(color: textGray),
                      ),
                      const SizedBox(height: 9),
                      Row(
                        children: [
                          Image.asset(item.itemType.imageAssetName, width: 45),
                          const SizedBox(width: 10),
                          Text(
                            item.itemName,
                            style: AppTextStyle.bold16.copyWith(
                              color: textBlack,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            currencyFormatter.format(item.itemPrice),
                            style: AppTextStyle.bold16.copyWith(
                              color: textBlack,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 9),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '결제수단 | ${item.paymentMethod ?? '--------'}',
                            style: AppTextStyle.regular12.copyWith(
                              color: textGray,
                            ),
                          ),
                          Container(
                            width: 75,
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            decoration: BoxDecoration(
                              color: item.refundStatus.tagColor,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(
                              textAlign: TextAlign.center,
                              item.refundStatus.displayName,
                              style: AppTextStyle.medium12.copyWith(
                                color: pureWhite,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SectionDivider(height: 1.5),
              ],
            ),
          );
        },
      ),
    );
  }
}

class NoticeScript extends ConsumerWidget {
  const NoticeScript({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text.rich(
        TextSpan(
          style: AppTextStyle.regular12.copyWith(color: textGray),
          children: [
            TextSpan(
              text:
                  '원두 환급은 커피챗 매칭을 통해 얻은 원두에 한해 가능합니다.\n환급은 영업일 기준 3~7일 소요될 수 있습니다. \n\n룰렛으로 얻은 원두는 환불이 불가합니다. \n\n또한, 환급 시 20%의 수수료가 부가됩니다. \n원두는 1,200 원두부터 환급 가능합니다. \n자세한 내용은 ',
            ),
            //TODO:A4(이용약관 페이지 연결)
            TextSpan(
              text: '이용약관 중 청약철회',
              style: AppTextStyle.regular12.copyWith(
                color: textGray,
                decoration: TextDecoration.underline,
              ),
            ),
            TextSpan(text: '에 관한 방침을 확인해주시기 바랍니다.'),
          ],
        ),
      ),
    );
  }
}
