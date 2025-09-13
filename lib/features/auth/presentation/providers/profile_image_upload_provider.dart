import 'dart:io';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keodam_app/features/auth/data/token_provider.dart';
import 'package:keodam_app/features/auth/domain/services/profile_image_upload_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_image_upload_provider.freezed.dart';
part 'profile_image_upload_provider.g.dart';

enum ProfileImageUploadStatus {
  idle,
  loading,
  success,
  error,
}

@freezed
sealed class ProfileImageUploadState with _$ProfileImageUploadState {
  const factory ProfileImageUploadState({
    @Default(ProfileImageUploadStatus.idle) ProfileImageUploadStatus status,
    @Default(false) bool hasAttempted,
    @Default(false) bool isUploaded,
    File? selectedImageFile,
    String? selectedImagePath,
    String? errorMessage,
  }) = _ProfileImageUploadState;

  const ProfileImageUploadState._();

  bool get isLoading => status == ProfileImageUploadStatus.loading;
  bool get isSuccess => status == ProfileImageUploadStatus.success;
  bool get isError => status == ProfileImageUploadStatus.error;
  bool get canProceed => isSuccess && isUploaded;
}

@Riverpod(keepAlive: true)
class ProfileImageUploadNotifier extends _$ProfileImageUploadNotifier {
  @override
  ProfileImageUploadState build() {
    return const ProfileImageUploadState();
  }

  /// 선택된 이미지 파일 설정
  void setSelectedImage(File? imageFile) {
    final newImagePath = imageFile?.path;
    
    print('이미지 설정 - 현재: ${state.selectedImagePath}, 새로운: $newImagePath');
    
    // 현재 선택된 이미지와 다른 경우에만 상태 초기화
    if (state.selectedImagePath != newImagePath) {
      print('새로운 이미지 - 상태 초기화');
      state = state.copyWith(
        selectedImageFile: imageFile,
        selectedImagePath: newImagePath,
        status: ProfileImageUploadStatus.idle,
        hasAttempted: false,
        isUploaded: false,
        errorMessage: null,
      );
    } else {
      print('같은 이미지 - 파일만 업데이트');
      // 같은 이미지인 경우 파일만 업데이트
      state = state.copyWith(
        selectedImageFile: imageFile,
      );
    }
  }

  /// 프로필 이미지 업로드
  Future<void> uploadProfileImage() async {
    print('업로드 시작 - selectedImageFile: ${state.selectedImageFile}');
    print('업로드 시작 - selectedImagePath: ${state.selectedImagePath}');
    
    if (state.selectedImageFile == null) {
      print('에러: 선택된 이미지 파일이 없음');
      state = state.copyWith(
        status: ProfileImageUploadStatus.error,
        hasAttempted: true,
        errorMessage: '업로드할 이미지를 선택해주세요.',
      );
      return;
    }

    // 인증 토큰 확인 (비동기로 초기화 대기)
    final tokenState = await ref.read(tokenNotifierProvider.future);
    final accessToken = tokenState.$1;
    
    print('토큰 확인 - accessToken: ${accessToken != null ? "존재함" : "없음"}');
    
    if (accessToken == null || accessToken.isEmpty) {
      print('에러: 인증 토큰이 없음');
      state = state.copyWith(
        status: ProfileImageUploadStatus.error,
        hasAttempted: true,
        errorMessage: '로그인이 필요합니다. 다시 로그인해주세요.',
      );
      return;
    }

    state = state.copyWith(
      status: ProfileImageUploadStatus.loading,
      hasAttempted: true,
      errorMessage: null,
    );

    final service = ref.read(profileImageUploadServiceProvider);
    final result = await service.uploadProfileImage(state.selectedImageFile!);

    result.fold(
      (failure) {
        state = state.copyWith(
          status: ProfileImageUploadStatus.error,
          isUploaded: false,
          errorMessage: failure.message ?? '프로필 이미지 업로드에 실패했습니다.',
        );
      },
      (isSuccess) {
        state = state.copyWith(
          status: ProfileImageUploadStatus.success,
          isUploaded: isSuccess,
          errorMessage: null,
        );
      },
    );
  }

  /// 상태 초기화
  void reset() {
    state = const ProfileImageUploadState();
  }
}
