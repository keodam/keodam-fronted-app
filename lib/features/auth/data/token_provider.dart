import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'token_provider.g.dart';

@Riverpod(keepAlive: true)
class TokenNotifier extends _$TokenNotifier {
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';

  final _storage = const FlutterSecureStorage();

  @override
  Future<(String?, String?)> build() async {
    final accessToken = await _storage.read(key: _accessTokenKey);
    final refreshToken = await _storage.read(key: _refreshTokenKey);
    return (accessToken, refreshToken);
  }

  /// 토큰 저장
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    try {
      await Future.wait([
        _storage.write(key: _accessTokenKey, value: accessToken),
        _storage.write(key: _refreshTokenKey, value: refreshToken),
      ]);

      state = AsyncData((accessToken, refreshToken));
    } catch (e) {
      debugPrint('토큰 저장 실패: $e');
      rethrow;
    }
  }

  /// 토큰 갱신
  Future<void> refreshTokens({
    required String newAccessToken,
    String? newRefreshToken,
  }) async {
    final currentTokens = state.valueOrNull;
    if (currentTokens == null) return;

    try {
      final refreshToken = newRefreshToken ?? currentTokens.$2;

      if (refreshToken != null) {
        await Future.wait([
          _storage.write(key: _accessTokenKey, value: newAccessToken),
          _storage.write(key: _refreshTokenKey, value: refreshToken),
        ]);
      } else {
        await _storage.write(key: _accessTokenKey, value: newAccessToken);
      }

      state = AsyncData((newAccessToken, refreshToken));
    } catch (e) {
      debugPrint('토큰 갱신 실패: $e');
      rethrow;
    }
  }

  /// 토큰 삭제
  Future<void> clearTokens() async {
    try {
      await Future.wait([
        _storage.delete(key: _accessTokenKey),
        _storage.delete(key: _refreshTokenKey),
      ]);

      state = const AsyncData((null, null));
    } catch (e) {
      debugPrint('토큰 삭제 실패: $e');
      // 실패해도 메모리 상태는 초기화
      state = const AsyncData((null, null));
    }
  }

  /// 현재 액세스 토큰 가져오기
  String? getAccessToken() {
    return state.valueOrNull?.$1;
  }

  /// 현재 리프레시 토큰 가져오기
  String? getRefreshToken() {
    return state.valueOrNull?.$2;
  }

  /// 토큰 보유 여부
  bool get hasTokens {
    final tokens = state.valueOrNull;
    return tokens?.$1 != null &&
        tokens!.$1!.isNotEmpty &&
        tokens.$2 != null &&
        tokens.$2!.isNotEmpty;
  }
}