import 'package:flutter_riverpod/flutter_riverpod.dart';

final bankNameProvider = StateProvider<String>((ref) => '');
final bankOwnerProvider = StateProvider<String>((ref) => '');
final bankAccountNumberProvider = StateProvider<String>((ref) => '');

final isValidBankNameProvider = Provider<bool>((ref) {
  final input = ref.watch(bankNameProvider);
  final regex = RegExp(r'^[가-힣]{2,}$');
  return regex.hasMatch(input);
});

final isValidBankOwnerProvider = Provider<bool>((ref) {
  final input = ref.watch(bankOwnerProvider);
  final regex = RegExp(r'^[가-힣]{2,}$');
  return regex.hasMatch(input);
});

final isValidBankAccountNumberProvider = Provider<bool>((ref) {
  final input = ref.watch(bankAccountNumberProvider);
  final regex = RegExp(r'^\d{10,12}$');
  return regex.hasMatch(input);
});
