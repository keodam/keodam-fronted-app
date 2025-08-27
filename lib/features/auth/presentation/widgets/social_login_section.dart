import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:keodam/core/common/secure_storage.dart';
import 'package:keodam/core/router/routes.dart';
import 'package:keodam/core/theme/text_styles.dart';
import 'package:keodam/features/auth/data/model/social_login_model.dart';
import 'package:keodam/features/auth/presentation/widgets/social_login_button.dart';
import 'package:keodam/features/auth/providers/social_login_provider.dart';

// final kakaoLoginResultProvider = StateProvider<User?>((ref) => null);

class SocialLoginSection extends ConsumerStatefulWidget {
  const SocialLoginSection({super.key});

  @override
  ConsumerState<SocialLoginSection> createState() => _SocialLoginSectionState();
}

class _SocialLoginSectionState extends ConsumerState<SocialLoginSection> {
  @override
  Widget build(BuildContext context) {
    final storage = ref.watch(secureStorageProvider);

    return Column(
      children: [
        Align(alignment: Alignment.centerLeft, child: Text('원하는 방법을 통해 로그인 해주세요', style: AppTextStyle.medium16)),
        const SizedBox(height: 26),
        SocialLoginButton(
          imagePath: 'assets/images/kakao_logo.png',
          text: '카카오로 로그인',
          onPressed: () async {
            final result = await ref.read(socialLoginRepositoryProvider).loginWithKakao();
            if (!context.mounted) return;
            if (result != null) {
              storage.write(key: USERID, value: result.kakaoAccount?.email ?? '');
              context.go(Routes.mypage);
            }
            // ref.read(kakaoLoginResultProvider.notifier).state = result;
          },
        ),
        const SizedBox(height: 13),
        SocialLoginButton(
          imagePath: 'assets/images/apple_logo.png',
          text: 'Apple로 로그인',
          onPressed: () async {
            final result = await ref.read(socialLoginRepositoryProvider).loginWithApple();
            if (!context.mounted) return;
            if (result != null) {
              storage.write(key: USERID, value: result.userIdentifier.toString().substring(0, 6));
              context.go(Routes.mypage);
            }
          },
        ),
        const SizedBox(height: 13),
        SocialLoginButton(
          imagePath: 'assets/images/google_logo.png',
          text: 'Google로 로그인',
          onPressed: () async {
            final result = await ref.read(socialLoginRepositoryProvider).loginWithGoogle();
            if (!context.mounted) return;
            if (result != null) {
              storage.write(key: USERID, value: result.email);
              context.go(Routes.mypage);
            }
          },
          leftPadding: 8,
        ),
      ],
    );
  }
}
