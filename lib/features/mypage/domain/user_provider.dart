import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'user_state.dart';

final userProvider = StateProvider<UserState>((ref) {
  final int degree = 5;
  return UserState(
    coffeeCoupon: 1500,
    rouletteCoupon: 2,
    matches: 12,
    receivedLikes: 21,
    nickname: 'nickname',
    email: 'emailexampl@gamil.com',
    phoneNumber: '010-1234-5678',
    profileImageUrl: 'https://example.com/profile_image.png',
    currentExp: 1,
    currentDegree: degree < 15 ? 15 : degree,
    appVersion: 'v1.0.0',
    uniqueId: '#p12345',
  );
});
