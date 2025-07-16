import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keodam/core/theme/colors.dart';
import 'package:keodam/core/theme/text_styles.dart';
import 'package:keodam/features/mypage/data/model/mentee_level_table.dart';
import 'package:keodam/features/mypage/presentation/widgets/basic_appbar.dart';
import 'package:keodam/features/mypage/presentation/widgets/section_divider.dart';

class MenteeLevelGuide extends ConsumerWidget {
  const MenteeLevelGuide({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: BasicAppBar(title: '멘티 매너온도 안내'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Container(
                          width: 41,
                          height: 134,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Color(0xffF1F1F1), Color(0xff529DFF)],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 41,
                          child: DottedLine(
                            dashLength: 1,
                            dashGapLength: 1,
                            lineThickness: 0.5,
                            dashColor: Colors.white,
                          ),
                        ),

                        Container(
                          width: 41,
                          height: 134,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Color(0xff529DFF), Color(0xffD67DF9)],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 41,
                          child: DottedLine(
                            dashLength: 1,
                            dashGapLength: 1,
                            lineThickness: 0.5,
                            dashColor: Colors.white,
                          ),
                        ),
                        Container(
                          width: 41,
                          height: 134,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Color(0xffD67DF9), Color(0xffFF00AA)],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 41,
                          child: DottedLine(
                            dashLength: 1,
                            dashGapLength: 1,
                            lineThickness: 0.5,
                            dashColor: Colors.white,
                          ),
                        ),
                        Container(
                          width: 41,
                          height: 134,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Color(0xffFF00AA), Color(0xffFF604E)],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 41,
                          child: DottedLine(
                            dashLength: 1,
                            dashGapLength: 1,
                            lineThickness: 0.5,
                            dashColor: Colors.white,
                          ),
                        ),
                        Container(
                          width: 41,
                          height: 134,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Color(0xffFF604E), Color(0xffFF8356)],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 41,
                          child: DottedLine(
                            dashLength: 1,
                            dashGapLength: 1,
                            lineThickness: 0.5,
                            dashColor: Colors.white,
                          ),
                        ),
                        Container(
                          width: 41,
                          height: 134,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Color(0xffFF8356), Color(0xffFFB957)],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 41,
                          child: DottedLine(
                            dashLength: 1,
                            dashGapLength: 1,
                            lineThickness: 0.5,
                            dashColor: Colors.white,
                          ),
                        ),

                        Container(
                          width: 41,
                          height: 134,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Color(0xffFFB957), Color(0xffFFF457)],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 41,
                          child: DottedLine(
                            dashLength: 1,
                            dashGapLength: 1,
                            lineThickness: 0.5,
                            dashColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: levelTable.length,
                        separatorBuilder:
                            (context, index) => SectionDivider(height: 1.5),
                        itemBuilder: (context, index) {
                          final level = levelTable[index];
                          final averageTemp =
                              ((level.minDegree + level.maxDegree) / 2).round();

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 25),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Image.asset(level.image, width: 44),
                                    const SizedBox(height: 6),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          100,
                                        ),
                                        border: Border.all(
                                          color: backgroundColor01,
                                          width: 1.5,
                                        ),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 23,
                                        vertical: 8,
                                      ),
                                      child: Text(
                                        index == 1
                                            ? '20℃'
                                            : index == 2
                                            ? '35℃'
                                            : index == 6
                                            ? '75℃'
                                            : '$averageTemp℃',
                                        style: AppTextStyle.medium12.copyWith(
                                          color: level.color,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 17),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      index == 1
                                          ? '20℃'
                                          : index == 2
                                          ? '35℃ (기본온도)'
                                          : index == 6
                                          ? '75℃'
                                          : '$averageTemp℃',

                                      style: AppTextStyle.bold18.copyWith(
                                        color: textBlack,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      index == 0 ? '15℃ 도달 시, 15일간 이용 정지' : '',
                                      style: AppTextStyle.regular12.copyWith(
                                        color: textGray,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
