import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keodam/core/theme/colors.dart';
import 'package:keodam/core/theme/text_styles.dart';
import 'package:keodam/features/mypage/provider/role_provider.dart';

class RoleToggleCard extends ConsumerWidget {
  const RoleToggleCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(userRoleProvider);
    final roleNotifier = ref.read(userRoleProvider.notifier);

    final isMentee = role == Role.mentee;

    return Container(
      color: const Color(0xffADD7FD),
      height: 90.96,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('멘토 - 멘티 전환 기능', style: AppTextStyle.bold16),
              Text(
                '현재 설정값 : ${isMentee ? '멘티' : '멘토'}',
                style: AppTextStyle.regular12.copyWith(color: textGray),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${isMentee ? '멘토로' : '멘티로'} 전환합니다',
                style: AppTextStyle.bold16.copyWith(color: textBlue02),
              ),
              FlutterSwitch(
                width: 62,
                padding: 2,
                toggleSize: 30,
                value: isMentee,
                onToggle: (val) => roleNotifier.toggle(),
                activeColor: const Color.fromRGBO(255, 255, 255, 0.16),
                inactiveColor: const Color.fromRGBO(255, 255, 255, 0.16),
                toggleColor: pureWhite,
                showOnOff: false,
                activeIcon: Image.asset(
                  'assets/images/mypage/icon_mentee.png',

                  width: 28,
                  height: 28,
                ),
                inactiveIcon: Image.asset(
                  'assets/images/mypage/icon_mentor.png',
                  width: 28,
                  height: 28,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
