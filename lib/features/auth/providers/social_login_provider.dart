import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:keodam/features/auth/data/repository/social_login_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
// import 'package:sign_in_with_apple/sign_in_with_apple.dart';

part 'social_login_provider.g.dart';

@riverpod
SocialLoginRepository socialLoginRepository(ref) {
  return SocialLoginRepository();
}

@riverpod
Future<User> loginWithKakao(ref) async {
  final repository = ref.watch(socialLoginRepositoryProvider);
  return await repository.loginWithKakao();
}

@riverpod
Future<GoogleSignInAccount?> loginWithGoogle(ref) async {
  final repository = ref.watch(socialLoginRepositoryProvider);
  return await repository.loginWithGoogle();
}

@riverpod
Future<AuthorizationCredentialAppleID> loginWithApple(
  ref, {
  String? clientId,
  Uri? redirectUri,
}) async {
  final repository = ref.watch(socialLoginRepositoryProvider);
  return await repository.loginWithApple(
    clientId: clientId,
    redirectUri: redirectUri,
  );
}
