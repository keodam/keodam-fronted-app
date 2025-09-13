import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keodam_app/features/auth/presentation/constants/sign_up_profile_constants.dart';
import 'package:keodam_app/features/auth/presentation/providers/sign_up_profile_navigation_provider.dart';
import 'package:keodam_app/features/auth/presentation/widgets/sign_up_profile_next_button.dart';
import 'package:keodam_app/features/auth/presentation/widgets/sign_up_profile_page_content.dart';
import 'package:keodam_app/features/auth/presentation/widgets/sign_up_profile_progress_section.dart';
import 'package:keodam_app/share/app_bar/sign_up_profile_app_bar.dart';
import 'package:keodam_app/styles/app_dimensions.dart';

class SignUpProfilePage extends HookConsumerWidget {
  final String? initialPage;
  const SignUpProfilePage({super.key, this.initialPage, });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signUpProfileNavigationIndex = ref.watch(signUpProfileNavigationProvider(initialPage));

    return Scaffold(
      appBar: SignUpProfileAppBar(initialPage: initialPage),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppDimensions.pageHorizontal).copyWith(bottom: SignUpProfileConstants.bottomHeight),
        child: Column(
          children: [
            SignUpProfileProgressSection(
              currentIndex: signUpProfileNavigationIndex,
            ),
            SignUpProfileConstants.progressBottomHeightBox,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SignUpProfilePageContent(
                      currentPage: signUpProfileNavigationIndex,
                    ),
                  ),
                  SignUpProfileNextButton(
                    pageIndex: signUpProfileNavigationIndex,
                    initialPage: initialPage,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
