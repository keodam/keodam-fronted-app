import 'package:flutter/material.dart';
import 'package:keodam/core/theme/colors.dart';
import 'package:keodam/core/theme/text_styles.dart';
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
            title: '고객센터 문의하기',
            showTrailing: false,
            iconAssetPath: '',
            onTap: () {},
          ),
          Divider(height: 2, color: backgroundColor01),
          MypageMenuTile(
            title: '매칭 내역 확인',
            showTrailing: false,
            iconAssetPath: '',
            onTap: () {},
          ),
          Divider(height: 2, color: backgroundColor01),
          MypageMenuTile(
            title: '차단내역 관리',
            showTrailing: false,
            iconAssetPath: '',
            onTap: () {},
          ),
          Divider(height: 2, color: backgroundColor01),
          MypageMenuTile(
            title: '이용약관 및 개인정보 처리 방침',
            showTrailing: false,
            iconAssetPath: '',
            onTap: () {},
          ),
          Divider(height: 2, color: backgroundColor01),
          MypageMenuTile(
            title: '회원 탈퇴',
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
