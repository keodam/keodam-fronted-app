import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:keodam_app/features/user/domain/entities/user.dart';
part 'auth.freezed.dart';
@freezed
sealed class Auth with _$Auth {
  const factory Auth({
    required User user,
    String? provider,
  }) = _Auth;
  const Auth._();
}