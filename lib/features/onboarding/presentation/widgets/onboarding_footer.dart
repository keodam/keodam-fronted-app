import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:keodam/core/presentation/widgets/basic_lg_button.dart';
import 'package:keodam/core/theme/colors.dart';
import 'package:keodam/core/theme/text_styles.dart';

class OnboardingFooter extends HookWidget  {
  final int currentPage;
  final int totalPages;
  final VoidCallback onPressed;

  const OnboardingFooter({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isLastPage = currentPage == totalPages - 1;

    return Column(
      children: [
        const SizedBox(height: 16),
        isLastPage
            ? BasicLgButton(
          text: "시작하기",
          onPressed: onPressed,
        )
            : SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: onPressed,
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: textBlue02,
              side: BorderSide(
                color:backgroundColor01,
                width: 3.0,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(vertical: 21),
              textStyle: AppTextStyle.bold22,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text("다음"),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
