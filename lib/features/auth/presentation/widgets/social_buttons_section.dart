import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keodam_app/gen/assets.gen.dart';
import 'package:keodam_app/features/auth/presentation/providers/social_auth_provider.dart';
import 'package:keodam_app/routes/app_router.dart';

class SocialButtonsSection extends HookConsumerWidget {
  const SocialButtonsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final socialAuthState = ref.watch(socialAuthNotifierProvider);
    final isLoading = socialAuthState.maybeWhen(
      loading: () => true,
      orElse: () => false,
    );

    // 로그인 상태 변화 감지
    ref.listen<SocialAuthState>(socialAuthNotifierProvider, (previous, next) {
      next.whenOrNull(
        success: () {
          // 로그인 성공 시 약관 페이지로 이동
          context.pushNamed(AppRoutes.terms.name);
          // 성공 후 상태 초기화
          ref.read(socialAuthNotifierProvider.notifier).reset();
        },
        error: (failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(failure.message ?? '알 수 없는 오류가 발생했습니다.'),
              backgroundColor: Colors.red,
            ),
          );
          // 에러 후 상태 초기화
          ref.read(socialAuthNotifierProvider.notifier).reset();
        },
      );
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '원하는 방법을 통해 로그인 해주세요',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 28),
        SocialLoginButton(
          iconAsset: Assets.icons.kakao.path,
          text: '카카오로 로그인',
          textColor: Colors.black87,
          buttonColor: Colors.white,
          borderColor: Color(0xFFF1F1F1),
          onPressed: isLoading 
            ? null 
            : () => ref.read(socialAuthNotifierProvider.notifier)
                .loginWithSocial(SocialProvider.kakao),
        ),
        const SizedBox(height: 12),
        SocialLoginButton(
          iconAsset: Assets.icons.apple.path,
          text: 'Apple로 로그인',
          textColor: Colors.black87,
          buttonColor: Colors.white,
          borderColor: Color(0xFFF1F1F1),
          onPressed: null, // TODO: 애플 로그인 구현 예정
        ),
        const SizedBox(height: 12),
        SocialLoginButton(
          iconAsset: Assets.icons.google.path,
          text: 'Google로 로그인',
          textColor: Colors.black87,
          buttonColor: Colors.white,
          borderColor: Color(0xFFF1F1F1),
          onPressed: null, // TODO: 구글 로그인 구현 예정
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}

/// 소셜 로그인 버튼 위젯
class SocialLoginButton extends HookConsumerWidget {
  const SocialLoginButton({
    super.key,
    required this.iconAsset,
    required this.text,
    required this.textColor,
    required this.buttonColor,
    this.borderColor,
    this.onPressed,
  });

  final String iconAsset;
  final String text;
  final Color textColor;
  final Color buttonColor;
  final Color? borderColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          foregroundColor: textColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: borderColor != null
                ? BorderSide(
              color: borderColor!,
              width: 1.0,
            )
                : BorderSide.none,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: Image.asset(
                iconAsset,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              text,
              // style: AppTextStyles.button.copyWith(color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}