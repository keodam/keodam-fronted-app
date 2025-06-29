import 'package:flutter/material.dart';
import 'package:keodam/core/router/app_router.dart';
import 'package:keodam/core/theme/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Keodam App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: pointColor529DFF,
          unselectedItemColor: textGray,
          backgroundColor: pureWhite,
        ),
        scaffoldBackgroundColor: pureWhite,
      ),
    );
  }
}
