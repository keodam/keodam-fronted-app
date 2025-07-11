import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keodam/core/theme/text_styles.dart';
import 'package:keodam/core/theme/colors.dart';
import 'package:keodam/features/mypage/domain/user_provider.dart';

class MatchingInfoItem extends ConsumerWidget {
  const MatchingInfoItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _StatItem(value: user.matches.toString(), label: '커피챗 매칭 횟수'),
        Container(height: 45, width: 2, color: backgroundColor01),
        _StatItem(value: user.receivedLikes.toString(), label: '받은 프로필 좋아요'),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: AppTextStyle.bold20.copyWith(color: textBlue02)),
        Text(label, style: AppTextStyle.regular12.copyWith(color: textBlack)),
      ],
    );
  }
}
