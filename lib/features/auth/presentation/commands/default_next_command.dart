import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keodam_app/features/auth/presentation/commands/sign_up_profile_command.dart';
import 'package:keodam_app/features/auth/presentation/providers/sign_up_profile_navigation_provider.dart';

/// 기본적인 다음 페이지 이동 명령
/// 특별한 로직 없이 단순히 다음 페이지로 이동합니다.
class DefaultNextCommand implements SignUpProfileCommand {
  final String? initialPage;
  
  const DefaultNextCommand({this.initialPage});
  
  @override
  Future<void> execute(WidgetRef ref, BuildContext context) async {
    ref.read(signUpProfileNavigationProvider(initialPage).notifier).goToNextPage();
  }
}