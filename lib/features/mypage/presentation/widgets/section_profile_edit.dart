import 'package:flutter/material.dart';
import 'package:keodam/core/theme/colors.dart';
import 'package:keodam/core/theme/text_styles.dart';
import 'package:keodam/features/mypage/domain/mypage_menu_title.dart';
import 'package:keodam/features/mypage/presentation/widgets/mypage_menu_tile.dart';

class ProfileEditSection extends StatelessWidget {
  const ProfileEditSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('프로필 관리', style: AppTextStyle.bold18),
          const SizedBox(height: 16),
          MypageMenuTile(
            title: MypageMenuTitle.editMentorProfile,
            iconAssetPath: 'assets/images/mypage/icon_mentor.png',
            onTap: () {
              Navigator.pushNamed(context, '/edit');
            },
          ),
          Divider(height: 1, color: backgroundColor01),
          MypageMenuTile(
            title: MypageMenuTitle.editMenteeProfile,
            iconAssetPath: 'assets/images/mypage/icon_mentee.png',
            onTap: () {
              Navigator.pushNamed(context, '/edit');
            },
          ),
          Divider(height: 1, color: backgroundColor01),
          MypageMenuTile(
            title: MypageMenuTitle.certifyStatus,
            iconAssetPath: 'assets/images/mypage/icon_certified_badge.png',
            onTap: () {
              Navigator.pushNamed(context, '/edit');
            },
          ),
        ],
      ),
    );
  }
}
