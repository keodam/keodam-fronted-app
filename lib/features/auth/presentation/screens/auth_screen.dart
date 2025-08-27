import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keodam/features/auth/presentation/widgets/auth_bottom_text.dart';
import 'package:keodam/features/auth/presentation/widgets/auth_logo_section.dart';
import 'package:keodam/features/auth/presentation/widgets/social_login_section.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future.microtask(() async {
      final prefs = await SharedPreferences.getInstance();
      final isLoggedIn = prefs.getBool('isKakaoLoggedIn') ?? false;
      // Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      //   return AgreementScreen();
      // }));
      // if (isLoggedIn && context.mounted) {
      //   //context.go('/auth/agreement');
      // }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 106, right: 22, left: 16),
              child: Center(
                child: Column(
                  children: [const AuthLogoSection(), const SizedBox(height: 117), const SocialLoginSection()],
                ),
              ),
            ),
            const AuthBottomText(),
          ],
        ),
      ),
    );
  }
}
