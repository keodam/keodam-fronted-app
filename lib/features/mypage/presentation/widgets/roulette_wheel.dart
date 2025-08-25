import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:keodam/core/theme/colors.dart';
import 'package:keodam/core/theme/text_styles.dart';
import 'package:keodam/features/mypage/data/util/roulette_util.dart';
import 'package:keodam/features/mypage/domain/util/show_single_button_dialog.dart';
import 'package:keodam/features/mypage/presentation/widgets/roulette_slices_painter.dart';
import 'package:keodam/features/mypage/provider/roulette_provider.dart';

const mockRouletteResponse = {
  "isSuccess": true,
  "code": "COMMON200",
  "message": "성공입니다.",
  "result": {
    "result": "EXP150",
    "remainingRouletteCoupons": 9,
    "itemIndex": "item3",
  },
};

String? itemKey;

class CustomRouletteWheel extends ConsumerStatefulWidget {
  const CustomRouletteWheel({super.key});

  @override
  ConsumerState<CustomRouletteWheel> createState() =>
      _CustomRouletteWheelState();
}

class _CustomRouletteWheelState extends ConsumerState<CustomRouletteWheel>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _angle = 0;

  final List<String> rewardItems = [
    '150exp',
    '커피 기프티콘 \n교환권',
    '꽝, \n다음 기회에',
    '300exp',
    '커피 기프티콘 \n교환권',
    '꽝, \n다음 기회에',
  ];

  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    _controller.addListener(() {
      setState(() {
        _angle = _animation.value;
      });
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed && itemKey != 'item3') {
        setState(() {
          _angle = 0;
        });
        showDialog(
          context: context,
          builder: (context) {
            return SingleButtonDialog(
              title: '축하합니다! \n"${rewardItems[selectedIndex]}"를 얻었어요!',
              buttonText: '확인',
              onPressed: () {
                context.pop();
              },
            );
          },
        );
      } else if (status == AnimationStatus.completed && itemKey == 'item3') {
        setState(() {
          _angle = 0;
        });
        showDialog(
          context: context,
          builder: (context) {
            return SingleButtonDialog(
              title: '꽝 아쉬워요..\n다음엔 좋은 결과가 있을거에요!',
              buttonText: '확인',
              onPressed: () {
                context.pop();
              },
            );
          },
        );
      }
    });
  }

  void _startRoulette() {
    final rouletteCoupon = ref.read(rouletteProvider).rouletteCoupon;

    if (rouletteCoupon <= 0) {
      showDialog(
        context: context,
        builder: (context) {
          return SingleButtonDialog(
            title: '보유하신 룰렛이용권이 없어요.',
            message: '상점의 1회 한정 프로모션이나, \n멘토로 활동하며 룰렛이용권을 얻을 수 있어요.',
            buttonText: '확인',
            onPressed: () {
              context.pop();
            },
          );
        },
      );
      return;
    }
    // Mock API response
    //TODO : 실제 API 호출로 변경
    final resultMock = mockRouletteResponse['result'] as Map<String, dynamic>?;
    itemKey = resultMock?['itemIndex'] as String?;

    if (itemKey == null) {
      showDialog(
        context: context,
        builder: (context) {
          return SingleButtonDialog(
            title: '룰렛 돌리기에 실패했어요.',
            message: '다시 시도해주세요.',
            buttonText: '확인',
            onPressed: () {
              context.pop();
            },
          );
        },
      );
      return;
    }
    ref
        .read(rouletteProvider.notifier)
        .update(
          (state) => state.copyWith(rouletteCoupon: state.rouletteCoupon - 1),
        );

    //TODO: userState 업데이트 (포인트 획득, 커피 기프티콘 교환권 획득시)
    if (rouletteItemIndexMap.containsKey(itemKey)) {
      selectedIndex = rouletteItemIndexMap[itemKey]!;
    }

    final sectionAngle = 2 * pi / rewardItems.length;
    const spins = 6;

    final selectedSectionCenterAngle =
        selectedIndex * sectionAngle + sectionAngle / 2;
    final needRotate = (-pi / 2) - selectedSectionCenterAngle;
    final targetAngle = spins * 2 * pi + needRotate;

    _animation = Tween<double>(
      begin: 0,
      end: targetAngle,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutQuart));

    _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 335,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: Offset(4, 4),
                ),
              ],
            ),
            child: Transform.rotate(
              angle: _angle,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 312,
                    height: 312,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xff529DFF),
                    ),
                  ),
                  CustomPaint(
                    size: const Size(280, 280),
                    painter: RouletteSlicesPainter(rewardItems),
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(color: backgroundColor01, width: 8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(4, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextButton(
                onPressed: _startRoulette,
                child: Text(
                  'START',
                  style: AppTextStyle.bold16.copyWith(color: textBlue02),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment(0, -1.0),
            child: Image.asset(
              'assets/images/mypage/roulette_pin.png',
              width: 38,
            ),
          ),
        ],
      ),
    );
  }
}
