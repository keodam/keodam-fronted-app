import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keodam_app/core/error/failures.dart';
import 'package:keodam_app/core/models/api_response.dart';
import 'package:keodam_app/dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'role_repository.g.dart';

@riverpod
RoleRepository roleRepository(Ref ref) {
  return RoleRepository(ref: ref);
}

class RoleRepository {
  final Ref ref;

  RoleRepository({
    required this.ref,
  });

  Future<Either<Failure, bool>> updateUserRole(String roleType) async {
    try {
      final dio = ref.read(dioProvider);

      final response = await dio.patch(
        '/api/user/role',
        data: {'roleType': roleType},
      );

      final apiResponse = ApiResponse.fromJson(
        response.data,
        (json) => json,
      );

      if (apiResponse.isSuccess) {
        return const Right(true);
      } else {
        return Left(ServerFailure(message: apiResponse.message));
      }
    } catch (e) {
      return Left(ServerFailure(message: '역할 업데이트 중 오류가 발생했습니다.'));
    }
  }
}