import 'package:flutter/material.dart';
import 'package:keodam/core/theme/colors.dart';
import 'package:keodam/core/theme/text_styles.dart';

class AuthBottomText extends StatelessWidget {
  const AuthBottomText({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 40,
      left: 0,
      right: 0,
      child: Center(
        child: Text('아직 계정이 없다면, 버튼을 눌러 자동으로 회원가입으로 연결돼요', style: AppTextStyle.regular12.copyWith(color: textGray)),
      ),
    );
  }
}
