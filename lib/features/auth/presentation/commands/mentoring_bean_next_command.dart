import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keodam_app/features/auth/presentation/commands/sign_up_profile_command.dart';
import 'package:keodam_app/features/auth/presentation/providers/mentoring_bean_provider.dart';
import 'package:keodam_app/features/auth/presentation/providers/sign_up_profile_navigation_provider.dart';

/// 멘토링 빈 설정 페이지의 다음 버튼 명령
/// 빈 선택 여부를 확인하고 API를 호출합니다.
class MentoringBeanNextCommand implements SignUpProfileCommand {
  final String? initialPage;
  
  const MentoringBeanNextCommand({this.initialPage});
  
  @override
  Future<void> execute(WidgetRef ref, BuildContext context) async {
    final currentBeanState = ref.read(mentoringBeanNotifierProvider);
    final mentoringBeanNotifier = ref.read(mentoringBeanNotifierProvider.notifier);
    
    if (currentBeanState.selectedBean == null) {
      // 빈이 선택되지 않은 경우 기본값 설정
      mentoringBeanNotifier.setSelectedBean(500);
    }
    
    // 멘토링 빈 업데이트 API 호출
    await mentoringBeanNotifier.updateMentoringBean();
    
    // 업데이트 완료 후 상태를 다시 확인
    final updateState = ref.read(mentoringBeanNotifierProvider);

    if (updateState.canProceed) {
      _goToNextPage(ref);
    }
  }
  
  /// 다음 페이지로 이동
  void _goToNextPage(WidgetRef ref) {
    ref.read(signUpProfileNavigationProvider(initialPage).notifier).goToNextPage();
  }
}