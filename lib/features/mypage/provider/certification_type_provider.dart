import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keodam/features/mypage/data/model/certification_type.dart';

final certificationTypeProvider = StateProvider<CertificationType?>(
  (ref) => null,
);
