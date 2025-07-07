import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keodam/features/mypage/domain/role_provider.dart';
import 'package:keodam/features/mypage/domain/user_provider.dart';
import 'package:keodam/features/mypage/presentation/widgets/matching_info_tile.dart';
import 'package:keodam/features/mypage/presentation/widgets/mentee_degree_card.dart';
import 'package:keodam/features/mypage/presentation/widgets/mento_level_card.dart'
    show MentoLevelCard;
import 'package:keodam/features/mypage/presentation/widgets/shop_header.dart';
import 'package:keodam/features/mypage/presentation/widgets/user_profile_tile.dart';

class ProfileStateSection extends ConsumerWidget {
  const ProfileStateSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final isMentor = ref.watch(isMenteeProvider);
    return Padding(
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
          isMentor
              ? MentoLevelCard(currentExp: user.currentExp)
              : MenteeDegreeCard(currentDegree: user.currentDegree),

          const SizedBox(height: 25),
          UserInfoCard(
            nickname: user.nickname,
            email: user.email,
            phoneNumber: user.phoneNumber,
            profileImageUrl: user.profileImageUrl,
          ),
        ],
      ),
    );
  }
}
