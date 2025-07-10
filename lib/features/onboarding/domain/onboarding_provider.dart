import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'onboarding_state.dart';

class OnboardingNotifier extends StateNotifier<OnboardingState> {
  OnboardingNotifier() : super(OnboardingState(currentPage: 0));

  void setPage(int page) {
    state = OnboardingState(currentPage: page);
  }

  void nextPage(int totalPages) {
    if (state.currentPage < totalPages - 1) {
      state = OnboardingState(currentPage: state.currentPage + 1);
    }
  }
}

final onboardingProvider = StateNotifierProvider<OnboardingNotifier, OnboardingState>(
      (ref) => OnboardingNotifier(),
);
