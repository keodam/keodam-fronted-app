import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keodam/core/router/app_router.dart';
import 'package:keodam/core/theme/colors.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  KakaoSdk.init(nativeAppKey: '${dotenv.env['KaKaoNativeAppKey']}');
  runApp(const ProviderScope(child: MyApp()));
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
