import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keodam_app/core/error/failures.dart';
import 'package:keodam_app/core/models/api_response.dart';
import 'package:keodam_app/dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'education_status_repository.g.dart';

@riverpod
EducationStatusRepository educationStatusRepository(Ref ref) {
  return EducationStatusRepository(ref: ref);
}

class EducationStatusRepository {
  final Ref ref;

  EducationStatusRepository({
    required this.ref,
  });

  Future<Either<Failure, bool>> updateStudentStatus(String studentStatus) async {
    try {
      final dio = ref.read(dioProvider);

      final requestData = {
        'studentStatus': studentStatus,
      };

      print('재학상태 업데이트 요청:');
      print('Request Data: $requestData');

      final response = await dio.patch(
        '/api/user/student-status',
        data: requestData,
      );

      print('dio response');
      log(response.toString());

      final apiResponse = ApiResponse<dynamic>.fromJson(
        response.data,
        (json) => json,
      );

      if (!apiResponse.isSuccess) {
        return Left(
          Failure.serverFailure(
            message: apiResponse.message,
            code: apiResponse.code,
          ),
        );
      }

      return const Right(true); // 업데이트 성공
    } on DioException catch (e, st) {
      print('DioException 발생:');
      print('Status Code: ${e.response?.statusCode}');
      print('Response Data: ${e.response?.data}');
      print('Error Message: ${e.message}');
      print('Stack Trace: $st');
      print('1');
      if (e.response?.statusCode == 401) {
        print('2');
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