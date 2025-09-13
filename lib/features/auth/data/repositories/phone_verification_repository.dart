import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keodam_app/core/error/exceptions.dart';
import 'package:keodam_app/core/error/failures.dart';
import 'package:keodam_app/features/auth/data/dtos/phone_verification_request_dto.dart';
import 'package:keodam_app/features/auth/data/dtos/phone_verification_response_dto.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:keodam_app/dio/dio.dart';

part 'phone_verification_repository.g.dart';

abstract class PhoneVerificationRepository {
  Future<Either<Failure, PhoneVerificationResponseDTO>> sendVerificationCode(
    PhoneVerificationRequestDTO request,
  );
  
  Future<Either<Failure, VerifyCodeResponseDTO>> verifyCode(
    VerifyCodeRequestDTO request,
  );
}

class PhoneVerificationRepositoryImpl implements PhoneVerificationRepository {
  final Dio _dio;

  PhoneVerificationRepositoryImpl({required Dio dio}) : _dio = dio;

  @override
  Future<Either<Failure, PhoneVerificationResponseDTO>> sendVerificationCode(
    PhoneVerificationRequestDTO request,
  ) async {
    try {
      final response = await _dio.post(
        '/api/user/authenticate/code',
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        final responseDto = PhoneVerificationResponseDTO.fromJson(response.data);
        return Right(responseDto);
      } else {
        return Left(ServerFailure(
          message: '인증 요청에 실패했습니다.',
          code: response.statusCode.toString(),
        ));
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        return const Left(NetworkFailure(message: '네트워크 연결이 불안정합니다.'));
      } else if (e.response?.statusCode == 401) {
        return const Left(UnauthorizedFailure(message: '인증이 필요합니다.'));
      } else if (e.response?.statusCode != null) {
        final message = e.response?.data?['message'] ?? '서버 오류가 발생했습니다.';
        return Left(ServerFailure(
          message: message,
          code: e.response?.statusCode.toString(),
        ));
      } else {
        return const Left(NetworkFailure(message: '네트워크 연결에 실패했습니다.'));
      }
    } catch (e) {
      return Left(UnknownFailure(message: '알 수 없는 오류가 발생했습니다: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, VerifyCodeResponseDTO>> verifyCode(
    VerifyCodeRequestDTO request,
  ) async {
    try {
      final response = await _dio.post(
        '/api/user/authenticate/check',
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        final responseDto = VerifyCodeResponseDTO.fromJson(response.data);
        return Right(responseDto);
      } else {
        return Left(ServerFailure(
          message: '인증 확인에 실패했습니다.',
          code: response.statusCode.toString(),
        ));
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        return const Left(NetworkFailure(message: '네트워크 연결이 불안정합니다.'));
      } else if (e.response?.statusCode == 401) {
        return const Left(UnauthorizedFailure(message: '인증이 필요합니다.'));
      } else if (e.response?.statusCode != null) {
        final message = e.response?.data?['message'] ?? '서버 오류가 발생했습니다.';
        return Left(ServerFailure(
          message: message,
          code: e.response?.statusCode.toString(),
        ));
      } else {
        return const Left(NetworkFailure(message: '네트워크 연결에 실패했습니다.'));
      }
    } catch (e) {
      return Left(UnknownFailure(message: '알 수 없는 오류가 발생했습니다: ${e.toString()}'));
    }
  }
}

@Riverpod(keepAlive: true)
PhoneVerificationRepository phoneVerificationRepository(Ref ref) {
  final dio = ref.read(dioProvider);
  return PhoneVerificationRepositoryImpl(dio: dio);
}