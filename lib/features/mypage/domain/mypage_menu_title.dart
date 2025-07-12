enum MypageMenuTitle {
  editMentorProfile,
  editMenteeProfile,
  certifyStatus,
  roulette,
  supportDeveloper,
  contactSupport,
  viewMatchingHistory,
  manageBlockedUsers,
  viewPolicies,
  deleteAccount,
  appInfo,
}

extension MypageMenuTitleExt on MypageMenuTitle {
  String get label {
    switch (this) {
      case MypageMenuTitle.editMentorProfile:
        return '멘토 프로필 수정';
      case MypageMenuTitle.editMenteeProfile:
        return '멘티 프로필 수정';
      case MypageMenuTitle.certifyStatus:
        return '재학 및 졸업, 현직자 인증';
      case MypageMenuTitle.roulette:
        return '돌려 돌려 더 돌려 룰렛';
      case MypageMenuTitle.supportDeveloper:
        return '개발자 후원하기';
      case MypageMenuTitle.contactSupport:
        return '고객센터 문의하기';
      case MypageMenuTitle.viewMatchingHistory:
        return '매칭 내역 확인';
      case MypageMenuTitle.manageBlockedUsers:
        return '차단내역 관리';
      case MypageMenuTitle.viewPolicies:
        return '이용약관 및 개인정보 처리 방침';
      case MypageMenuTitle.deleteAccount:
        return '회원 탈퇴';
      case MypageMenuTitle.appInfo:
        return '앱 버전 / 계정 고유 아이디';
    }
  }
}
