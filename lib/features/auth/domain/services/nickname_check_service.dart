import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keodam_app/core/error/failures.dart';
import 'package:keodam_app/features/auth/data/repositories/nickname_check_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'nickname_check_service.g.dart';

@riverpod
NicknameCheckService nicknameCheckService(Ref ref) {
  return NicknameCheckService(ref: ref);
}

class NicknameCheckService {
  final Ref ref;

  NicknameCheckService({
    required this.ref,
  });

  /// 닉네임 중복 확인
  Future<Either<Failure, bool>> checkNickname(String nickname) async {
    // 닉네임 유효성 검증
    final validationResult = _validateNickname(nickname);
    if (validationResult.isLeft()) {
      return validationResult;
    }

    final repository = ref.read(nicknameCheckRepositoryProvider);
    return await repository.checkNickname(nickname);
  }

  /// 닉네임 유효성 검증
  Either<Failure, bool> _validateNickname(String nickname) {
    if (nickname.trim().isEmpty) {
      return const Left(Failure.serverFailure(message: '닉네임을 입력해주세요.'));
    }

    if (nickname.length < 2) {
      return const Left(Failure.serverFailure(message: '닉네임은 최소 2글자 이상이어야 합니다.'));
    }

    if (nickname.length > 8) {
      return const Left(Failure.serverFailure(message: '닉네임은 최대 8글자까지 가능합니다.'));
    }

    // 한글, 영문, 숫자만 허용하는 정규식
    final RegExp nicknameRegex = RegExp(r'^[가-힣a-zA-Z0-9]+$');
    if (!nicknameRegex.hasMatch(nickname)) {
      return const Left(Failure.serverFailure(message: '한글, 영문, 숫자만 사용 가능합니다.'));
    }

    return const Right(true);
  }
}