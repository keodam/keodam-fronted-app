import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:keodam/features/onboarding/domain/onboarding_pages.dart';

class OnboardingPager extends HookWidget  {
  final PageController controller;
  final void Function(int) onPageChanged;

  const OnboardingPager({
    super.key,
    required this.controller,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView(
        controller: controller,
        onPageChanged: onPageChanged,
        children: onboardingPages,
      ),
    );
  }
}
