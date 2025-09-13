import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keodam_app/features/auth/presentation/constants/sign_up_profile_constants.dart';
import 'package:keodam_app/features/auth/presentation/providers/referral_provider.dart';
import 'package:keodam_app/styles/app_colors.dart';

class Recommend extends HookConsumerWidget {
  const Recommend({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 텍스트 컨트롤러
    final textController = useTextEditingController();

    // Provider 상태 관리
    final referralState = ref.watch(referralNotifierProvider);
    final referralNotifier = ref.read(referralNotifierProvider.notifier);

    // 텍스트 변경 시 Provider에 반영
    useEffect(() {
      void listener() {
        referralNotifier.setRefereeNickname(textController.text);
      }
      textController.addListener(listener);
      return () => textController.removeListener(listener);
    }, [textController]);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SignUpProfileConstants.progressBottomHeightBox,
            RichText(
              text: TextSpan(
                style: SignUpProfileConstants.header,
                children: [
                  TextSpan(text: SignUpProfileConstants.recommendHeader1),
                  TextSpan(
                    text: SignUpProfileConstants.recommendHeader1Optional,
                    style: SignUpProfileConstants.headerDesc.copyWith(
                      color: AppColors.gray600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              SignUpProfileConstants.recommendHeader2,
              style: SignUpProfileConstants.header,
            ),
            const SizedBox(height: 16),
            Text(
              SignUpProfileConstants.recommendDesc,
              style: SignUpProfileConstants.headerDesc.copyWith(
                color: AppColors.gray600,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 40),

            // 친구추천 이벤트 안내
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
              decoration: BoxDecoration(
                color: AppColors.primaryBackground,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Text(
                    SignUpProfileConstants.recommendEventTitle,
                    style: SignUpProfileConstants.headerDesc.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    SignUpProfileConstants.recommendEventDesc1,
                    textAlign: TextAlign.center,
                    style: SignUpProfileConstants.info.copyWith(
                      color: AppColors.gray600,
                      height: 1.6,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        SignUpProfileConstants.recommendEventDescHighlight,
                        style: SignUpProfileConstants.info.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                      Text(
                        SignUpProfileConstants.recommendEventDesc2,
                        style: SignUpProfileConstants.info.copyWith(
                          color: AppColors.gray600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // 닉네임 입력 필드
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textController,
                    onChanged: (value) {
                      // Provider에서 자동으로 처리됨 (useEffect listener)
                    },
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF1A1A1A),
                    ),
                    decoration: InputDecoration(
                      hintText: SignUpProfileConstants.recommendHint,
                      hintStyle: SignUpProfileConstants.info.copyWith(
                        color: AppColors.gray400,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: AppColors.borderLight,
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: AppColors.primary,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  height: 56,
                  width: 88,
                  child: ElevatedButton(
                    onPressed: textController.text.isNotEmpty && !referralState.isRegistered && !referralState.isLoading
                        ? () async {
                      // 키보드 닫기
                      FocusScope.of(context).unfocus();

                      // API 호출
                      await referralNotifier.registerReferral();

                      // 성공 시 스낵바 표시
                      if (referralState.isSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(SignUpProfileConstants.recommendRegisteredMessage),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      disabledBackgroundColor: AppColors.gray200,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                      padding: EdgeInsets.zero,
                    ),
                    child: referralState.isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            referralState.isRegistered 
                                ? SignUpProfileConstants.recommendButtonComplete 
                                : SignUpProfileConstants.recommendButtonRegister,
                            style: SignUpProfileConstants.headerDesc.copyWith(
                              color: textController.text.isNotEmpty && !referralState.isRegistered && !referralState.isLoading
                                  ? AppColors.white
                                  : AppColors.gray400,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // 에러 메시지 표시
            if (referralState.errorMessage != null) ...[
              Text(
                referralState.errorMessage!,
                style: SignUpProfileConstants.error.copyWith(
                  color: AppColors.error,
                ),
              ),
              const SizedBox(height: 12),
            ],
            Text(
              SignUpProfileConstants.recommendDisclaimer,
              style: SignUpProfileConstants.info.copyWith(
                color: AppColors.gray600,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 60),
            // 하단 링크
            Center(
              child: TextButton(
                onPressed: () {
                  // 추천인 보상 받기 페이지로 이동
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(0, 0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  SignUpProfileConstants.recommendBottomText,
                  style: SignUpProfileConstants.info.copyWith(
                    color: AppColors.primary,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
