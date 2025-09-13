/// 시간 관련 포맷팅 유틸리티
class TimeFormatter {
  /// 초를 MM:SS 형식으로 변환
  static String formatSeconds(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  /// 초를 HH:MM:SS 형식으로 변환
  static String formatSecondsToHMS(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final remainingSeconds = seconds % 60;

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:'
          '${minutes.toString().padLeft(2, '0')}:'
          '${remainingSeconds.toString().padLeft(2, '0')}';
    }

    return '${minutes.toString().padLeft(2, '0')}:'
        '${remainingSeconds.toString().padLeft(2, '0')}';
  }

  /// DateTime을 지정된 포맷으로 변환
  static String formatDateTime(DateTime dateTime, {String format = 'yyyy-MM-dd'}) {
    switch (format) {
      case 'yyyy-MM-dd':
        return '${dateTime.year}-'
            '${dateTime.month.toString().padLeft(2, '0')}-'
            '${dateTime.day.toString().padLeft(2, '0')}';
      case 'yyyy.MM.dd':
        return '${dateTime.year}.'
            '${dateTime.month.toString().padLeft(2, '0')}.'
            '${dateTime.day.toString().padLeft(2, '0')}';
      case 'MM/dd/yyyy':
        return '${dateTime.month.toString().padLeft(2, '0')}/'
            '${dateTime.day.toString().padLeft(2, '0')}/'
            '${dateTime.year}';
      case 'dd/MM/yyyy':
        return '${dateTime.day.toString().padLeft(2, '0')}/'
            '${dateTime.month.toString().padLeft(2, '0')}/'
            '${dateTime.year}';
      case 'HH:mm':
        return '${dateTime.hour.toString().padLeft(2, '0')}:'
            '${dateTime.minute.toString().padLeft(2, '0')}';
      case 'yyyy-MM-dd HH:mm':
        return '${dateTime.year}-'
            '${dateTime.month.toString().padLeft(2, '0')}-'
            '${dateTime.day.toString().padLeft(2, '0')} '
            '${dateTime.hour.toString().padLeft(2, '0')}:'
            '${dateTime.minute.toString().padLeft(2, '0')}';
      default:
        return dateTime.toString();
    }
  }

  /// 상대 시간 표시 (몇 분 전, 몇 시간 전 등)
  static String formatRelativeTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return '방금 전';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}분 전';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}시간 전';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}일 전';
    } else if (difference.inDays < 30) {
      return '${difference.inDays ~/ 7}주 전';
    } else if (difference.inDays < 365) {
      return '${difference.inDays ~/ 30}개월 전';
    } else {
      return '${difference.inDays ~/ 365}년 전';
    }
  }

  /// 남은 시간 표시
  static String formatRemainingTime(DateTime targetTime) {
    final now = DateTime.now();
    final difference = targetTime.difference(now);

    if (difference.isNegative) {
      return '만료됨';
    }

    if (difference.inDays > 0) {
      return '${difference.inDays}일 남음';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}시간 남음';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}분 남음';
    } else {
      return '${difference.inSeconds}초 남음';
    }
  }
}