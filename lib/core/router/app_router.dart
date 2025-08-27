import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:keodam/core/presentation/screens/splash_screen.dart';
import 'package:keodam/core/router/routes.dart';
import 'package:keodam/features/auth/presentation/screens/agreement_screen.dart';
import 'package:keodam/features/auth/presentation/screens/auth_screen.dart';
import 'package:keodam/features/auth/presentation/screens/mobile_auth_screen.dart';
import 'package:keodam/features/auth/presentation/screens/terms_info_screen.dart';
import 'package:keodam/features/explore/presentation/screens/explore_screen.dart';
import 'package:keodam/features/feed/presentation/screens/feed_screen.dart';
import 'package:keodam/features/matching/presentation/screens/matching_screen.dart';
import 'package:keodam/features/mypage/presentation/screens/mypage_screen.dart';
import 'package:keodam/core/presentation/widgets/bottom_navigation.dart'; // 이름 바꿔도 OK

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: Routes.splash,
  errorBuilder: (context, state) {
    if (state.uri.toString().startsWith('kakao')) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go('/auth');
      });
      return const SizedBox.shrink();
    }
    return const Scaffold(body: Center(child: Text('Page not found')));
  },
  routes: [
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: Routes.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(parentNavigatorKey: _rootNavigatorKey, path: Routes.auth, builder: (context, state) => const AuthScreen()),
    GoRoute(path: Routes.agreement, builder: (context, state) => const AgreementScreen()),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: Routes.termsInfo,
      builder: (context, state) {
        final title = state.extra as String? ?? '';
        return TermsInfoScreen(title: title);
      },
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: Routes.mobileAuth,
      builder: (context, state) {
        return MobileAuthScreen();
      },
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => BottomNavigationScaffold(child: child),
      routes: [
        GoRoute(
          parentNavigatorKey: _shellNavigatorKey,
          path: Routes.feed,
          pageBuilder:
              (context, state) => CustomTransitionPage(
                child: FeedScreen(),
                transitionsBuilder: (context, animation, secondaryAnimation, child) => child,
                transitionDuration: Duration.zero,
              ),
        ),
        GoRoute(
          parentNavigatorKey: _shellNavigatorKey,
          path: Routes.explore,
          pageBuilder:
              (context, state) => CustomTransitionPage(
                child: ExploreScreen(),
                transitionsBuilder: (context, animation, secondaryAnimation, child) => child,
                transitionDuration: Duration.zero,
              ),
        ),
        GoRoute(
          parentNavigatorKey: _shellNavigatorKey,
          path: Routes.matching,
          pageBuilder:
              (context, state) => CustomTransitionPage(
                child: MatchingScreen(),
                transitionsBuilder: (context, animation, secondaryAnimation, child) => child,
                transitionDuration: Duration.zero,
              ),
        ),
        GoRoute(
          parentNavigatorKey: _shellNavigatorKey,
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
