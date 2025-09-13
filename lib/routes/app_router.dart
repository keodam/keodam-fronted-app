import 'package:go_router/go_router.dart';
import 'package:keodam_app/features/auth/presentation/pages/phone_verification_page.dart';
import 'package:keodam_app/features/auth/presentation/pages/sign_in_page.dart';
import 'package:keodam_app/features/auth/presentation/pages/sign_up_profile_page.dart';
import 'package:keodam_app/features/auth/presentation/pages/terms_page.dart';
import 'package:keodam_app/features/home/home_page.dart';
import 'package:keodam_app/features/splash_screen/presentation/pages/splash_screen_page.dart';

enum AppRoutes {
  splash,
  signIn,
  home,
  terms,
  phoneVerification,
  signUpProfile,
}
final GoRouter appRouter = GoRouter(
  // initialLocation: '/sign-up-profile',
  initialLocation: '/sign-in',
  // initialLocation: '/home',
  routes: [
    GoRoute(
      path: '/splash',
      name: AppRoutes.splash.name,
      builder: (context, state) => const SplashScreenPage(),
    ),


    GoRoute(
      path: '/sign-in',
      name: AppRoutes.signIn.name,
      builder: (context, state) => const SignInPage(),
    ),

    GoRoute(
      path: '/terms',
      name: AppRoutes.terms.name,
      builder: (context, state) => const TermsPage(),
    ),

    GoRoute(
      path: '/phone-verification',
      name: AppRoutes.phoneVerification.name,
      builder: (context, state) => const PhoneVerificationPage(),
    ),

    GoRoute(
      path: '/sign-up-profile',
      name: AppRoutes.signUpProfile.name,
      builder: (context, state) => const SignUpProfilePage(),
    ),

    GoRoute(
      path: '/home',
      name: AppRoutes.home.name,
      builder: (context, state) => const HomePage(),
    ),

  ],
);