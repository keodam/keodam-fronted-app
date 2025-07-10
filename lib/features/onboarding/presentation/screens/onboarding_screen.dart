import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keodam/features/onboarding/domain/onboarding_pages.dart';
import 'package:keodam/features/onboarding/domain/onboarding_provider.dart';
import 'package:keodam/features/onboarding/presentation/widgets/onboarding_footer.dart';
import 'package:keodam/features/onboarding/presentation/widgets/onboarding_page_indicator.dart';
import 'package:keodam/features/onboarding/presentation/widgets/onboarding_pager.dart';
import '../widgets/onboarding_header.dart';
import '../widgets/section_divider.dart';

class OnboardingScreen extends HookConsumerWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPage = ref.watch(onboardingProvider).currentPage;
    final controller = usePageController();

    void setPage(int index) {
      ref.read(onboardingProvider.notifier).setPage(index);
    }

    void nextPage() {
      final page = ref.read(onboardingProvider).currentPage;
      ref.read(onboardingProvider.notifier).nextPage(onboardingPages.length);

      if (page < onboardingPages.length - 1) {
        controller.animateToPage(
          page + 1,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else {
        // TODO: 마지막 페이지 처리 (예: 홈으로 이동)
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const OnboardingHeader(),
              Expanded(
                child: Column(
                  children: [
                    OnboardingPager(
                      controller: controller,
                      onPageChanged: setPage,
                    ),
                    const SectionDivider(height: 16),
                    OnboardingIndicator(
                      currentPage: currentPage,
                      totalPages: onboardingPages.length,
                    ),
                    const SectionDivider(height: 50),
                    OnboardingFooter(
                      currentPage: currentPage,
                      totalPages: onboardingPages.length,
                      onPressed: nextPage,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
