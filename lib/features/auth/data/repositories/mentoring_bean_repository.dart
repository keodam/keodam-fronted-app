import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keodam_app/core/error/failures.dart';
import 'package:keodam_app/core/models/api_response.dart';
import 'package:keodam_app/dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'mentoring_bean_repository.g.dart';

@riverpod
MentoringBeanRepository mentoringBeanRepository(Ref ref) {
  return MentoringBeanRepository(ref: ref);
}

class MentoringBeanRepository {
  final Ref ref;

  MentoringBeanRepository({
    required this.ref,
  });

  Future<Either<Failure, bool>> updateMentoringBean(int beanCount) async {
    try {
      final dio = ref.read(dioProvider);

      print('멘토링 빈 업데이트 요청:');
      print('빈 개수: $beanCount');

      final response = await dio.post(
        '/api/user/mentoring-bean',
        data: beanCount,
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

      return const Right(true); // 업데이트 성공
    } on DioException catch (e, st) {
      print('DioException 발생:');
      print('Status Code: ${e.response?.statusCode}');
      print('Response Data: ${e.response?.data}');
      print('Error Message: ${e.message}');
      print('Stack Trace: $st');

      /**
       * Response Data: {isSuccess: false, code: COMMON500, message: 서버 에러, 관리자에게 문의 바랍니다., result: could not execute statement [Duplicate entry '4' for key 'mentor.UKr6xhdjja3j8j68aw7x4i16ykt'] [insert into mentor (company,job_description,major,mentoring_bean_amount,mentoring_topics,preferred_days,preferred_locations,self_introduction,user_id) values (?,?,?,?,?,?,?,?,?)]; SQL [insert into mentor (company,job_description,major,mentoring_bean_amount,mentoring_topics,preferred_days,preferred_locations,self_introduction,user_id) values (?,?,?,?,?,?,?,?,?)]; constraint [mentor.UKr6xhdjja3j8j68aw7x4i16ykt]}
       */

      if (e.response?.statusCode == 401) {
        return const Left(Failure.unauthorizedFailure(message: '인증이 필요합니다.'));
      }

      if(e.response?.data['code'] == 'ROLE4002'){
        return Left(Failure.unauthorizedFailure(message: e.response?.data['message']));
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