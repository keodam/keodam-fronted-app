import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

class AuthState {
  final bool isLoading;
  final bool isAuthenticated;
  final String errorMessage;
  final String phoneNumber;
  final String authCode;
  final String selectedCarrier;
  final String firstName;
  final String birthDate;
  final String genderDigit;
  final int remainingSeconds;
  final bool isPhoneNumberVerified;

  const AuthState({
    this.isLoading = false,
    this.isAuthenticated = false,
    this.errorMessage = '',
    this.phoneNumber = '',
    this.authCode = '',
    this.selectedCarrier = 'SKT',
    this.firstName = '',
    this.birthDate = '',
    this.genderDigit = '',
    this.remainingSeconds = 0,
    this.isPhoneNumberVerified = false,
  });

  AuthState copyWith({
    bool? isLoading,
    bool? isAuthenticated,
    String? errorMessage,
    String? phoneNumber,
    String? authCode,
    String? selectedCarrier,
    String? firstName,
    String? birthDate,
    String? genderDigit,
    int? remainingSeconds,
    bool? isPhoneNumberVerified,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      errorMessage: errorMessage ?? this.errorMessage,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      authCode: authCode ?? this.authCode,
      selectedCarrier: selectedCarrier ?? this.selectedCarrier,
      firstName: firstName ?? this.firstName,
      birthDate: birthDate ?? this.birthDate,
      genderDigit: genderDigit ?? this.genderDigit,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      isPhoneNumberVerified: isPhoneNumberVerified ?? this.isPhoneNumberVerified,
    );
  }

  bool get canSubmit =>
      firstName.trim().isNotEmpty &&
      birthDate.trim().isNotEmpty &&
      genderDigit.trim().isNotEmpty &&
      phoneNumber.trim().isNotEmpty &&
      authCode.trim().isNotEmpty;
}

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  AuthState build() {
    return const AuthState();
  }

  void setPhoneNumber(String phoneNumber) {
    state = state.copyWith(phoneNumber: phoneNumber);
  }

  void setAuthCode(String authCode) {
    state = state.copyWith(authCode: authCode);
  }

  void setSelectedCarrier(String carrier) {
    state = state.copyWith(selectedCarrier: carrier);
  }

  void setFirstName(String name) {
    state = state.copyWith(firstName: name);
  }

  void setBirthDate(String birthDate) {
    state = state.copyWith(birthDate: birthDate);
  }

  void setGenderDigit(String digit) {
    state = state.copyWith(genderDigit: digit);
  }

  void setPhoneNumberVerified(bool verified) {
    state = state.copyWith(isPhoneNumberVerified: verified);
  }

  void setRemainingSeconds(int seconds) {
    state = state.copyWith(remainingSeconds: seconds);
  }

  void setLoading(bool loading) {
    state = state.copyWith(isLoading: loading);
  }

  void setError(String error) {
    state = state.copyWith(errorMessage: error);
  }

  void clearError() {
    state = state.copyWith(errorMessage: '');
  }

  void resetAuthState() {
    state = const AuthState();
  }
}
