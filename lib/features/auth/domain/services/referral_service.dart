import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keodam_app/core/error/failures.dart';
import 'package:keodam_app/features/auth/data/repositories/referral_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'referral_service.g.dart';

@riverpod
ReferralService referralService(Ref ref) {
  return ReferralService(ref: ref);
}

class ReferralService {
  final Ref ref;

  ReferralService({
    required this.ref,
  });

  /// 추천인 등록
  Future<Either<Failure, bool>> registerReferral(String refereeNickname) async {
    // 유효성 검증
    final validationResult = _validateRefereeNickname(refereeNickname);
    if (validationResult.isLeft()) {
      return Left(validationResult.fold((l) => l, (r) => const Failure.serverFailure(message: '유효성 검증 실패')));
    }

    final repository = ref.read(referralRepositoryProvider);
    return await repository.registerReferral(refereeNickname.trim());
  }

  /// 추천인 닉네임 유효성 검증
  Either<Failure, bool> _validateRefereeNickname(String refereeNickname) {
    // 빈 문자열 또는 null 체크
    if (refereeNickname.trim().isEmpty) {
      return const Left(Failure.serverFailure(message: '추천인 닉네임을 입력해주세요.'));
    }

    // 닉네임 길이 검증 (예: 2-20자)
    if (refereeNickname.trim().length < 2) {
      return const Left(Failure.serverFailure(message: '추천인 닉네임은 2자 이상이어야 합니다.'));
    }

    if (refereeNickname.trim().length > 20) {
      return const Left(Failure.serverFailure(message: '추천인 닉네임은 20자 이하여야 합니다.'));
    }

    // 특수문자 검증 (필요시 추가)
    final validCharacters = RegExp(r'^[가-힣a-zA-Z0-9_]+$');
    if (!validCharacters.hasMatch(refereeNickname.trim())) {
      return const Left(Failure.serverFailure(message: '추천인 닉네임은 한글, 영문, 숫자, 언더스코어만 사용 가능합니다.'));
    }

    return const Right(true);
  }
}