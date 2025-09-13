import 'package:flutter/material.dart';
import 'package:keodam_app/styles/app_text_styles.dart';

class SignUpProfileConstants{
  static const TextStyle header = AppTextStyles.headlineLarge;
  static const TextStyle headerDesc = AppTextStyles.bodyLarge;
  static const TextStyle info = AppTextStyles.bodySmall;
  static const TextStyle error = AppTextStyles.labelMedium;
  static const SizedBox progressBottomHeightBox = SizedBox(height: 32,);
  static const SizedBox headerBottomHeightBox = SizedBox(height: 18,);

  static const double bottomHeight = 34;

  // welcome
  static const String welcomeHeader1 = '성장과 가치의 시작, ';
  static const String welcomeHeader2 = 'KEODAM';
  static const String welcomeDesc1 = '\n먼저 프로필 작성을 시작해볼까요?';
  static const String welcomeDesc2 = '너무 고민하지 않아도 돼요.\n마이페이지에서 언제든지 수정할 수 있어요!';

  // nickname
  static const String nicknameHeader = '사용할 닉네임과\n프로필 사진을 등록해주세요.';
  static const String nicknameInfo = '닉네임 (최소 2글자, 최대 8글자)';
  static const String nicknameTextInputHint = '닉네임을 입력해주세요';
  static const String nicknameTextInputButton = '중복확인';
  static const String nicknameTextInputInfo = '한글/영문/숫자 가능 | 실명은 지양해 주세요';

  // profile
  static const String profileHeader = '사용할 닉네임과\n프로필 사진을 등록해주세요.';
  static const String profileDesc = '프로필 사진은 24시간 내로 운영자 검토 후에 승인됩니다.';

  // education status
  static const String educationStatusHeader = '재학상태를 알려주세요.';
  static const String educationStatusDesc = 'KEODAM에서는, 재학생, 졸업생,\n취준생, 현직자 모두를 만날 수 있어요.';
  static const String educationStatusPlaceholder = '재학상태를 선택해주세요';
  static const String educationStatusHighSchool = '고등학교 졸업';
  static const String educationStatusUniversityStudent = '대학교 재학';
  static const String educationStatusUniversityGraduate23 = '대학교 졸업 (2,3년)';
  static const String educationStatusUniversityGraduate4 = '대학교 졸업 (4년)';
  static const String educationStatusJobSeeker = '취업준비생';
  static const String educationStatusEmployee = '현직자(직장인)';

  // recommend
  static const String recommendHeader1 = '등록할 추천인이 있으신가요? ';
  static const String recommendHeader1Optional = '(선택)';
  static const String recommendHeader2 = '추천인 닉네임을 입력해주세요';
  static const String recommendDesc = '추천인 닉네임을 모르는 경우 추천인 등록이 어려워요.';
  static const String recommendEventTitle = '💡 친구추천 이벤트 안내';
  static const String recommendEventDesc1 = '추천인을 등록한 신규 가입자와 추천인에게\n커피챗 매칭에 필요한 1500원 상당의';
  static const String recommendEventDescHighlight = '100 원두';
  static const String recommendEventDesc2 = '를 지급해드려요!';
  static const String recommendButtonRegister = '등록';
  static const String recommendButtonComplete = '완료';
  static const String recommendHint = '예시) 나장난멘토';
  static const String recommendRegisteredMessage = '추천인이 등록되었습니다';
  static const String recommendBottomText = '지금 등록하지 않으면 추천인 보상을 받을 기회가 사라져요!';
  static const String recommendDisclaimer = '* 이벤트로 받은 원두는 대면 커피챗 매칭 독려를 위한 원두로,\n  환금 및 환불이 불가능한 상품입니다.';

  // role
  static const String roleHeader = '커피와 담소에서 활동할 역할을\n선택해주세요.';
  static const String roleDesc1 = '마이페이지의 토글을 통해 역할을 자유롭게\n변경할 수 있어요.';
  static const String roleDesc2 = '우선 프로필을 작성할 역할을 선택해주세요.';
  static const String roleMentor = '멘토';
  static const String roleMentee = '멘티';

  // cal bean
  static const String calBeanHeader = '커피챗 매칭 희망 원두를 정해보아요.';
  static const String calBeanDesc1 = '1회 커피챗의 적정 원두는 처음이라면 500원두를\n추천해요!';
  static const String calBeanDesc2 = '얼마든지 다시 수정할 수 있어요.';
  static const String calBeanMin = '0';
  static const String calBeanMax = '1500';
}