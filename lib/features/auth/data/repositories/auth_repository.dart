import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keodam_app/core/error/failures.dart';
import 'package:keodam_app/core/models/api_response.dart';
import 'package:keodam_app/dio/dio.dart';
import 'package:keodam_app/features/auth/data/dtos/auth_dto.dart';
import 'package:keodam_app/features/user/data/dtos/user_dto.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepository(ref: ref);
}

class AuthRepository {
  final Ref ref;

  AuthRepository({
    required this.ref,
  });

  Future<Either<Failure, AuthDTO>> getCurrentAuth() async {
    try {
      final dio = ref.read(dioProvider);
      final response = await dio.get('/api/auth/me');

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
          Failure.serverFailure(message: '사용자 정보를 찾을 수 없습니다.'),
        );
      }

      final userDTO = UserDTO.fromJson(apiResponse.result!);
      final authDTO = AuthDTO(user: userDTO);
      return Right(authDTO);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        return const Left(Failure.unauthorizedFailure(message: '인증이 필요합니다.'));
      }
      return Left(Failure.networkFailure(message: e.message));
    } catch (e) {
      return Left(Failure.unknownFailure(message: e.toString()));
    }
  }
}