import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  KakaoSdk.init(nativeAppKey: '7d17daf6f8bcac8911ffbd1e11b8fa4e');

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

