import 'package:flutter/material.dart';
import 'package:keodam/core/theme/text_styles.dart';
import 'package:keodam/core/theme/colors.dart';

class RoleToggleCard extends StatelessWidget {
  final bool isMentor =
      true; // This should be replaced with actual state management logic
  const RoleToggleCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffADD7FD),
      height: 90.96,
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('멘토 - 멘티 전환 기능', style: AppTextStyle.bold16),
              Text(
                '현재 설정값 : 멘토',
                style: AppTextStyle.regular12.copyWith(color: textGray),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                '멘티로 전환합니다',
                style: AppTextStyle.bold16.copyWith(color: textBlue02),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
