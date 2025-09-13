import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keodam_app/features/auth/presentation/commands/sign_up_profile_command.dart';
import 'package:keodam_app/features/auth/presentation/providers/profile_image_upload_provider.dart';
import 'package:keodam_app/features/auth/presentation/providers/sign_up_profile_navigation_provider.dart';

/// 프로필 이미지 페이지의 다음 버튼 명령
/// 이미지가 선택된 경우 업로드를 진행하고, 
/// 선택되지 않은 경우 건너뛸 것인지 확인합니다.
class ProfileImageNextCommand implements SignUpProfileCommand {
  final String? initialPage;
  
  const ProfileImageNextCommand({this.initialPage});
  
  @override
  Future<void> execute(WidgetRef ref, BuildContext context) async {
    final currentState = ref.read(profileImageUploadNotifierProvider);
    final profileImageUploadNotifier = ref.read(profileImageUploadNotifierProvider.notifier);
    
    // 이미지가 선택되어 있으면 업로드
    if (currentState.selectedImageFile != null) {
      await profileImageUploadNotifier.uploadProfileImage();
      
      // 업로드 완료 후 상태를 다시 확인
      final uploadState = ref.read(profileImageUploadNotifierProvider);
      if (uploadState.canProceed) {
        _goToNextPage(ref);
      }
    } else {
      // 이미지가 선택되지 않은 경우 확인 다이얼로그 표시
      final shouldProceed = await _showSkipImageDialog(context);
      if (shouldProceed == true) {
        _goToNextPage(ref);
      }
    }
  }
  
  /// 다음 페이지로 이동
  void _goToNextPage(WidgetRef ref) {
    ref.read(signUpProfileNavigationProvider(initialPage).notifier).goToNextPage();
  }
  
  /// 프로필 사진 없이 진행할지 확인하는 다이얼로그
  Future<bool?> _showSkipImageDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('프로필 사진 없이 진행'),
          content: const Text('프로필 사진 없이 다음 단계로 진행하시겠습니까?\\n나중에 설정에서 변경할 수 있습니다.'),
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