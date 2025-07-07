import 'package:flutter/material.dart';
import 'package:keodam/core/theme/colors.dart';
import 'package:keodam/core/theme/text_styles.dart';
import 'package:keodam/features/mypage/presentation/widgets/mypage_menu_tile.dart';

class EventsSection extends StatelessWidget {
  const EventsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('혜택 및 이벤트', style: AppTextStyle.bold18),
          const SizedBox(height: 16),
          MypageMenuTile(
            title: '돌려 돌려 더 돌려 룰렛',
            iconAssetPath: '',
            onTap: () {},
          ),
          Divider(height: 1, color: backgroundColor01),
          MypageMenuTile(title: '개발자 후원하기', iconAssetPath: '', onTap: () {}),
        ],
      ),
    );
  }
}
