import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keodam_app/features/auth/presentation/constants/sign_up_profile_constants.dart';
import 'package:keodam_app/features/auth/presentation/providers/profile_image_upload_provider.dart';
import 'package:keodam_app/styles/app_colors.dart';

class Profile extends HookConsumerWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imagePicker = useMemoized(() => ImagePicker());
    final profileImageUploadState = ref.watch(profileImageUploadNotifierProvider);
    final profileImageUploadNotifier = ref.read(profileImageUploadNotifierProvider.notifier);

    Future<void> _pickImage() async {
      final pickedFile = await imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        // Provider에 선택된 이미지 파일 설정
        profileImageUploadNotifier.setSelectedImage(File(pickedFile.path));
      }
    }

    final String? imagePath = profileImageUploadState.selectedImagePath;
    final bool hasImage = imagePath != null && imagePath.isNotEmpty && File(imagePath).existsSync();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            SignUpProfileConstants.profileHeader,
            style: SignUpProfileConstants.header,
          ),
          const SizedBox(height: 40),
          Center(
            child: GestureDetector(
              onTap: _pickImage,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: AppColors.gray200,
                      shape: BoxShape.circle,
                      image: hasImage
                          ? DecorationImage(
                              image: FileImage(File(imagePath)),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: !hasImage
                        ? Icon(
                            Icons.person,
                            size: 80,
                            color: AppColors.gray400,
                          )
                        : null,
                  ),
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.white,
                        width: 3,
                      ),
                    ),
                    child: const Icon(
                      Icons.photo,
                      color: AppColors.white,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 40),
          const Center(
            child: Text(
              SignUpProfileConstants.profileDesc,
              style: SignUpProfileConstants.headerDesc,
              textAlign: TextAlign.center,
            ),
          ),
          // 에러 메시지 표시
          if (profileImageUploadState.errorMessage != null) ...[
            const SizedBox(height: 16),
            Center(
              child: Text(
                profileImageUploadState.errorMessage!,
                style: SignUpProfileConstants.error.copyWith(color: AppColors.error,),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
