import 'package:flutter/material.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';
import 'package:flutter_hooks/flutter_hooks.dart';


class AppHowToUseWidget extends HookWidget  {
  const AppHowToUseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '커피챗 서비스',
                      style: AppTextStyle.bold22.copyWith(color: textBlue02),
                    ),
                    Text(
                      ' 어떻게 이용할까요?',
                      style: AppTextStyle.bold22.copyWith(color: textBlack),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'KEODAM에서는',
                      style: AppTextStyle.bold14.copyWith(color: textBlack),
                    ),
                    Text(
                      ' 대면 커피챗',
                      style: AppTextStyle.bold14.copyWith(color: textBlue02),
                    ),
                    Text(
                      ' 만남을 할 수 있어요',
                      style: AppTextStyle.bold14.copyWith(color: textBlack),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  '자신의 프로필을 5분만에 작성하고\n'
                  '원하는 사용자에게 매칭 요청을 보내보세요!',
                  style: AppTextStyle.regular12.copyWith(color: textGray),
                ),
              ],
            ),
          ),
          SizedBox(height: 22),
          SizedBox(
            height: 300,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/onboarding/onboarding_how_to.png',
                    height: 220,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '커피챗이란, "멘티와 멘토가 같이 커피 한 잔을 나누며,',
                    style: AppTextStyle.regular12.copyWith(color: textGray),
                  ),
                  Text(
                    '멘티에게 도움이 될 다양한 정보와 조언을',
                    style: AppTextStyle.regular12.copyWith(color: textGray),
                  ),
                  Text(
                    '자유롭게 주고받는 새로운 문화" 입니다.',
                    style: AppTextStyle.regular12.copyWith(color: textGray),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
