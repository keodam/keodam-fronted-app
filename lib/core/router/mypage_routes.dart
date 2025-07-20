import 'package:go_router/go_router.dart';
import 'package:keodam/features/mypage/presentation/screens/community_profile_edit.dart';
import 'package:keodam/features/mypage/presentation/screens/delete_account_screen.dart';
import 'package:keodam/features/mypage/presentation/screens/mentee_level_guide.dart';
import 'package:keodam/features/mypage/presentation/screens/mypage_screen.dart';
import 'package:keodam/features/mypage/presentation/screens/mento_level_guide.dart';
import 'package:keodam/features/mypage/presentation/screens/support_developer_screen.dart';
import 'package:keodam/core/router/routes.dart';

final mypageRoutes = GoRoute(
  path: Routes.mypage,
  pageBuilder:
      (context, state) => CustomTransitionPage(
        child: MypageScreen(),
        transitionsBuilder:
            (context, animation, secondaryAnimation, child) => child,
        transitionDuration: Duration.zero,
      ),
  routes: [
    GoRoute(
      path: Routes.mypageMentorLevelGuide,
      builder: (context, state) => const MentoLevelGuide(),
    ),
    GoRoute(
      path: Routes.mypageMenteeLevelGuide,
      builder: (context, state) => const MenteeLevelGuide(),
    ),
    GoRoute(
      path: Routes.mypageSupportDeveloper,
      builder: (context, state) => const SupportDeveloperScreen(),
    ),
    GoRoute(
      path: Routes.mypageProfileEdit,
      builder: (context, state) => const CommunityProfileEdit(),
    ),
    GoRoute(
      path: Routes.mypageDeleteAccount,
      builder: (context, state) => const DeleteAccountScreen(),
    ),
  ],
);
