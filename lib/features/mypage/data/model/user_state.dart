import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_state.freezed.dart';
// part 'user_state.g.dart'; // json serialization 필요시

@freezed
abstract class UserState with _$UserState {
  const factory UserState({
    required int coffeeCoupon,
    required int rouletteCoupon,
    required int matches,
    required int receivedLikes,
    required String nickname,
    required String email,
    required String phoneNumber,
    required String profileImageUrl,
    @Default(0) int currentExp,
    @Default(35) int currentDegree,
    @Default('v1.0.0') String appVersion,
    @Default('#p12345') String uniqueId,
  }) = _UserState;

  // factory UserState.fromJson(Map<String, dynamic> json) =>
  //     _$UserStateFromJson(json);
}
