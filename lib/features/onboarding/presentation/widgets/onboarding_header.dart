import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class OnboardingHeader extends HookWidget  {
  const OnboardingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 64),
        SizedBox(
          height: 64,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Image.asset(
              'assets/images/header_logo.png',
              height: 64,
            ),
          ),
        ),
      ],
    );
  }
}
