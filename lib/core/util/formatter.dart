import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

final memberCardInput = MaskTextInputFormatter(
  mask: '####-####-####-####',
  filter: {'#': RegExp('[0-9]'), '*': RegExp(r'\*')},
);

final nameInputFormatter = MaskTextInputFormatter(
  mask: '', // 마스킹 없이 필터만 적용
  filter: {'#': RegExp(r'[a-zA-Z가-힣]')},
  type: MaskAutoCompletionType.lazy,
);

// 생년월일: 6자리-1자리 (ex. 990508-2)
final birthInputFormatter = MaskTextInputFormatter(
  mask: '######-#',
  filter: {'#': RegExp(r'[0-9]')},
);

// 휴대폰번호: 010-1234-5678
final phoneInputFormatter = MaskTextInputFormatter(
  mask: '000-0000-0000',
  filter: {'0': RegExp(r'[0-9]')},
);
