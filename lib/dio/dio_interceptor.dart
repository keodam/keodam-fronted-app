import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keodam_app/features/auth/data/token_provider.dart';
import 'package:keodam_app/features/user/presentation/providers/user_state_provider.dart';

/// HTTP 요청/응답에 대한 인증 처리를 담당하는 Interceptor
class DioInterceptor extends Interceptor {
  final Ref ref;

  DioInterceptor({
    required this.ref,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      // TokenProvider에서 토큰 가져오기
      final tokenNotifier = ref.read(tokenNotifierProvider.notifier);
      final accessToken = tokenNotifier.getAccessToken();
      
      if (accessToken != null && accessToken.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $accessToken';
      }
    } catch (e) {
      // 토큰이 없거나 오류 발생 시 그냥 진행
      // (로그인이 필요하지 않은 API도 있을 수 있음)
      debugPrint('토큰 설정 중 오류: $e');
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // 401 오류 시 토큰 갱신 시도
      try {
        final tokenNotifier = ref.read(tokenNotifierProvider.notifier);
        final refreshToken = tokenNotifier.getRefreshToken();
        
        if (refreshToken != null) {
          // 토큰 갱신 API 호출 (Dio를 직접 사용하여 순환 참조 방지)
          final refreshDio = Dio(
            BaseOptions(
              baseUrl: err.requestOptions.baseUrl,
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
              },
            ),
          );
          
          final response = await refreshDio.post(
            '/api/auth/refresh',
            data: {'refreshToken': refreshToken},
          );
          
          // 응답 헤더에서 새 토큰 추출
          final newAccessToken = response.headers['authorization']?.first;
          final newRefreshToken = response.headers['refreshtoken']?.first;
          
          if (newAccessToken != null) {
            // TokenProvider에 새 토큰 저장
            await tokenNotifier.refreshTokens(
              newAccessToken: newAccessToken,
              newRefreshToken: newRefreshToken,
            );
            
            // 원래 요청 재시도
            err.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
            final retryDio = Dio(BaseOptions(baseUrl: err.requestOptions.baseUrl));
            final retryResponse = await retryDio.fetch(err.requestOptions);
            return handler.resolve(retryResponse);
          }
        }
        
        // 토큰 갱신 실패 시 토큰 삭제 및 사용자 정보 초기화
        await tokenNotifier.clearTokens();
        ref.read(userStateNotifierProvider.notifier).clearUser();
      } catch (e) {
        // 토큰 갱신 실패 처리
        final tokenNotifier = ref.read(tokenNotifierProvider.notifier);
        await tokenNotifier.clearTokens();
        ref.read(userStateNotifierProvider.notifier).clearUser();
      }
    }
    handler.next(err);
  }
}