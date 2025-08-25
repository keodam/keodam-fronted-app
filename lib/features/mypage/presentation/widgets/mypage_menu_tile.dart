import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keodam/core/theme/colors.dart';
import 'package:keodam/core/theme/text_styles.dart';
import 'package:keodam/features/mypage/domain/mypage_menu_title.dart';
import 'package:keodam/features/mypage/domain/util/show_single_button_dialog.dart';
import 'package:keodam/features/mypage/provider/role_provider.dart';

class MypageMenuTile extends ConsumerWidget {
  final MypageMenuTitle title;
  final String iconAssetPath;
  final VoidCallback? onTap;
  final bool showTrailing;

  const MypageMenuTile({
    super.key,
    required this.title,
    required this.iconAssetPath,
    this.onTap,
    this.showTrailing = true,
  });

  void _handleTap(BuildContext context, WidgetRef ref) {
    if (title == MypageMenuTitle.roulette) {
      if (ref.read(userRoleProvider) == Role.mentee) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const SingleButtonDialog(
              title: '현재 설정값이 멘티인 경우\n룰렛을 돌릴 수 없어요!',
              message: '멘토로 전환 후 사용해보아요.',
            );
          },
        );
      } else {
        onTap?.call();
      }
    } else {
      onTap?.call();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        InkWell(
          onTap: () => _handleTap(context, ref),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 16.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      title.label,
                      style: AppTextStyle.regular14.copyWith(color: textGray),
                    ),
                    if (iconAssetPath.isNotEmpty) ...[
                      const SizedBox(width: 8),
                      Image.asset(iconAssetPath, width: 24),
                    ],
                  ],
                ),
                if (showTrailing)
                  const Icon(Icons.chevron_right, color: textBlack),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
