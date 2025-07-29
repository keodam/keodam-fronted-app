import 'package:freezed_annotation/freezed_annotation.dart';

part 'blocked_user.freezed.dart';
part 'blocked_user.g.dart';

enum Role { mentor, mentee }

@freezed
abstract class BlockedUser with _$BlockedUser {
  const factory BlockedUser({
    required String nickname,
    required Role role,
    required bool isCertified,
    String? jobTitle, // 멘토 직업
    String? desiredCareer, // 멘티 희망 직무
    String? level, // 멘티 레벨
    String? manner, // 멘토 매너 온도
    required String image, // 프로필 이미지
  }) = _BlockedUser;

  factory BlockedUser.fromJson(Map<String, dynamic> json) =>
      _$BlockedUserFromJson(json);
}
