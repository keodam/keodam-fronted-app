// * 로그인 후
// await ref.read(authRepositoryProvider.notifier).saveTokens("access_token", "refresh_token");

// * 이후 모든 API 요청 시
// final dio = ref.read(dioProvider);
// await dio.get("/user/profile"); // → Authorization 헤더 자동 포함됨
//주의사항
//Interceptor는 반드시 handler.next(...)로 요청을 넘겨야 합니다.
//
//ref.watch(...)는 Interceptor 내부에서 직접 사용할 수 없습니다 → Provider 외부에서 값을 전달해야 함
//
//AuthInterceptor는 현재 FlutterSecureStorage를 직접 사용 (추후 AuthRepository로 리팩토링 필요)

// lib/app/api/dio.dart
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:keodam_app/dio/dio_interceptor.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';


part 'dio.g.dart';
@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  // .env 파일에서 baseUrl 읽기
  String getBaseUrl() {
    return dotenv.env['API_BASE_URL'] ?? 'http://15.164.80.53/';
  }

  final dio = Dio(
    BaseOptions(
      baseUrl: getBaseUrl(),
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      followRedirects: true,
      maxRedirects: 5,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  // AuthLocalDataSource를 통해 AuthInterceptor 생성
  dio.interceptors.add(DioInterceptor(ref: ref));

  return dio;
}
