import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keodam/core/theme/colors.dart';
import 'package:keodam/core/theme/text_styles.dart';
import 'package:keodam/features/mypage/presentation/widgets/basic_appbar.dart';
import 'package:keodam/features/mypage/presentation/widgets/profile_edit_option_tile.dart';

class CommunityProfileEdit extends ConsumerWidget {
  const CommunityProfileEdit({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: BasicAppBar(title: '커뮤니티 프로필 수정'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '수정할 항목을 선택해주세요.',
              style: AppTextStyle.medium16.copyWith(color: textBlack),
            ),
            SizedBox(height: 14),

            ProfileEditOptionTile(title: '닉네임 수정', onTap: () {}),
            SizedBox(height: 14),
            ProfileEditOptionTile(title: '프로필 사진 수정', onTap: () {}),
            SizedBox(height: 14),
            ProfileEditOptionTile(title: '재학 상태 수정', onTap: () {}),
          ],
        ),
      ),
    );
  }
}
