import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:keodam/core/router/routes.dart';
import 'package:keodam/core/theme/colors.dart';
import 'package:keodam/core/theme/text_styles.dart';
import 'package:keodam/features/mypage/data/model/shop_menu_table.dart';
import 'package:keodam/features/mypage/data/model/shop_promotion_menu_table.dart';
import 'package:keodam/features/mypage/presentation/widgets/basic_appbar.dart';
import 'package:keodam/features/mypage/presentation/widgets/shop_product_tile.dart';
import 'package:keodam/features/mypage/provider/user_provider.dart';

class ShopScreen extends ConsumerWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: backgroundColor01,
      appBar: const BasicAppBar(title: '상점'),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: pureWhite),
                child: UserBalanceSection(),
              ),
              SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: backgroundColor01),
                child: Column(
                  children: [
                    PromotionListSection(),
                    BeanProductListSection(),
                    Text(
                      '구매하신 원두는 부분환불이 불가하다는 점 미리 고지드립니다.',
                      style: AppTextStyle.regular12.copyWith(color: textGray),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserBalanceSection extends ConsumerWidget {
  const UserBalanceSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return Column(
      children: [
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Image.asset(
                  'assets/images/mypage/logo_coffee_beans.png',
                  width: 46.85,
                ),
                const SizedBox(height: 10),
                Text(
                  '${user.coffeeCoupon} 원두',
                  style: AppTextStyle.bold18.copyWith(color: textBlack),
                ),
                const SizedBox(height: 6),
                Text(
                  '현재 보유 원두',
                  style: AppTextStyle.regular12.copyWith(color: textGray),
                ),
              ],
            ),
            const SizedBox(width: 60),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset(
                    'assets/images/mypage/logo_rulet_ticket.png',
                    width: 60.19,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '${user.rouletteCoupon} 개',
                  style: AppTextStyle.bold18.copyWith(color: textBlack),
                ),
                const SizedBox(height: 6),
                Text(
                  '현재 보유 룰렛 이용권',
                  style: AppTextStyle.regular12.copyWith(color: textGray),
                ),
                const SizedBox(height: 6),
                //TODO 룰렛 바로가기 버튼 추가
                Text(
                  '룰렛 바로가기',
                  style: AppTextStyle.regular12.copyWith(
                    color: textGray,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 35),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: 70,
              child: TextButton(
                onPressed: () {
                  context.go(
                    '${Routes.mypage}/${Routes.mypageShopScreen}/${Routes.mypagePurchaseHistory}',
                  );
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  textStyle: AppTextStyle.regular14,
                  foregroundColor: textGray,
                ),
                child: Text(
                  '구매내역',
                  style: AppTextStyle.regular14.copyWith(color: textGray),
                ),
              ),
            ),

            SizedBox(
              width: 70,
              child: TextButton(
                onPressed: () {
                  context.go(
                    '${Routes.mypage}/${Routes.mypageShopScreen}/${Routes.mypageWithdraw}',
                  );
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  textStyle: AppTextStyle.regular14,
                  foregroundColor: textGray,
                ),
                child: Text(
                  '환급',
                  style: AppTextStyle.regular14.copyWith(color: textGray),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class PromotionListSection extends ConsumerWidget {
  const PromotionListSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(color: backgroundColor01),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(color: redColor, width: 2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: shopPromotionMenuTable.length,
                        itemBuilder: (context, index) {
                          final item = shopPromotionMenuTable[index];
                          return GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              context.go(
                                '${Routes.mypage}/${Routes.mypageShopScreen}/${Routes.mypagePurchase}',
                                extra: item,
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: ShopProductTile(
                                item: item,
                                isPromotion: true,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: -10,
          left: 16,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            color: backgroundColor01,
            child: Row(
              children: [
                Image.asset(
                  'assets/images/mypage/promotion_icon.png',
                  width: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  '1회 한정 프로모션',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: redColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class BeanProductListSection extends ConsumerWidget {
  const BeanProductListSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: shopMenuTable.length,
        itemBuilder: (context, index) {
          final item = shopMenuTable[index];
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              context.go(
                '${Routes.mypage}/${Routes.mypageShopScreen}/${Routes.mypagePurchase}',
                extra: item,
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: ShopProductTile(item: item, isPromotion: false),
            ),
          );
        },
      ),
    );
  }
}
