import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keodam/core/theme/colors.dart';
import 'package:keodam/core/theme/text_styles.dart';
import 'package:keodam/features/mypage/data/model/mentee_level_table.dart';
import 'package:keodam/features/mypage/data/util/get_mentee_level.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keodam/features/mypage/provider/user_provider.dart';

class MenteeDegreeCard extends ConsumerWidget {
  const MenteeDegreeCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentDegree = ref.watch(userProvider).currentDegree;
    final levelInfo = getMenteeLevelInfo(currentDegree);

    final int currentIndex = levelTable.indexOf(levelInfo);
    final int maxIndex = levelTable.length - 1;
    final double percent = (currentIndex + 1) / (maxIndex + 1);

    return Row(
      children: [
        Column(
          children: [
            Image.asset(levelInfo.image, width: 30),
            const SizedBox(height: 5),
            Container(
              alignment: Alignment.center,
              width: 70,
              height: 25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: backgroundColor01, width: 1.5),
              ),
              child: Text(
                '$currentDegree℃',
                style: AppTextStyle.bold14.copyWith(color: levelInfo.color),
              ),
            ),
          ],
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$currentDegree℃',
                      style: AppTextStyle.bold16.copyWith(color: textBlack),
                    ),
                    SvgPicture.asset('assets/icons/share.svg'),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              LayoutBuilder(
                builder: (context, constraints) {
                  return LinearPercentIndicator(
                    width: constraints.maxWidth,
                    lineHeight: 25,
                    percent: percent,
                    backgroundColor: backgroundColor01,
                    progressColor: levelInfo.color,
                    barRadius: const Radius.circular(20),
                    progressBorderColor: backgroundColor01,
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
