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
  final int currentDegree;
  final String appVersion;
  final String uniqueId;

  UserState({
    int? currentExp,
    int? currentDegree,
    required this.beanAmount,
    required this.ticketAmount,
    required this.coffeeChatCount,
    required this.receivedLikes,
    required this.nickname,
    required this.email,
    required this.phoneNumber,
    required this.profileImageUrl,
    required this.appVersion,
    required this.uniqueId,
  }) : currentExp = currentExp ?? 0,
       currentDegree = currentDegree ?? 35;
}
