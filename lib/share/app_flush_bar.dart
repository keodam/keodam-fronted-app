import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:keodam_app/styles/app_colors.dart';

/// 앱 전체에서 사용하는 공통 Flushbar
class AppFlushbar {
  AppFlushbar._();

  /// 성공 메시지 표시
  static void showSuccess({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    Flushbar(
      message: message,
      icon: const Icon(
        Icons.check_circle,
        size: 28.0,
        color: AppColors.success,
      ),
      leftBarIndicatorColor: AppColors.success,
      backgroundColor: AppColors.white,
      messageColor: AppColors.textPrimary,
      duration: duration,
      borderRadius: BorderRadius.circular(8),
      margin: const EdgeInsets.all(16),
      boxShadows: [
        BoxShadow(
          color: AppColors.black.withOpacity(0.1),
          offset: const Offset(0, 2),
          blurRadius: 8,
        ),
      ],
    ).show(context);
  }

  /// 에러 메시지 표시
  static void showError({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    Flushbar(
      message: message,
      icon: const Icon(
        Icons.error,
        size: 28.0,
        color: AppColors.error,
      ),
      leftBarIndicatorColor: AppColors.error,
      backgroundColor: AppColors.white,
      messageColor: AppColors.textPrimary,
      duration: duration,
      borderRadius: BorderRadius.circular(8),
      margin: const EdgeInsets.all(16),
      boxShadows: [
        BoxShadow(
          color: AppColors.black.withOpacity(0.1),
          offset: const Offset(0, 2),
          blurRadius: 8,
        ),
      ],
    ).show(context);
  }

  /// 일반 정보 메시지 표시
  static void showInfo({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    Flushbar(
      message: message,
      icon: const Icon(
        Icons.info_outline,
        size: 28.0,
        color: AppColors.primary,
      ),
      leftBarIndicatorColor: AppColors.primary,
      backgroundColor: AppColors.white,
      messageColor: AppColors.textPrimary,
      duration: duration,
      borderRadius: BorderRadius.circular(8),
      margin: const EdgeInsets.all(16),
      boxShadows: [
        BoxShadow(
          color: AppColors.black.withOpacity(0.1),
          offset: const Offset(0, 2),
          blurRadius: 8,
        ),
      ],
    ).show(context);
  }

  /// 경고 메시지 표시
  static void showWarning({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    Flushbar(
      message: message,
      icon: const Icon(
        Icons.warning,
        size: 28.0,
        color: AppColors.accent,
      ),
      leftBarIndicatorColor: AppColors.accent,
      backgroundColor: AppColors.white,
      messageColor: AppColors.textPrimary,
      duration: duration,
      borderRadius: BorderRadius.circular(8),
      margin: const EdgeInsets.all(16),
      boxShadows: [
        BoxShadow(
          color: AppColors.black.withOpacity(0.1),
          offset: const Offset(0, 2),
          blurRadius: 8,
        ),
      ],
    ).show(context);
  }

  /// 로딩 중 메시지 표시 (dismiss 불가)
  static Flushbar showLoading({
    required BuildContext context,
    required String message,
  }) {
    final flushbar = Flushbar(
      message: message,
      icon: const SizedBox(
        width: 28,
        height: 28,
        child: CircularProgressIndicator(
          strokeWidth: 3,
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
        ),
      ),
      leftBarIndicatorColor: AppColors.primary,
      backgroundColor: AppColors.white,
      messageColor: AppColors.textPrimary,
      isDismissible: false,
      blockBackgroundInteraction: false,
      borderRadius: BorderRadius.circular(8),
      margin: const EdgeInsets.all(16),
      boxShadows: [
        BoxShadow(
          color: AppColors.black.withOpacity(0.1),
          offset: const Offset(0, 2),
          blurRadius: 8,
        ),
      ],
    );

    flushbar.show(context);
    return flushbar;
  }
}