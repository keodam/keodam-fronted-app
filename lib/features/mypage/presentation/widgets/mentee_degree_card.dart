import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keodam/core/theme/colors.dart';
import 'package:keodam/core/theme/text_styles.dart';
import 'package:keodam/features/mypage/domain/mentee_level_info.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class MenteeDegreeCard extends StatelessWidget {
  final int currentDegree;

  const MenteeDegreeCard({super.key, required this.currentDegree});

  @override
  Widget build(BuildContext context) {
    final levelInfo = getLevelInfo(currentDegree);
    final int currentIndex = levelTable.indexOf(levelInfo);
    final int maxIndex = levelTable.length - 1;

    // 전체 퍼센트 계산 (단계 진행도)
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
