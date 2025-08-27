import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:keodam/core/common/secure_storage.dart';
import 'package:keodam/core/router/routes.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          // context.go(Routes.auth);
          checkLogin();
        }
      });
    });
  }

  void checkLogin() async {
    final storage = ref.read(secureStorageProvider);
    final userId = await storage.read(key: USERID);

    try {
      if (userId != null) {
        if (mounted) {
          context.go(Routes.mypage);
        }
      } else {
        if (mounted) {
          context.go(Routes.auth);
        }
      }
    } catch (e) {
      if (mounted) {
        context.go(Routes.auth);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [Image(image: AssetImage('assets/images/splash_logo.png'), width: 240)],
        ),
      ),
    );
  }
}
