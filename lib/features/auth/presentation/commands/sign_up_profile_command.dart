import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 회원가입 프로필 페이지의 "다음" 버튼 동작을 정의하는 추상 클래스
abstract class SignUpProfileCommand {
  /// 명령을 실행합니다.
  /// 
  /// [ref] - Riverpod의 WidgetRef 인스턴스
  /// [context] - BuildContext 인스턴스
  Future<void> execute(WidgetRef ref, BuildContext context);
}