import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';

class AppStartPromptWidget extends HookWidget  {
  const AppStartPromptWidget({super.key});

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
                      '이제',
                      style: AppTextStyle.bold22.copyWith(color: textBlack),
                    ),
                    Text(
                      ' 시작',
                      style: AppTextStyle.bold22.copyWith(color: textBlue02),
                    ),
                    Text(
                      ' 해볼까요?',
                      style: AppTextStyle.bold22.copyWith(color: textBlack),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '커피와 담소 앱에서',
                      style: AppTextStyle.bold14.copyWith(color: textBlack),
                    ),
                    Text(
                      ' 멘토',
                      style: AppTextStyle.bold14.copyWith(color: textBlue02),
                    ),
                    Text(
                      '로 활동하면,',
                      style: AppTextStyle.bold14.copyWith(color: textBlack),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '레벨',
                      style: AppTextStyle.bold14.copyWith(color: textBlue02),
                    ),
                    Text(
                      ' 을 높이고 다양한',
                      style: AppTextStyle.bold14.copyWith(color: textBlack),
                    ),
                    Text(
                      ' 이벤트에 참여할 수 있어요!',
                      style: AppTextStyle.bold14.copyWith(color: textBlue02),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  '이제 다음 버튼을 눌러\n'
                  '커피 한잔의 여유, 커답 앱 사용을 시작해보세요!',
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
                    'assets/images/onboarding/onboarding_start_prompt.png',
                    height: 280,
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
