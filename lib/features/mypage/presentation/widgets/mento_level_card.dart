import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:keodam/core/theme/colors.dart';
import 'package:keodam/core/theme/text_styles.dart';
import 'package:keodam/features/mypage/provider/user_provider.dart';
import 'package:keodam/features/mypage/data/util/get_mento_level.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class MentoLevelCard extends ConsumerWidget {
  const MentoLevelCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentExp = ref.watch(userProvider).currentExp;
    final levelInfo = getMentoLevelInfo(currentExp);
    final percent =
        (currentExp - levelInfo.minExp) / (levelInfo.maxExp - levelInfo.minExp);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Image.asset(levelInfo.image, width: 40),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Lv.${levelInfo.level} ${levelInfo.title}',
                          style: AppTextStyle.bold16.copyWith(color: textBlack),
                        ),
                        SvgPicture.asset('assets/icons/share.svg'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return LinearPercentIndicator(
                        width: constraints.maxWidth,
                        lineHeight: 22.21,
                        percent: percent,
                        backgroundColor: backgroundColor01,
                        progressColor: levelInfo.color,
                        barRadius: const Radius.circular(20),
                        progressBorderColor: backgroundColor01,
                      );
                    },
                  ),
                  const SizedBox(height: 4),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '현재 경험치: $currentExp/${levelInfo.maxExp}',
            style: AppTextStyle.regular14.copyWith(color: textGray),
          ),
        ),
      ],
    );
  }
}
