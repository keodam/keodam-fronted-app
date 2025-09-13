import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:keodam_app/features/user/domain/entities/user.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

@freezed
sealed class UserDTO with _$UserDTO {
  const factory UserDTO({
    String? id,
    String? email,
    String? nickname,
    @JsonKey(name: 'profileUrl') String? profileImageUrl,
    @JsonKey(name: 'roleType') String? roleType,
    @Default(false) bool hasProfileImage,
    @Default(false) bool hasRole,
    @Default(false) bool agreedTerms,
    @Default(false) bool mentor,
    @Default(false) bool phoneVerified,
    @Default(false) bool profileCompleted,
    @Default(false) bool beanPreferenceSet,
    String? signupStep,
    String? studentStatus,
    String? referralRegistered,
  }) = _UserDTO;

  const UserDTO._();

  factory UserDTO.fromJson(Map<String, dynamic> json) => _$UserDTOFromJson(json);

  User toEntity() {
    return User(
      id: id,
      email: email,
      nickname: nickname,
      profileImageUrl: profileImageUrl,
      phoneNumber: null, // API 응답에 없는 필드
      studentStatus: studentStatus,
      role: roleType ?? (mentor ? 'MENTOR' : 'MENTEE'),
      coffeeBeans: null, // API 응답에 없는 필드
    );
  }
}