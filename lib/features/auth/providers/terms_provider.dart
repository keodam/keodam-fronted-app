import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'terms_provider.g.dart';

class TermsState {
  final bool isLoading;
  final bool hasError;

  const TermsState({this.isLoading = true, this.hasError = false});

  TermsState copyWith({bool? isLoading, bool? hasError}) {
    return TermsState(isLoading: isLoading ?? this.isLoading, hasError: hasError ?? this.hasError);
  }
}

@riverpod
class TermsNotifier extends _$TermsNotifier {
  @override
  TermsState build() {
    return const TermsState();
  }

  void setLoading(bool loading) {
    state = state.copyWith(isLoading: loading);
  }

  void setError(bool hasError) {
    state = state.copyWith(hasError: hasError);
  }

  void resetState() {
    state = const TermsState();
  }
}
