import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:keodam/core/router/routes.dart';
import 'package:keodam/features/auth/providers/agreement_provider.dart';
import 'package:keodam/features/auth/presentation/widgets/agreement_title_section.dart';

class AgreementListSection extends ConsumerWidget {
  const AgreementListSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final agreementState = ref.watch(agreementNotifierProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          AgreementTitleSection(
            text: '개인정보 수집 및 이용약관 (필수)',
            titie: '개인정보 수집 및 이용약관',
            checked: agreementState.agreePrivacy,
            onChanged: (value) {
              ref.read(agreementNotifierProvider.notifier).setAgreePrivacy(value);
            },
            onTextTap: () {
              context.push(Routes.termsInfo, extra: '개인정보 수집 및 이용약관');
            },
          ),
          const SizedBox(height: 16),
          AgreementTitleSection(
            text: '서비스 이용약관 동의 (필수)',
            titie: '커담 서비스 이용약관',
            checked: agreementState.agreeService,
            onChanged: (value) {
              ref.read(agreementNotifierProvider.notifier).setAgreeService(value);
            },
            onTextTap: () {
              context.push(Routes.termsInfo, extra: '커담 서비스 이용약관');
            },
          ),
          const SizedBox(height: 16),
          AgreementTitleSection(
            text: '이벤트 및 혜택 알림 수신 동의 (선택)',
            titie: '혜택 알림 약관',
            checked: agreementState.agreeMarketing,
            onChanged: (value) {
              ref.read(agreementNotifierProvider.notifier).setAgreeMarketing(value);
            },
            onTextTap: () {
              context.push(Routes.termsInfo, extra: '혜택 알림 약관');
            },
          ),
        ],
      ),
    );
  }
}
