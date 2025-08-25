import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:keodam/core/router/routes.dart';
import 'package:keodam/core/theme/colors.dart';
import 'package:keodam/core/theme/text_styles.dart';
import 'package:keodam/features/mypage/presentation/widgets/basic_appbar.dart';
import 'package:keodam/features/mypage/presentation/widgets/section_divider.dart';

class ContactSupportScreen extends ConsumerWidget {
  const ContactSupportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: BasicAppBar(title: '고객센터'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            KakaoChannelTalk(),
            SectionDivider(height: 1.5),
            ContactSupportTile(
              title: '자주묻는질문',
              onTap: () {
                context.go(
                  '${Routes.mypage}/${Routes.mypageContactSupport}/${Routes.mypageContactSupportFaq}',
                );
              },
            ),
            SectionDivider(height: 1.5),
            ContactSupportTile(
              title: '이용약관 및 개인정보 처리 방침',
              onTap: () {
                //TODO: 개인정보 수집 및 이용약관 전문(B3)으로 이동
              },
            ),
            SectionDivider(height: 1.5),
            ContactSupportTile(
              title: '도움말',
              onTap: () {
                //TODO: 커담이용가이드 페이지
              },
            ),
            SectionDivider(height: 1.5),
          ],
        ),
      ),
    );
  }
}

class KakaoChannelTalk extends ConsumerWidget {
  const KakaoChannelTalk({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        //TODO: 카카오톡 채널 연결
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30.0),
        child: Row(
          children: [
            Image.asset('assets/images/mypage/kakao_logo.png', width: 52),
            SizedBox(width: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '카카오톡 채널톡으로 문의하기',
                  style: AppTextStyle.medium16.copyWith(color: textBlack),
                ),
                SizedBox(height: 8.0),
                Text(
                  '문의시간 : 평일 오전 9:00 ~ 오후 6:00',
                  style: AppTextStyle.regular12.copyWith(color: textBlack),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ContactSupportTile extends ConsumerWidget {
  final String title;
  final VoidCallback? onTap;
  const ContactSupportTile({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Text(
                title,
                style: AppTextStyle.medium16.copyWith(color: textBlack),
              ),
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
