import 'package:flutter/material.dart';
import 'package:keodam_app/features/auth/presentation/constants/sign_up_profile_constants.dart';
import 'package:keodam_app/styles/app_colors.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: SignUpProfileConstants.header,
            children: [
              const TextSpan(text: SignUpProfileConstants.welcomeHeader1),
              TextSpan(
                text: SignUpProfileConstants.welcomeHeader2,
                style: SignUpProfileConstants.header.copyWith(color: AppColors.primary)
              ),
              const TextSpan(text: SignUpProfileConstants.welcomeDesc1),
            ],
          ),
        ),
        SignUpProfileConstants.headerBottomHeightBox,
        const Text(
          SignUpProfileConstants.welcomeDesc2,
          style: SignUpProfileConstants.headerDesc,
        ),
      ],
    );
  }
}
