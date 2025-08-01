import 'package:keodam/features/mypage/data/model/blocked_user.dart';

const blockedUserTable = [
  BlockedUser(
    nickname: '붕어빵먹고싶다요',
    role: Role.mentee,
    isCertified: true,
    desiredCareer: '백엔드 개발자',
    level: 'Lv2. 실행자',
    image: 'assets/images/mypage/sample_avatar.png',
  ),
  BlockedUser(
    nickname: '멘토짱',
    role: Role.mentor,
    isCertified: false,
    jobTitle: '백엔드 개발자',
    manner: '15',
    image: 'assets/images/mypage/sample_avatar.png',
  ),
];
