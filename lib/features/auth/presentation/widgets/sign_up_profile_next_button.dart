import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keodam_app/features/auth/presentation/factories/sign_up_profile_command_factory.dart';
import 'package:keodam_app/features/auth/presentation/providers/education_status_provider.dart';
import 'package:keodam_app/features/auth/presentation/providers/mentoring_bean_provider.dart';
import 'package:keodam_app/features/auth/presentation/providers/profile_image_upload_provider.dart';
import 'package:keodam_app/features/auth/presentation/providers/referral_provider.dart';
import 'package:keodam_app/features/auth/presentation/providers/role_provider.dart';
import 'package:keodam_app/share/share_button.dart';

/// 회원가입 프로필 페이지의 "다음" 버튼 위젯
/// 현재 페이지 인덱스에 따라 적절한 명령을 실행합니다.
class SignUpProfileNextButton extends HookConsumerWidget {
  final int pageIndex;
  final String? initialPage;
  
  const SignUpProfileNextButton({
    super.key,
    required this.pageIndex,
    this.initialPage,
  });
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = _isAnyProviderLoading(ref);
    
    return SafeArea(
      bottom: true,
      child: ShareButton.outline(
        text: '다음',
        onPressed: isLoading ? null : () => _handleNext(context, ref),
        isLoading: isLoading,
      ),
    );
  }
  
  /// 다음 버튼 클릭 처리
  Future<void> _handleNext(BuildContext context, WidgetRef ref) async {
    final command = SignUpProfileCommandFactory.createCommand(
      pageIndex,
      initialPage,
    );
    await command.execute(ref, context);
  }
  
  /// 모든 provider의 로딩 상태를 확인
  bool _isAnyProviderLoading(WidgetRef ref) {
    return ref.watch(profileImageUploadNotifierProvider).isLoading ||
           ref.watch(educationStatusNotifierProvider).isLoading ||
           ref.watch(referralNotifierProvider).isLoading ||
           ref.watch(roleNotifierProvider).isLoading ||
           ref.watch(mentoringBeanNotifierProvider).isLoading;
  }
}