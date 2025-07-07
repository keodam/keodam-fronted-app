import 'package:flutter/material.dart';
import 'package:keodam/core/theme/colors.dart';
import 'package:keodam/core/theme/text_styles.dart';
import 'package:keodam/features/mypage/domain/user_provider.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppInfoTile extends ConsumerWidget {
  const AppInfoTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '앱 버전 / 계정 고유 아이디',
            style: AppTextStyle.regular14.copyWith(color: textGray),
          ),
          Text(
            '${user.appVersion} / ${user.uniqueId}',
            style: AppTextStyle.regular14.copyWith(color: textGray),
          ),
        ],
      ),
    );
  }
}
