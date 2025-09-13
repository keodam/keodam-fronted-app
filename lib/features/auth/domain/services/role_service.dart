import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keodam_app/core/error/failures.dart';
import 'package:keodam_app/features/auth/data/repositories/role_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'role_service.g.dart';

@riverpod
RoleService roleService(Ref ref) {
  return RoleService(ref: ref);
}

class RoleService {
  final Ref ref;

  RoleService({
    required this.ref,
  });

  Future<Either<Failure, bool>> updateUserRole(String roleType) async {
    try {
      final repository = ref.read(roleRepositoryProvider);
      return await repository.updateUserRole(roleType);
    } catch (e) {
      return Left(ServerFailure(message: '역할 업데이트 중 오류가 발생했습니다.'));
    }
  }
}