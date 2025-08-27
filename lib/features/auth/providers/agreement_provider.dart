import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'agreement_provider.g.dart';

class AgreementState {
  final bool allAgree;
  final bool agreePrivacy;
  final bool agreeService;
  final bool agreeMarketing;

  const AgreementState({
    this.allAgree = false,
    this.agreePrivacy = false,
    this.agreeService = false,
    this.agreeMarketing = false,
  });

  AgreementState copyWith({bool? allAgree, bool? agreePrivacy, bool? agreeService, bool? agreeMarketing}) {
    return AgreementState(
      allAgree: allAgree ?? this.allAgree,
      agreePrivacy: agreePrivacy ?? this.agreePrivacy,
      agreeService: agreeService ?? this.agreeService,
      agreeMarketing: agreeMarketing ?? this.agreeMarketing,
    );
  }

  bool get canStart => agreePrivacy && agreeService;
}

@riverpod
class AgreementNotifier extends _$AgreementNotifier {
  @override
  AgreementState build() {
    return const AgreementState();
  }

  void toggleAll(bool value) {
    state = state.copyWith(allAgree: value, agreePrivacy: value, agreeService: value, agreeMarketing: value);
  }

  void setAgreePrivacy(bool value) {
    final newState = state.copyWith(agreePrivacy: value);
    state = newState.copyWith(allAgree: newState.agreePrivacy && newState.agreeService && newState.agreeMarketing);
  }

  void setAgreeService(bool value) {
    final newState = state.copyWith(agreeService: value);
    state = newState.copyWith(allAgree: newState.agreePrivacy && newState.agreeService && newState.agreeMarketing);
  }

  void setAgreeMarketing(bool value) {
    final newState = state.copyWith(agreeMarketing: value);
    state = newState.copyWith(allAgree: newState.agreePrivacy && newState.agreeService && newState.agreeMarketing);
  }

  void resetAgreement() {
    state = const AgreementState();
  }
}
