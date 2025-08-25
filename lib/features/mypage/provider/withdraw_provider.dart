import 'package:flutter_riverpod/flutter_riverpod.dart';

final beanInputProvider = StateProvider<String>((ref) => '');

final beanWithdrawAmountProvider = Provider<int>((ref) {
  final input = ref.watch(beanInputProvider);
  final beans = int.tryParse(input) ?? 0;

  if (beans < 1200) return 0;

  final total = beans * 14;
  final afterFee = (total * 0.8).round();
  return afterFee;
});
