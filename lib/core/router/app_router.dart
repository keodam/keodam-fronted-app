import 'package:go_router/go_router.dart';
import 'package:keodam/core/presentation/screens/splash_screen.dart';
import 'package:keodam/core/router/routes.dart';
import 'package:keodam/features/explore/presentation/screens/explore_screen.dart';
import 'package:keodam/features/feed/presentation/screens/feed_screen.dart';
import 'package:keodam/features/matching/presentation/screens/matching_screen.dart';
import 'package:keodam/features/mypage/presentation/screens/mypage_screen.dart';
import 'package:keodam/core/presentation/widgets/bottom_navigation.dart'; // 이름 바꿔도 OK

final GoRouter router = GoRouter(
  initialLocation: Routes.splash,
  routes: [
    GoRoute(path: Routes.splash, builder: (context, state) => const SplashScreen()),

    ShellRoute(
      builder: (context, state, child) => BottomNavigationScaffold(child: child),
      routes: [
        GoRoute(
          path: Routes.feed,
          pageBuilder:
              (context, state) => CustomTransitionPage(
                child: FeedScreen(),
                transitionsBuilder: (context, animation, secondaryAnimation, child) => child,
                transitionDuration: Duration.zero,
              ),
        ),
        GoRoute(
          path: Routes.explore,
          pageBuilder:
              (context, state) => CustomTransitionPage(
                child: ExploreScreen(),
                transitionsBuilder: (context, animation, secondaryAnimation, child) => child,
                transitionDuration: Duration.zero,
              ),
        ),
        GoRoute(
          path: Routes.matching,
          pageBuilder:
              (context, state) => CustomTransitionPage(
                child: MatchingScreen(),
                transitionsBuilder: (context, animation, secondaryAnimation, child) => child,
                transitionDuration: Duration.zero,
              ),
        ),
        GoRoute(
          path: Routes.mypage,
          pageBuilder:
              (context, state) => CustomTransitionPage(
                child: MypageScreen(),
                transitionsBuilder: (context, animation, secondaryAnimation, child) => child,
                transitionDuration: Duration.zero,
              ),
        ),
      ],
    ),
  ],
);
