import 'package:flutter/material.dart';
import 'package:keodam/core/theme/colors.dart';
import 'package:keodam/core/theme/text_styles.dart';
import 'package:keodam/features/mypage/domain/mypage_menu_title.dart';
import 'package:keodam/features/mypage/presentation/widgets/app_info_tile.dart';
import 'package:keodam/features/mypage/presentation/widgets/mypage_menu_tile.dart';

class UserSupportSection extends StatelessWidget {
  const UserSupportSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('이용 내역 및 정보', style: AppTextStyle.bold18),
          const SizedBox(height: 16),
          MypageMenuTile(
            title: MypageMenuTitle.contactSupport,
            showTrailing: false,
            iconAssetPath: '',
            onTap: () {},
          ),
          Divider(height: 2, color: backgroundColor01),
          MypageMenuTile(
            title: MypageMenuTitle.viewMatchingHistory,
            showTrailing: false,
            iconAssetPath: '',
            onTap: () {},
          ),
          Divider(height: 2, color: backgroundColor01),
          MypageMenuTile(
            title: MypageMenuTitle.manageBlockedUsers,
            showTrailing: false,
            iconAssetPath: '',
            onTap: () {},
          ),
          Divider(height: 2, color: backgroundColor01),
          MypageMenuTile(
            title: MypageMenuTitle.viewPolicies,
            showTrailing: false,
            iconAssetPath: '',
            onTap: () {},
          ),
          Divider(height: 2, color: backgroundColor01),
          MypageMenuTile(
            title: MypageMenuTitle.deleteAccount,
            showTrailing: false,
            iconAssetPath: '',
            onTap: () {},
          ),
          Divider(height: 2, color: backgroundColor01),
          AppInfoTile(),
        ],
      ),
    );
  }
}
