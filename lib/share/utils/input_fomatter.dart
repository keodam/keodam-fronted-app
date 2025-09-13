import 'package:flutter/services.dart';

/// 생년월일 입력 포맷터 (YYMMDD 형식)
class BirthDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final text = newValue.text;

    // 숫자만 입력 가능
    if (text.isNotEmpty && !RegExp(r'^\d+$').hasMatch(text)) {
      return oldValue;
    }

    // YYMMDD 형식으로 제한
    if (text.length > 6) {
      return oldValue;
    }

    // 월은 01-12만 가능 (4자리 이상일 때 검사)
    if (text.length >= 4) {
      final month = int.tryParse(text.substring(2, 4)) ?? 0;
      if (month < 1 || month > 12) {
        return oldValue;
      }
    }

    // 일은 01-31만 가능 (6자리일 때 검사)
    if (text.length == 6) {
      final month = int.tryParse(text.substring(2, 4)) ?? 0;
      final day = int.tryParse(text.substring(4, 6)) ?? 0;

      // 월 재검사
      if (month < 1 || month > 12) {
        return oldValue;
      }

      // 일 검사
      if (day < 1 || day > 31) {
        return oldValue;
      }

      // 월별 일수 검사 (간단한 버전)
      final daysInMonth = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
      if (day > daysInMonth[month - 1]) {
        return oldValue;
      }
    }

    return newValue;
  }
}

/// 전화번호 포맷터 (하이픈 자동 추가)
class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final newText = newValue.text.replaceAll('-', '');

    // 숫자만 입력 가능
    if (newText.isNotEmpty && !RegExp(r'^\d+$').hasMatch(newText)) {
      return oldValue;
    }

    // 11자리 제한
    if (newText.length > 11) {
      return oldValue;
    }

    // 하이픈 추가
    String formattedText = '';
    for (int i = 0; i < newText.length; i++) {
      if (i == 3 || i == 7) {
        formattedText += '-';
      }
      formattedText += newText[i];
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}

/// 카드번호 포맷터 (4자리씩 공백 추가)
class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final newText = newValue.text.replaceAll(' ', '');

    // 숫자만 입력 가능
    if (newText.isNotEmpty && !RegExp(r'^\d+$').hasMatch(newText)) {
      return oldValue;
    }

    // 16자리 제한
    if (newText.length > 16) {
      return oldValue;
    }

    // 4자리씩 공백 추가
    String formattedText = '';
    for (int i = 0; i < newText.length; i++) {
      if (i > 0 && i % 4 == 0) {
        formattedText += ' ';
      }
      formattedText += newText[i];
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}