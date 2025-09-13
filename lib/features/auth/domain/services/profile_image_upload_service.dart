import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keodam_app/core/error/failures.dart';
import 'package:keodam_app/features/auth/data/repositories/profile_image_upload_repository.dart';
import 'package:keodam_app/features/user/data/dtos/user_dto.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_image_upload_service.g.dart';

@riverpod
ProfileImageUploadService profileImageUploadService(Ref ref) {
  return ProfileImageUploadService(ref: ref);
}

class ProfileImageUploadService {
  final Ref ref;

  ProfileImageUploadService({
    required this.ref,
  });

  /// 프로필 이미지 업로드
  Future<Either<Failure, bool>> uploadProfileImage(File imageFile) async {
    // 이미지 파일 유효성 검증
    final validationResult = _validateImageFile(imageFile);
    if (validationResult.isLeft()) {
      return Left(validationResult.fold((l) => l, (r) => const Failure.serverFailure(message: '유효성 검증 실패')));
    }

    final repository = ref.read(profileImageUploadRepositoryProvider);
    return await repository.uploadProfileImage(imageFile);
  }

  /// 이미지 파일 유효성 검증
  Either<Failure, bool> _validateImageFile(File imageFile) {
    if (!imageFile.existsSync()) {
      return const Left(Failure.serverFailure(message: '이미지 파일이 존재하지 않습니다.'));
    }

    // 파일 크기 검증 (예: 10MB 제한)
    const maxFileSize = 10 * 1024 * 1024; // 10MB
    if (imageFile.lengthSync() > maxFileSize) {
      return const Left(Failure.serverFailure(message: '이미지 파일 크기는 10MB 이하여야 합니다.'));
    }

    // 파일 확장자 검증
    final extension = imageFile.path.toLowerCase().split('.').last;
    const allowedExtensions = ['jpg', 'jpeg', 'png', 'gif'];
    if (!allowedExtensions.contains(extension)) {
      return const Left(Failure.serverFailure(message: 'JPG, JPEG, PNG, GIF 파일만 업로드 가능합니다.'));
    }

    return const Right(true);
  }
}
