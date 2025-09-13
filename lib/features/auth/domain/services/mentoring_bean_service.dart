import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keodam_app/core/error/failures.dart';
import 'package:keodam_app/features/auth/data/repositories/mentoring_bean_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'mentoring_bean_service.g.dart';

@riverpod
MentoringBeanService mentoringBeanService(Ref ref) {
  return MentoringBeanService(ref: ref);
}

class MentoringBeanService {
  final Ref ref;

  MentoringBeanService({
    required this.ref,
  });

  /// 멘토링 빈 설정 업데이트
  Future<Either<Failure, bool>> updateMentoringBean(int beanCount) async {
    // 빈 개수 유효성 검증
    final validationResult = _validateBeanCount(beanCount);
    if (validationResult.isLeft()) {
      return Left(validationResult.fold((l) => l, (r) => const Failure.serverFailure(message: '유효성 검증 실패')));
    }

    final repository = ref.read(mentoringBeanRepositoryProvider);
    return await repository.updateMentoringBean(beanCount);
  }

  /// 빈 개수 유효성 검증
  Either<Failure, bool> _validateBeanCount(int beanCount) {
    if (beanCount < 0) {
      return const Left(Failure.serverFailure(message: '빈 개수는 0 이상이어야 합니다.'));
    }

    if (beanCount > 1500) {
      return const Left(Failure.serverFailure(message: '빈 개수는 1500 이하여야 합니다.'));
    }

    return const Right(true);
  }
}