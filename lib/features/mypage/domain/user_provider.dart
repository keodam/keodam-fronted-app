import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'user_state.dart';

final userProvider = StateProvider<UserState>((ref) {
  return UserState(
    beanAmount: 1500,
    ticketAmount: 3,
    coffeeChatCount: 12,
    receivedLikes: 21,
    nickname: 'nickname',
    email: 'emailexampl@gamil.com',
    phoneNumber: '010-1234-5678',
    profileImageUrl: 'https://example.com/profile_image.png',
    currentExp: 8400,
    currentDegree: 35,
    appVersion: 'v1.0.0',
    uniqueId: '#p12345',
  );
});
