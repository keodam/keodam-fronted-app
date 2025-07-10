import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';


import '../../../../core/theme/colors.dart';
import '../../../../core/theme/text_styles.dart';

class AppUseCasesWidget extends HookWidget  {
  const AppUseCasesWidget({super.key});

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
                      '커담은',
                      style: AppTextStyle.bold22.copyWith(color: textBlack),
                    ),
                    Text(
                      ' 이럴때!',
                      style: AppTextStyle.bold22.copyWith(color: textBlue02),
                    ),
                    Text(
                      ' 유용해요',
                      style: AppTextStyle.bold22.copyWith(color: textBlack),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '선후배 또는 졸업생과의 교류가 필요할 때',
                      style: AppTextStyle.bold14.copyWith(color: textBlack),
                    ),
                    Row(
                      children: [
                        Text(
                          '멘토링',
                          style: AppTextStyle.bold14.copyWith(
                            color: textBlue02,
                          ),
                        ),
                        Text(
                          '을 통해 서로가 성장할 수 있는 곳이에요',
                          style: AppTextStyle.bold14.copyWith(color: textBlack),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  '교수님, 선배, 취준생, 신입생 등 기타 다양한 이용자의\n'
                  '프로필을 열람해보고, 질문과 대화가 가능해요',
                  style: AppTextStyle.regular12.copyWith(color: textGray),
                ),
              ],
            ),
          ),

          const SizedBox(height: 22),

          SizedBox(
            height: 300,
            width: double.infinity,
            child: Center(
              child: Image.asset(
                'assets/images/onboarding/onboarding_use_cases.png',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
