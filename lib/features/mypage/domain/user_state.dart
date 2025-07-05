class UserState {
  final int beanAmount;
  final int ticketAmount;
  final int coffeeChatCount;
  final int receivedLikes;
  final String nickname;
  final String email;
  final String phoneNumber;
  final String profileImageUrl;
  final int currentExp;

  UserState({
    required this.beanAmount,
    required this.ticketAmount,
    required this.coffeeChatCount,
    required this.receivedLikes,
    required this.nickname,
    required this.email,
    required this.phoneNumber,
    required this.profileImageUrl,
    required this.currentExp,
  });
}
