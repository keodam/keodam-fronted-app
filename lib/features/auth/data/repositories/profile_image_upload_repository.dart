import 'dart:developer';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keodam_app/core/error/failures.dart';
import 'package:keodam_app/core/models/api_response.dart';
import 'package:keodam_app/dio/dio.dart';
import 'package:keodam_app/features/user/data/dtos/user_dto.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_image_upload_repository.g.dart';

@riverpod
ProfileImageUploadRepository profileImageUploadRepository(Ref ref) {
  return ProfileImageUploadRepository(ref: ref);
}


class ProfileImageUploadRepository {
  final Ref ref;

  ProfileImageUploadRepository({
    required this.ref,
  });

  Future<Either<Failure, bool>> uploadProfileImage(File imageFile) async {
    try {
      final dio = ref.read(dioProvider);

      // FormData 생성
      final formData = FormData.fromMap({
        'ImageFile': await MultipartFile.fromFile(
          imageFile.path,
          filename: 'profile_image.jpg',
        ),
      });

      print('파일 정보:');
      print('파일 경로: ${imageFile.path}');
      print('파일 크기: ${imageFile.lengthSync()} bytes');
      print('파일 존재: ${imageFile.existsSync()}');

      final response = await dio.patch(
        '/api/user/file',
        data: formData,
      );

      print('dio response');
      log(response.toString());

      final apiResponse = ApiResponse<Map<String, dynamic>>.fromJson(
        response.data,
        (json) => json as Map<String, dynamic>,
      );

      if (!apiResponse.isSuccess) {
        return Left(
          Failure.serverFailure(
            message: apiResponse.message,
            code: apiResponse.code,
          ),
        );
      }

      if (apiResponse.result == null) {
        return const Left(
          Failure.serverFailure(message: '프로필 이미지 업로드 응답이 비어있습니다.'),
        );
      }

      return const Right(true); // 업로드 성공
    } on DioException catch (e, st) {
      print('DioException 발생:');
      print('Status Code: ${e.response?.statusCode}');
      print('Response Data: ${e.response?.data}');
      print('Error Message: ${e.message}');
      print('Stack Trace: $st');
      
      if (e.response?.statusCode == 401) {
        return const Left(Failure.unauthorizedFailure(message: '인증이 필요합니다.'));
      }
      if (e.response?.statusCode == 500) {
        return Left(Failure.serverFailure(
          message: '서버 오류가 발생했습니다: ${e.response?.data ?? e.message}',
          code: e.response?.statusCode.toString(),
        ));
      }
      return Left(Failure.networkFailure(message: e.message));
    } catch (e, st) {
      print(e);
      print(st);
      return Left(Failure.unknownFailure(message: e.toString()));
    }
  }
}
