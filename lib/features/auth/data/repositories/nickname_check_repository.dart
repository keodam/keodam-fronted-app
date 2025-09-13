import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keodam_app/core/error/failures.dart';
import 'package:keodam_app/core/models/api_response.dart';
import 'package:keodam_app/dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'nickname_check_repository.g.dart';

@riverpod
NicknameCheckRepository nicknameCheckRepository(Ref ref) {
  return NicknameCheckRepository(ref: ref);
}

class NicknameCheckRepository {
  final Ref ref;

  NicknameCheckRepository({
    required this.ref,
  });

  Future<Either<Failure, bool>> checkNickname(String nickname) async {
    try {
      final dio = ref.read(dioProvider);
      final response = await dio.get(
        '/api/user/nickname/check',
        queryParameters: {'nickname': nickname},
      );

      final apiResponse = ApiResponse<dynamic>.fromJson(
        response.data,
        (json) => json,
      );

      if (apiResponse.isSuccess) {
        return const Right(true); // 사용 가능한 닉네임
      } else {
        return const Right(false); // 중복된 닉네임
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        // 400 응답도 중복 확인 결과로 간주
        try {
          final apiResponse = ApiResponse<dynamic>.fromJson(
            e.response!.data,
            (json) => json,
          );
          return const Right(false); // 중복된 닉네임
        } catch (_) {
          return Left(Failure.serverFailure(message: '닉네임 중복 확인에 실패했습니다.'));
        }
      }
      return Left(Failure.networkFailure(message: e.message));
    } catch (e) {
      return Left(Failure.unknownFailure(message: e.toString()));
    }
  }
}