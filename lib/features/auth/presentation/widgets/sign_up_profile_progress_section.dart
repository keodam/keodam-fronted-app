import 'package:flutter/material.dart';
import 'package:keodam_app/features/auth/presentation/widgets/profile_progress_bar.dart';

/// 회원가입 프로필 페이지의 진행률 표시 섹션
class SignUpProfileProgressSection extends StatelessWidget {
  final int currentIndex;
  final int totalSteps;
  
  const SignUpProfileProgressSection({
    super.key,
    required this.currentIndex,
    this.totalSteps = 7,
  });
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: ProfileProgressBar(
        key: const ValueKey('progress-bar'),
        progress: currentIndex / totalSteps.toDouble(),
      ),
    );
  }
}