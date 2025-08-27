import 'package:flutter/material.dart';
import 'package:keodam/core/theme/text_styles.dart';

class AuthLogoSection extends StatelessWidget {
  const AuthLogoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset('assets/images/login_logo.png', fit: BoxFit.contain, width: 140, height: 111),
          Positioned(
            bottom: 0,
            child: Text('한 잔의 커피, 무한한 가능성의 대화', style: AppTextStyle.bold16, textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }
}
