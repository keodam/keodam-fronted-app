import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keodam/features/mypage/data/model/blocked_user_table.dart';
import 'package:keodam/features/mypage/data/model/blocked_user.dart';

final blockedUsersProvider = StateProvider<List<BlockedUser>>((ref) {
  return blockedUserTable;
});
