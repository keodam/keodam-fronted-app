import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:keodam/core/theme/colors.dart';
import 'package:keodam/core/theme/text_styles.dart';
import 'package:keodam/features/mypage/domain/level_info.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class MentoLevelCard extends StatelessWidget {
  final int currentExp;

  const MentoLevelCard({super.key, required this.currentExp});

  @override
  Widget build(BuildContext context) {
    final levelInfo = getLevelInfo(currentExp);
    final percent =
        (currentExp - levelInfo.minExp) / (levelInfo.maxExp - levelInfo.minExp);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(levelInfo.image, height: 59.51),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
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
                  );
                },
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  '현재 경험치: $currentExp/${levelInfo.maxExp}',
                  style: AppTextStyle.regular14.copyWith(color: textGray),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
