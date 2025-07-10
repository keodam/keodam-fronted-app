import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../../core/theme/colors.dart';

class OnboardingIndicator extends HookWidget  {
  final int currentPage;
  final int totalPages;

  const OnboardingIndicator({
    super.key,
    required this.currentPage,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: indicatorBackground,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(totalPages, (index) {
          final isActive = index == currentPage;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              width: 8,
              height: 15,
              decoration: BoxDecoration(
                color: isActive
                    ? pointColor529DFF
                    : textBlack.withAlpha((0.3 * 255).toInt()),
                shape: BoxShape.circle,
              ),
            ),
          );
        }),
      ),
    );
  }
}
