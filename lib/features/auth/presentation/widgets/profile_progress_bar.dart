import 'package:flutter/material.dart';
import 'package:keodam_app/styles/app_colors.dart';

class ProfileProgressBar extends StatefulWidget {
  final double progress;

  const ProfileProgressBar({
    super.key,
    required this.progress,
  });

  @override
  State<ProfileProgressBar> createState() => _ProfileProgressBarState();
}

class _ProfileProgressBarState extends State<ProfileProgressBar>
    with SingleTickerProviderStateMixin {
  late double _currentProgress;
  late AnimationController _colorAnimationController;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _currentProgress = widget.progress;

    // 색상 애니메이션 컨트롤러 초기화
    _colorAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // 색상 애니메이션 설정 (primary → 초록색)
    _colorAnimation = ColorTween(
      begin: AppColors.primary,
      end: const Color(0xFF4EBB00),
    ).animate(CurvedAnimation(
      parent: _colorAnimationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void didUpdateWidget(ProfileProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 진행률이 실제로 변경된 경우에만 업데이트
    if (oldWidget.progress != widget.progress) {
      setState(() {
        _currentProgress = widget.progress;
      });

      // 마지막 페이지(100%)에 도달하면 색상 애니메이션 시작
      if (_currentProgress >= 1.0 && oldWidget.progress < 1.0) {
        _colorAnimationController.forward();
      }
      // 마지막 페이지에서 이전 페이지로 돌아가면 색상 애니메이션 역방향
      else if (_currentProgress < 1.0 && oldWidget.progress >= 1.0) {
        _colorAnimationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _colorAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Stack(
          children: [
            // 배경
            Container(
              decoration: BoxDecoration(
                color: AppColors.borderCheckBox,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            // 애니메이션 진행 바
            AnimatedFractionallySizedBox(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOutCubic,
              widthFactor: _currentProgress,
              child: AnimatedBuilder(
                animation: _colorAnimation,
                builder: (context, child) {
                  return Container(
                    decoration: BoxDecoration(
                      color: _colorAnimation.value,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}