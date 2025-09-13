import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:keodam_app/features/auth/domain/entities/auth.dart';
import 'package:keodam_app/features/user/data/dtos/user_dto.dart';

part 'auth_dto.freezed.dart';
part 'auth_dto.g.dart';

@freezed
sealed class AuthDTO with _$AuthDTO {
  const factory AuthDTO({
    required UserDTO user,
    String? provider,
  }) = _AuthDTO;

  const AuthDTO._();

  factory AuthDTO.fromJson(Map<String, dynamic> json) => _$AuthDTOFromJson(json);

  /// DTO를 Entity로 변환
  Auth toEntity() {
    return Auth(
      user: user.toEntity(),
      provider: provider,
    );
  }
}