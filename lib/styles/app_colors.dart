import 'package:flutter/material.dart';

/// 앱 전체에서 사용되는 색상 상수 정의
class AppColors {
  AppColors._();

  // Primary Colors (Blue 계열)
  static const Color primary = Color(0xFF3A75FF);        // 3A75FF - 메인 블루
  static const Color primaryLight = Color(0xFF92C1FF);   // 92C1FF - 라이트 블루
  static const Color primarySoft = Color(0xFFADD7FD);    // ADD7FD - 소프트 블루
  static const Color primaryBackground = Color(0xFFE6F1FF); // E6F1FF - 블루 백그라운드

  // Gray Scale
  static const Color inputBackground = Color(0xFFFAFAFA);         // FAFAFA - 라이트 그레이

  // Accent Colors
  static const Color accent = Color(0xFFFFA100);         // FFA100 - 오렌지/골드 액센트

  // Neutral Colors
  static const Color black = Color(0xFF020202);          // 020202 - 거의 블랙
  static const Color white = Color(0xFFFFFFFF);          // 기본 화이트

  // Gray Scale
  static const Color gray50 = Color(0xFFFAFAFA);         // FAFAFA - 라이트 그레이
  static const Color gray100 = Color(0xFFF1F1F1);        // F1F1F1 - 매우 연한 그레이
  static const Color gray200 = Color(0xFFD9D9D9);        // D9D9D9 - 연한 그레이
  static const Color gray400 = Color(0xFFA9A9A9);        // A9A9A9 - 중간 그레이
  static const Color gray500 = Color(0xFFA1A1A1);        // A1A1A1 - 중간 다크 그레이
  static const Color gray600 = Color(0xFF707070);        // 707070 - 다크 그레이

  // Status Colors
  static const Color error = Color(0xFFFF2B00);          // FF2B00 - 에러/경고 레드
  static const Color success = Color(0xFF4CAF50);        // 기본 성공 색상

  // Text Colors
  static const Color textPrimary = Color(0xFF020202);    // 020202 - 메인 텍스트
  static const Color textSecondary = Color(0xFF707070);  // 707070 - 보조 텍스트
  static const Color textTertiary = Color(0xFFA1A1A1);   // A1A1A1 - 삼차 텍스트
  static const Color textBlue = Color(0xFF3A75FF);       // 3A75FF - 블루 텍스트
  static const Color textGray = Color(0xFF707070);     // A9A9A9 - 진한 테두리

  // Background Colors
  static const Color backgroundPrimary = Color(0xFFFFFFFF);    // 메인 백그라운드
  static const Color backgroundSecondary = Color(0xFFFAFAFA);  // 보조 백그라운드
  static const Color surface = Color(0xFFF5F5F5);              // 서페이스 색상


  // Border Colors
  static const Color border = Color(0xFFF1F1F1);   // 삼차 백그라운드
  static const Color borderLight = Color(0xFFF1F1F1);    // F1F1F1 - 연한 테두리
  static const Color borderMedium = Color(0xFFD9D9D9);   // D9D9D9 - 중간 테두리
  static const Color borderCheckBox = Color(0xFFE6E6E6);   // E6E6E6 - 체크박스 테두리

}