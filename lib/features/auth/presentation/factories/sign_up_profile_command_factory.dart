import 'package:keodam_app/features/auth/presentation/commands/default_next_command.dart';
import 'package:keodam_app/features/auth/presentation/commands/education_status_next_command.dart';
import 'package:keodam_app/features/auth/presentation/commands/mentoring_bean_next_command.dart';
import 'package:keodam_app/features/auth/presentation/commands/profile_image_next_command.dart';
import 'package:keodam_app/features/auth/presentation/commands/referral_next_command.dart';
import 'package:keodam_app/features/auth/presentation/commands/role_next_command.dart';
import 'package:keodam_app/features/auth/presentation/commands/sign_up_profile_command.dart';

/// 회원가입 프로필 페이지의 페이지 인덱스에 따라 
/// 적절한 Command 객체를 생성하는 Factory 클래스
class SignUpProfileCommandFactory {
  /// 페이지 인덱스에 따라 적절한 Command를 생성합니다.
  /// 
  /// [pageIndex] - 현재 페이지 인덱스
  /// [initialPage] - 초기 페이지 설정값
  /// 
  /// Returns: 해당 페이지에 맞는 Command 객체
  static SignUpProfileCommand createCommand(int pageIndex, String? initialPage) {
    switch (pageIndex) {
      case 3:
        return ProfileImageNextCommand(initialPage: initialPage);
      case 4:
        return EducationStatusNextCommand(initialPage: initialPage);
      case 5:
        return ReferralNextCommand(initialPage: initialPage);
      case 6:
        return RoleNextCommand(initialPage: initialPage);
      case 7:
        return MentoringBeanNextCommand(initialPage: initialPage);
      default:
        return DefaultNextCommand(initialPage: initialPage);
    }
  }
}