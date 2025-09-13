import 'package:freezed_annotation/freezed_annotation.dart';
part 'user.freezed.dart';

@freezed
sealed class User with _$User {
  const factory User({
    String? id,
    String? email,
    String? nickname,
    String? profileImageUrl,
    String? phoneNumber,
    String? studentStatus, //HIGH_SCHOOL_GRADUATE, UNIVERSITY_STUDENT, UNIVERSITY_GRADUATE_2_3, UNIVERSITY_GRADUATE_4, JOB_SEEKER, EMPLOYEE
    String? role, // MENTOR, MENTEE
    int? coffeeBeans,
  }) = _User;

  const User._();
}