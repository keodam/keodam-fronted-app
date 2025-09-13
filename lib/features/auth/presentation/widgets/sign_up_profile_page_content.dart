import 'package:flutter/material.dart';
import 'package:keodam_app/features/auth/presentation/widgets/sign_up_profile_views/cal_bean.dart';
import 'package:keodam_app/features/auth/presentation/widgets/sign_up_profile_views/education_status.dart';
import 'package:keodam_app/features/auth/presentation/widgets/sign_up_profile_views/nickname.dart';
import 'package:keodam_app/features/auth/presentation/widgets/sign_up_profile_views/profile.dart';
import 'package:keodam_app/features/auth/presentation/widgets/sign_up_profile_views/recommend.dart';
import 'package:keodam_app/features/auth/presentation/widgets/sign_up_profile_views/role.dart';
import 'package:keodam_app/features/auth/presentation/widgets/sign_up_profile_views/welcome.dart';

/// 회원가입 프로필 페이지의 현재 페이지에 맞는 컨텐츠를 표시하는 위젯
class SignUpProfilePageContent extends StatelessWidget {
  final int currentPage;
  
  const SignUpProfilePageContent({
    super.key,
    required this.currentPage,
  });
  
  @override
  Widget build(BuildContext context) {
    switch (currentPage) {
      case 1:
        return const Welcome();
      case 2:
        return const Nickname();
      case 3:
        return const Profile();
      case 4:
        return const EducationStatus();
      case 5:
        return const Recommend();
      case 6:
        return const Role();
      case 7:
        return const CalBean();
      default:
        return const SizedBox.shrink();
    }
  }
}