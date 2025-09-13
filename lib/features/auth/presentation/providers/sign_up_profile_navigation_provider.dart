import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'sign_up_profile_navigation_provider.g.dart';

@riverpod
class SignUpProfileNavigation extends _$SignUpProfileNavigation {
  @override
  int build(String? initialPage) {
    if(initialPage != null) {
      final page = int.tryParse(initialPage);
      if(page != null && page >=1 && page <=7) {
        return page;
      }
    }
    return 1; // 초기 페이지 인덱스
    // 2 - 닉네임
    // 3 - 프로필 사진
    // 4 - 재학상태
    // 5 - 추천인
    // 6 - 역할 선택
    // 7 - 원두 선택
  }

  void goToNextPage() {
    if (state < 7) {
      state++;
    }
  }

  void goToPrevPage() {
    if (state > 1) {
      state--;
    }
  }


}