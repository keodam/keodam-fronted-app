import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keodam/core/theme/text_styles.dart';
import 'package:keodam/features/auth/providers/auth_provider.dart';

class MobileAuthBottomButton extends ConsumerWidget {
  const MobileAuthBottomButton({super.key, this.onPressed});
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canSubmit = ref.watch(authNotifierProvider.select((s) => s.canSubmit));
    return SizedBox(
      height: 52,
      width: double.infinity,
      child: FilledButton(
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (!canSubmit) return Colors.grey;
            return Colors.blue;
          }),
          padding: const WidgetStatePropertyAll(EdgeInsets.zero),
          minimumSize: const WidgetStatePropertyAll(Size.fromHeight(52)),
        ),
        onPressed: canSubmit ? onPressed : null,
        child: Text('인증 완료하기', style: AppTextStyle.bold22.copyWith(color: Colors.white)),
      ),
    );
  }
}
