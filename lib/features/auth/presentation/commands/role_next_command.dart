import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keodam_app/features/auth/presentation/commands/sign_up_profile_command.dart';
import 'package:keodam_app/features/auth/presentation/providers/role_provider.dart';
import 'package:keodam_app/features/auth/presentation/providers/sign_up_profile_navigation_provider.dart';

/// 역할 선택 페이지의 다음 버튼 명령
/// 역할 업데이트 API를 호출합니다.
class RoleNextCommand implements SignUpProfileCommand {
  final String? initialPage;
  
  const RoleNextCommand({this.initialPage});
  
  @override
  Future<void> execute(WidgetRef ref, BuildContext context) async {
    final roleNotifier = ref.read(roleNotifierProvider.notifier);
    
    // 역할 업데이트 API 호출
    await roleNotifier.updateUserRole();
    
    // 업데이트 완료 후 상태를 다시 확인
    final updateState = ref.read(roleNotifierProvider);

    if (updateState.canProceed) {
      _goToNextPage(ref);
    }
  }
  
  /// 다음 페이지로 이동
  void _goToNextPage(WidgetRef ref) {
    ref.read(signUpProfileNavigationProvider(initialPage).notifier).goToNextPage();
  }
}