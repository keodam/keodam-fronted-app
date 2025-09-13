import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keodam_app/features/auth/presentation/constants/sign_up_profile_constants.dart';
import 'package:keodam_app/features/auth/presentation/providers/mentoring_bean_provider.dart';
import 'package:keodam_app/styles/app_colors.dart';

class CalBean extends HookConsumerWidget {
  const CalBean({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mentoringBeanState = ref.watch(mentoringBeanNotifierProvider);
    final mentoringBeanNotifier = ref.read(mentoringBeanNotifierProvider.notifier);
    
    // 현재 슬라이더 값 (로컬 상태)
    final sliderValue = useState(mentoringBeanState.selectedBean ?? 500);

    // Provider의 selectedBean 값이 변경될 때 슬라이더 값 동기화
    useEffect(() {
      if (mentoringBeanState.selectedBean != null) {
        sliderValue.value = mentoringBeanState.selectedBean!;
      }
      return null;
    }, [mentoringBeanState.selectedBean]);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          Text(
            SignUpProfileConstants.calBeanHeader,
            style: SignUpProfileConstants.header.copyWith(
              height: 1.3,
            ),
          ),
          const SizedBox(height: 40),
          Text(
            SignUpProfileConstants.calBeanDesc1,
            style: SignUpProfileConstants.headerDesc.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            SignUpProfileConstants.calBeanDesc2,
            style: SignUpProfileConstants.headerDesc.copyWith(
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 90),
          Column(
            children: [
              // 슬라이더
              SliderTheme(
                data: SliderThemeData(
                  activeTrackColor: AppColors.borderMedium,
                  inactiveTrackColor: AppColors.backgroundSecondary,
                  thumbColor: AppColors.white,
                  overlayColor: AppColors.primary.withValues(alpha: 0.1),
                  trackHeight: 8,
                  thumbShape: const _CustomThumbShape(),
                  overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
                  tickMarkShape: SliderTickMarkShape.noTickMark, // 점선 제거
                ),
                child: Slider(
                  value: sliderValue.value.toDouble(),
                  min: 0,
                  max: 1500,
                  divisions: null, // divisions를 null로 설정하여 점선 완전 제거
                  onChanged: (value) {
                    // 100단위로 반올림
                    final roundedValue = (value / 100).round() * 100;
                    sliderValue.value = roundedValue;
                  },
                  onChangeEnd: (value) {
                    // 슬라이더 조작이 끝났을 때 Provider 상태 업데이트
                    final roundedValue = (value / 100).round() * 100;
                    mentoringBeanNotifier.setSelectedBean(roundedValue);
                  },
                ),
              ),
              const SizedBox(height: 16),
              // 값 표시
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    SignUpProfileConstants.calBeanMin,
                    style: SignUpProfileConstants.headerDesc.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Text(
                    '${sliderValue.value}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    SignUpProfileConstants.calBeanMax,
                    style: SignUpProfileConstants.headerDesc.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          // 에러 메시지 표시
          if (mentoringBeanState.errorMessage != null) ...[
            const SizedBox(height: 16),
            Text(
              mentoringBeanState.errorMessage!,
              style: SignUpProfileConstants.error.copyWith(
                color: AppColors.error,
              ),
              textAlign: TextAlign.center,
            ),
          ],
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}

// 커스텀 Thumb Shape
class _CustomThumbShape extends SliderComponentShape {
  const _CustomThumbShape();

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return const Size(28, 28);
  }

  @override
  void paint(
      PaintingContext context,
      Offset center, {
        required Animation<double> activationAnimation,
        required Animation<double> enableAnimation,
        required bool isDiscrete,
        required TextPainter labelPainter,
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        required TextDirection textDirection,
        required double value,
        required double textScaleFactor,
        required Size sizeWithOverflow,
      }) {
    final Canvas canvas = context.canvas;

    // 외부 원 (그림자)
    final shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.1)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center + const Offset(0, 2), 14, shadowPaint);

    // 외부 원 (흰색 배경)
    final outerPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, 14, outerPaint);

    // 테두리
    final borderPaint = Paint()
      ..color = AppColors.borderLight
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    canvas.drawCircle(center, 14, borderPaint);
  }
}
