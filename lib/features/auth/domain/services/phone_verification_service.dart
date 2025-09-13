import 'package:dartz/dartz.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keodam_app/core/error/failures.dart';
import 'package:keodam_app/features/auth/data/dtos/phone_verification_request_dto.dart';
import 'package:keodam_app/features/auth/data/dtos/phone_verification_response_dto.dart';
import 'package:keodam_app/features/auth/data/repositories/phone_verification_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'phone_verification_service.g.dart';

class PhoneVerificationService {
  final PhoneVerificationRepository _repository;

  PhoneVerificationService({required PhoneVerificationRepository repository})
      : _repository = repository;

  /// 휴대폰 인증 요청
  Future<Either<Failure, bool>> sendVerificationCode({
    required String phoneNumber,
    required String userRealName,
    required String userBirth,
    required bool userGender,
  }) async {
    try {
      final requestDto = PhoneVerificationRequestDTO(
        phoneNumber: phoneNumber,
        userRealName: userRealName,
        userBirth: userBirth,
        userGender: userGender,
      );

      final result = await _repository.sendVerificationCode(requestDto);

      return result.fold(
        (failure) => Left(failure),
        (response) {
          // 응답의 success 필드를 확인하여 성공 여부 반환
          if (response.success) {
            return const Right(true);
          } else {
            return Left(ServerFailure(
              message: response.message.isNotEmpty 
                  ? response.message 
                  : '인증 요청에 실패했습니다.',
              code: response.code,
            ));
          }
        },
      );
    } catch (e) {
      return Left(UnknownFailure(message: '알 수 없는 오류가 발생했습니다: ${e.toString()}'));
    }
  }

  /// 휴대폰 인증 확인
  Future<Either<Failure, bool>> verifyCode({
    required String phoneNumber,
    required String code,
    required String userRealName,
    required bool userGender,
    required String userBirth,
  }) async {
    try {
      final requestDto = VerifyCodeRequestDTO(
        phoneNumber: phoneNumber,
        code: code,
        userRealName: userRealName,
        userGender: userGender,
        userBirth: userBirth,
      );

      final result = await _repository.verifyCode(requestDto);

      return result.fold(
        (failure) => Left(failure),
        (response) {
          // 응답의 success 필드를 확인하여 성공 여부 반환
          if (response.success) {
            return const Right(true);
          } else {
            return Left(ServerFailure(
              message: response.message.isNotEmpty 
                  ? response.message 
                  : '인증 확인에 실패했습니다.',
              code: response.code,
            ));
          }
        },
      );
    } catch (e) {
      return Left(UnknownFailure(message: '알 수 없는 오류가 발생했습니다: ${e.toString()}'));
    }
  }
}

@Riverpod(keepAlive: true)
PhoneVerificationService phoneVerificationService(Ref ref) {
  final repository = ref.read(phoneVerificationRepositoryProvider);
  return PhoneVerificationService(repository: repository);
}