import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keodam_app/features/auth/presentation/commands/sign_up_profile_command.dart';
import 'package:keodam_app/features/auth/presentation/providers/education_status_provider.dart';
import 'package:keodam_app/features/auth/presentation/providers/sign_up_profile_navigation_provider.dart';

/// 재학상태 페이지의 다음 버튼 명령
/// 재학상태가 선택되었는지 확인하고 API를 호출합니다.
class EducationStatusNextCommand implements SignUpProfileCommand {
  final String? initialPage;
  
  const EducationStatusNextCommand({this.initialPage});
  
  @override
  Future<void> execute(WidgetRef ref, BuildContext context) async {
    final currentEducationState = ref.read(educationStatusNotifierProvider);
    final educationStatusNotifier = ref.read(educationStatusNotifierProvider.notifier);
    
    if (currentEducationState.selectedStatus == null) {
      // 재학상태가 선택되지 않은 경우 에러 표시
      educationStatusNotifier.setSelectedStatus(null); // 에러 메시지 표시를 위해
    } else {
      // 재학상태가 선택된 경우 API 호출
      await educationStatusNotifier.updateStudentStatus();
      
      // 업데이트 완료 후 상태를 다시 확인
      final updateState = ref.read(educationStatusNotifierProvider);

      if (updateState.canProceed) {
        _goToNextPage(ref);
      }
    }
  }
  
  /// 다음 페이지로 이동
  void _goToNextPage(WidgetRef ref) {
    ref.read(signUpProfileNavigationProvider(initialPage).notifier).goToNextPage();
  }
}