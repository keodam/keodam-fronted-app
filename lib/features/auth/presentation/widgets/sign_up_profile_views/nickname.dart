import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keodam_app/features/auth/presentation/constants/sign_up_profile_constants.dart';
import 'package:keodam_app/features/auth/presentation/providers/nickname_check_provider.dart';
import 'package:keodam_app/gen/assets.gen.dart';
import 'package:keodam_app/share/share_button.dart';
import 'package:keodam_app/share/share_text_field.dart';
import 'package:keodam_app/styles/app_colors.dart';

class Nickname extends HookConsumerWidget {
  const Nickname({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nicknameCheckState = ref.watch(nicknameCheckNotifierProvider);
    final nicknameCheckNotifier = ref.read(nicknameCheckNotifierProvider.notifier);
    final nicknameController = useTextEditingController(
      text: nicknameCheckState.currentNickname ?? '',
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          SignUpProfileConstants.nicknameHeader,
          style: SignUpProfileConstants.header
        ),
        const SizedBox(height: 40),
        // 닉네임 레이블과 중복확인 결과 아이콘
        Row(
          children: [
            const Text(
              SignUpProfileConstants.nicknameInfo,
              style: SignUpProfileConstants.headerDesc,
            ),
            const SizedBox(width: 8),
            if (nicknameCheckState.hasAttempted && !nicknameCheckState.isLoading) ...[
              if (nicknameCheckState.isSuccess && nicknameCheckState.isChecked)
                Image.asset(Assets.icons.signUpProfileAccept.path,
                  width: 20,
                  height: 20,
                )
              else
                Image.asset(Assets.icons.signUpProfileDeny.path,
                  width: 20,
                  height: 20,
                ),
            ],
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: ShareTextField.outline(
                controller: nicknameController,
                hintText:SignUpProfileConstants.nicknameTextInputHint,
                onChanged: (value) {
                  nicknameCheckNotifier.onNicknameChanged(value);
                },
              ),
            ),
            const SizedBox(width: 8),
            ShareButton.small(
              text: SignUpProfileConstants.nicknameTextInputButton,
              width: 100,
              onPressed: () {
                final nickname = nicknameController.text.trim();
                if (nickname.isNotEmpty) {
                  nicknameCheckNotifier.checkNickname(nickname);
                }
              },
              isLoading: nicknameCheckState.isLoading,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          SignUpProfileConstants.nicknameTextInputInfo,
          style: SignUpProfileConstants.info,
        ),
        if (nicknameCheckState.errorMessage != null) ...[
          const SizedBox(height: 8),
          Text(
            nicknameCheckState.errorMessage!,
            style: SignUpProfileConstants.error.copyWith(color: AppColors.error,)
          ),
        ],
      ],
    );
  }
}
