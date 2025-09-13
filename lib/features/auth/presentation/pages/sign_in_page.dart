import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keodam_app/features/auth/presentation/widgets/social_buttons_section.dart';
import 'package:keodam_app/gen/assets.gen.dart';
import 'package:keodam_app/styles/app_dimensions.dart';

class SignInPage extends HookConsumerWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.pageHorizontal,
          ),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // 로고 이미지
                    Image.asset(
                      Assets.icons.signInLogoPng.path,
                      width: 140,
                    ),
                    const SizedBox(height: 12),
                    // 서브 타이틀
                    const Text(
                      '한 잔의 커피, 무한한 가능성의 대화',
                      // style: AppTextStyles.subtitle,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: AnimatedOpacity(
                  // opacity: isLoading ? 0.6 : 1.0,
                  opacity: 1.0,
                  duration: const Duration(milliseconds: 200),
                  child: SocialButtonsSection(),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 40),
                child: Center(
                  child: Text(
                    '아직 계정이 없다면, 버튼을 눌러 자동으로 회원가입으로 연결돼요',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
