import 'package:freezed_annotation/freezed_annotation.dart';

part 'phone_verification_response_dto.freezed.dart';
part 'phone_verification_response_dto.g.dart';

/// 휴대폰 인증 요청 DTO
@freezed
abstract class PhoneVerificationResponseDTO with _$PhoneVerificationResponseDTO {
  const factory PhoneVerificationResponseDTO({
    required String httpStatus,
    required String code,
    required String message,
    required bool success,
  }) = _PhoneVerificationResponseDTO;

  factory PhoneVerificationResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$PhoneVerificationResponseDTOFromJson(json);
}

@freezed
abstract class VerifyCodeResponseDTO with _$VerifyCodeResponseDTO {
  const factory VerifyCodeResponseDTO({
    required String httpStatus,
    required String code,
    required String message,
    required bool success,
  }) = _VerifyCodeResponseDTO;

  factory VerifyCodeResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$VerifyCodeResponseDTOFromJson(json);
}