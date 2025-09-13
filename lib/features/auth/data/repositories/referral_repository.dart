import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keodam_app/core/error/failures.dart';
import 'package:keodam_app/core/models/api_response.dart';
import 'package:keodam_app/dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'referral_repository.g.dart';

@riverpod
ReferralRepository referralRepository(Ref ref) {
  return ReferralRepository(ref: ref);
}

class ReferralRepository {
  final Ref ref;

  ReferralRepository({
    required this.ref,
  });

  Future<Either<Failure, bool>> registerReferral(String refereeNickname) async {
    try {
      final dio = ref.read(dioProvider);

      final response = await dio.post(
        '/api/user/referral',
        data: {
          'refereeNickname': refereeNickname,
        },
      );

      final apiResponse = ApiResponse<Map<String, dynamic>>.fromJson(
        response.data,
        (json) => json as Map<String, dynamic>,
      );

      if (!apiResponse.isSuccess) {
        String errorMessage = apiResponse.message;
        
        return Left(
          Failure.serverFailure(
            message: errorMessage,
            code: apiResponse.code,
          ),
        );
      }

      return const Right(true); // 등록 성공
    } on DioException catch (e, st) {

      if (e.response?.statusCode == 401) {
        return const Left(Failure.unauthorizedFailure(message: '인증이 필요합니다.'));
      }

      if(e.response?.data['code'] == 'USER4001'){
        return const Left(Failure.unauthorizedFailure(message: '회원 정보를 찾을 수 없습니다.'));
      }

      if (e.response?.statusCode == 400) {
        // 추천인이 존재하지 않는 경우 등의 클라이언트 오류
        final errorMessage = e.response?.data?['message'] ?? '추천인 등록에 실패했습니다.';
        return Left(Failure.serverFailure(
          message: errorMessage,
          code: e.response?.statusCode.toString(),
        ));
      }
      if (e.response?.statusCode == 500) {
        return Left(Failure.serverFailure(
          message: '서버 오류가 발생했습니다: ${e.response?.data ?? e.message}',
          code: e.response?.statusCode.toString(),
        ));
      }
      return Left(Failure.networkFailure(message: e.message));
    } catch (e, st) {
      print('예상치 못한 오류 발생:');
      print(e);
      print(st);
      return Left(Failure.unknownFailure(message: e.toString()));
    }
  }
}