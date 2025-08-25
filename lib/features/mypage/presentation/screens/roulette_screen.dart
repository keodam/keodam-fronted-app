import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:keodam/core/presentation/widgets/basic_lg_button.dart';
import 'package:keodam/core/router/routes.dart';
import 'package:keodam/core/theme/colors.dart';
import 'package:keodam/core/theme/text_styles.dart';
import 'package:keodam/features/mypage/presentation/widgets/basic_appbar.dart';
import 'package:keodam/features/mypage/presentation/widgets/roulette_wheel.dart';
import 'package:keodam/features/mypage/provider/roulette_provider.dart';

class RouletteScreen extends ConsumerWidget {
  const RouletteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: BasicAppBar(title: '돌려 돌려 더 돌려 룰렛'),
      body: SingleChildScrollView(
        child: Column(children: [RouletteSection(), ButtonSection()]),
      ),
    );
  }
}

class ButtonSection extends ConsumerWidget {
  const ButtonSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
        child: BasicLgButton(
          text: '커피쿠폰 교환신청하기',
          onPressed: () {
            context.go(
              '${Routes.mypage}/${Routes.mypageRoulette}/${Routes.mypageCoffeeExchangeRequest}',
            );
          },
        ),
      ),
    );
  }
}

class RouletteSection extends ConsumerWidget {
  const RouletteSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          colors: [pureWhite, Color(0xffE4E4E4)],
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Text(
              '룰렛을 돌려 커피 기프티콘 교환권을 얻어보세요!',
              style: AppTextStyle.medium16.copyWith(color: textBlack),
            ),
          ),
          CustomRouletteWheel(),
          const SizedBox(height: 30),
          TicketSection(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class TicketSection extends ConsumerWidget {
  const TicketSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roulette = ref.watch(rouletteProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                'assets/images/mypage/logo_roulette_ticket.png',
                width: 42.63,
              ),
              SizedBox(width: 14),
              Text(
                '내 보유 룰렛 이용권 : ${roulette.rouletteCoupon}개',
                style: AppTextStyle.medium12.copyWith(color: textBlack),
              ),
            ],
          ),
          SizedBox(height: 7),
          Row(
            children: [
              Image.asset(
                'assets/images/mypage/logo_roulette_coffee_ticket.png',
                width: 42.63,
              ),
              SizedBox(width: 14),
              Text(
                '내 보유 커피 기프티콘 교환권 : ${roulette.coffeeCoupon}개',
                style: AppTextStyle.medium12,
              ),
            ],
          ),
          SizedBox(height: 9),
          Text(
            '무료 룰렛 이용권 받기',
            style: AppTextStyle.medium12.copyWith(
              color: textBlack,
              decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }
}
