import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:keodam/core/router/routes.dart';
import 'package:keodam/core/theme/text_styles.dart';
import 'package:keodam/features/auth/providers/agreement_provider.dart';

class AgreementBottomButton extends ConsumerWidget {
  const AgreementBottomButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final agreementState = ref.watch(agreementNotifierProvider);

    return Positioned(
      bottom: 34,
      left: 21,
      right: 21,
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: GestureDetector(
          onTap: agreementState.canStart
              ? () {
                  context.push(Routes.mobileAuth);
                  ref.read(agreementNotifierProvider.notifier).resetAgreement();
                }
              : null,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: agreementState.canStart ? Colors.blue : Colors.grey,
            ),
            child: Center(child: Text('시작하기', style: AppTextStyle.bold22.copyWith(color: Colors.white))),
          ),
        ),
      ),
    );
  }
}
