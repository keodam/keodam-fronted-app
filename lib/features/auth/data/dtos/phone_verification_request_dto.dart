import 'package:freezed_annotation/freezed_annotation.dart';

part 'phone_verification_request_dto.freezed.dart';
part 'phone_verification_request_dto.g.dart';

/// 휴대폰 인증 요청 DTO
@freezed
abstract class PhoneVerificationRequestDTO with _$PhoneVerificationRequestDTO {
  const factory PhoneVerificationRequestDTO({
    required String phoneNumber,
    required String userRealName,
    required String userBirth,
    required bool userGender,
  }) = _PhoneVerificationRequestDTO;

  factory PhoneVerificationRequestDTO.fromJson(Map<String, dynamic> json) =>
      _$PhoneVerificationRequestDTOFromJson(json);
}

@freezed
abstract class VerifyCodeRequestDTO with _$VerifyCodeRequestDTO {
  const factory VerifyCodeRequestDTO({
    required String phoneNumber,
    required String code,
    required String userRealName,
    required bool userGender,
    required String userBirth,
  }) = _VerifyCodeRequestDTO;

  factory VerifyCodeRequestDTO.fromJson(Map<String, dynamic> json) =>
      _$VerifyCodeRequestDTOFromJson(json);
}