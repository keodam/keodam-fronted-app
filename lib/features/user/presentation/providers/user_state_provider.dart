import 'package:keodam_app/features/user/domain/entities/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_state_provider.g.dart';

@Riverpod(keepAlive: true)
class UserStateNotifier extends _$UserStateNotifier {
  @override
  User? build() {
    return null;
  }

  /// 사용자 정보 설정
  void setUser(User user) {
    state = user;
  }

  /// 사용자 정보 초기화
  void clearUser() {
    state = null;
  }

  /// 현재 사용자 정보 조회
  User? get currentUser => state;

  /// 로그인 상태 확인
  bool get isLoggedIn => state != null;
}