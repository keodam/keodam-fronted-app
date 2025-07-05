import 'package:flutter/material.dart';
import 'package:keodam/core/theme/colors.dart';
import 'package:keodam/features/mypage/domain/user_provider.dart';
import 'package:keodam/features/mypage/presentation/widgets/matching_info_item.dart';
import 'package:keodam/features/mypage/presentation/widgets/mento_level_card.dart';
import 'package:keodam/features/mypage/presentation/widgets/mentor_toggle_card.dart';
import 'package:keodam/features/mypage/presentation/widgets/user_profile_tile.dart';
import 'package:keodam/features/mypage/presentation/widgets/shop_header.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MypageScreen extends ConsumerWidget {
  const MypageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 33),
            const RoleToggleCard(),
            Container(height: 32, color: backGray),
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  ShopHeader(
                    beanAmount: user.beanAmount,
                    ticketAmount: user.ticketAmount,
                  ),
                  const SizedBox(height: 19),
                  MatchingInfoItem(
                    coffeeChatCount: user.coffeeChatCount,
                    receivedLikes: user.receivedLikes,
                  ),
                  const SizedBox(height: 33),
                  MentoLevelCard(currentExp: user.currentExp),
                  const SizedBox(height: 25),
                  UserInfoCard(
                    nickname: user.nickname,
                    email: user.email,
                    phoneNumber: user.phoneNumber,
                    profileImageUrl: user.profileImageUrl,
                  ),
                ],
              ),
            ),
            Container(height: 12, color: backGray),
          ],
        ),
      ),
    );
  }
}
