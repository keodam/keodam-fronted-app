import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:keodam/core/theme/colors.dart';
import 'package:keodam/core/theme/text_styles.dart';
import 'package:keodam/features/mypage/data/model/mento_level.dart';
import 'package:keodam/features/mypage/data/model/mento_level_table.dart';
import 'package:keodam/features/mypage/presentation/widgets/section_divider.dart';

class MentoLevelGuide extends ConsumerWidget {
  const MentoLevelGuide({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const String backarrowIcon = 'assets/icons/backarrow.svg';

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: Text(
          '멘토 등급안내',
          style: AppTextStyle.extraBold20.copyWith(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(backarrowIcon),
          onPressed: () {
            context.pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SectionDivider(height: 7),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 20,
              ),
              child: Column(
                children:
                    levelTable
                        .map(
                          (level) => Column(
                            children: [
                              _LevelRow(level),
                              const SectionDivider(height: 1.5),
                            ],
                          ),
                        )
                        .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LevelRow extends StatelessWidget {
  final MentoLevelInfo level;

  const _LevelRow(this.level);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 20),
      child: Row(
        children: [
          Image.asset(level.image, width: 44),
          const SizedBox(width: 40),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: backgroundColor01, width: 1.5),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Text(
                      'Lv. ${level.level}',
                      style: AppTextStyle.regular12.copyWith(color: textBlack),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    level.title,
                    style: AppTextStyle.bold18.copyWith(color: textBlack),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                '획득해야할 경험치 ${level.minExp} - ${level.maxExp}',
                style: AppTextStyle.regular14.copyWith(color: textGray),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
