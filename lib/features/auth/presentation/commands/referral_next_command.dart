import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keodam_app/features/auth/presentation/commands/sign_up_profile_command.dart';
import 'package:keodam_app/features/auth/presentation/providers/referral_provider.dart';
import 'package:keodam_app/features/auth/presentation/providers/sign_up_profile_navigation_provider.dart';

/// 추천인 등록 페이지의 다음 버튼 명령
/// 추천인 등록 여부를 확인하고 건너뛸 것인지 묻습니다.
class ReferralNextCommand implements SignUpProfileCommand {
  final String? initialPage;
  
  const ReferralNextCommand({this.initialPage});
  
  @override
  Future<void> execute(WidgetRef ref, BuildContext context) async {
    final currentReferralState = ref.read(referralNotifierProvider);
    
    if (currentReferralState.hasReferee && !currentReferralState.isRegistered) {
      // 추천인이 입력되었지만 등록하지 않은 경우 확인 다이얼로그 표시
      final shouldProceed = await _showSkipReferralDialog(context);
      if (shouldProceed == true) {
        _goToNextPage(ref);
      }
    } else if (currentReferralState.isRegistered) {
      // 추천인이 등록된 경우 바로 다음 페이지로 이동
      _goToNextPage(ref);
    } else {
      // 추천인을 입력하지 않은 경우 바로 다음 페이지로 이동
      _goToNextPage(ref);
    }
  }
  
  /// 다음 페이지로 이동
  void _goToNextPage(WidgetRef ref) {
    ref.read(signUpProfileNavigationProvider(initialPage).notifier).goToNextPage();
  }
  
  /// 추천인 등록 없이 진행할지 확인하는 다이얼로그
  Future<bool?> _showSkipReferralDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('추천인 등록 없이 진행'),
          content: const Text('추천인을 등록하지 않고 다음 단계로 진행하시겠습니까?\\n나중에는 추천인 등록이 불가능합니다.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }
}