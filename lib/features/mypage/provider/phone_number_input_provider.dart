import 'package:flutter_riverpod/flutter_riverpod.dart';

final phoneNumberProvider = StateProvider<String>((ref) => '');

final isValidPhoneNumberProvider = Provider<bool>((ref) {
  final input = ref.watch(phoneNumberProvider);
  final regex = RegExp(r'^\d{3}-\d{4}-\d{4}$');
  return regex.hasMatch(input);
});
