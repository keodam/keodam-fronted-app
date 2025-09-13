sealed class AppException implements Exception {
  const AppException(this.message);

  final String message;

  @override
  String toString() => 'AppException: $message';
}

class NetworkException extends AppException {
  const NetworkException([String? message]) : super(message ?? '네트워크 연결에 실패했습니다.');
}

class ServerException extends AppException {
  const ServerException([String? message]) : super(message ?? '서버 오류가 발생했습니다.');
}

class UnauthorizedException extends AppException {
  const UnauthorizedException([String? message]) : super(message ?? '인증이 필요합니다.');
}

class CacheException extends AppException {
  const CacheException([String? message]) : super(message ?? '캐시 작업에 실패했습니다.');
}

class UnknownException extends AppException {
  const UnknownException([String? message]) : super(message ?? '알 수 없는 오류가 발생했습니다.');
}