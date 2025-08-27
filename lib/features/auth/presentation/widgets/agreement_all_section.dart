import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keodam/core/theme/colors.dart';
import 'package:keodam/core/theme/text_styles.dart';
import 'package:keodam/features/auth/providers/agreement_provider.dart';

class AgreementAllSection extends ConsumerWidget {
  const AgreementAllSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final agreementState = ref.watch(agreementNotifierProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 84),
        Text('커피와 담소 서비스의 원할한 이용을 위해,\n약관s 동의가 필요해요', style: AppTextStyle.bold20),
        const SizedBox(height: 37),
        GestureDetector(
          onTap: () {
            ref.read(agreementNotifierProvider.notifier).toggleAll(!agreementState.allAgree);
          },
          child: Container(
            width: double.infinity,
            height: 58,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: backgroundColor01),
            child: Row(
              children: [
                agreementState.allAgree
                    ? SizedBox(width: 20, height: 20, child: Image.asset('assets/images/check.png', fit: BoxFit.fill))
                    : Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(color: Color(0xFFD9D9D9), borderRadius: BorderRadius.circular(4)),
                    ),
                const SizedBox(width: 12),
                const Expanded(child: Text('전체 약관 동의하기 (선택 항목 포함)', style: AppTextStyle.bold16)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
