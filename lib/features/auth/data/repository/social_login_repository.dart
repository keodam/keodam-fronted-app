import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

import 'dart:io';

import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SocialLoginRepository {
  Future<User?> loginWithKakao() async {
    try {
      if (await isKakaoTalkInstalled()) {
        try {
          await UserApi.instance.loginWithKakaoTalk();
          final user = await UserApi.instance.me();

          // final isRegistered = await checkUserRegistered(user.id);

          // if (isRegistered) {
          //   Navigator.pushReplacementNamed(context, '/home');
          // } else {
          //   // 회원이 아니면 회원가입 화면으로 이동
          //   Navigator.pushNamed(context, '/signup', arguments: user);
          // }
          return user;
        } catch (e) {
          debugPrint('카카오톡 로그인 실패: $e');
        }
      } else {
        try {
          final result = await UserApi.instance.loginWithKakaoAccount();
          if (result.accessToken.isNotEmpty) {
            final user = await UserApi.instance.me();
            return user;
          }
        } catch (e) {
          debugPrint('카카오계정 로그인 실패: $e');
        }
      }
    } catch (e) {
      debugPrint('카카오 로그인 전체 실패: $e');
    }
    return null;
  }

  Future<GoogleSignInAccount?> loginWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);
      final account = await googleSignIn.signIn();
      return account;
    } catch (error, stack) {
      debugPrint('Google login failed: $error');
      debugPrintStack(stackTrace: stack);

      return null;
    }
  }

  Future<AuthorizationCredentialAppleID?> loginWithApple({String? clientId, Uri? redirectUri}) async {
    try {
      if (Platform.isAndroid) {
        return await SignInWithApple.getAppleIDCredential(
          scopes: [AppleIDAuthorizationScopes.email, AppleIDAuthorizationScopes.fullName],
          webAuthenticationOptions: WebAuthenticationOptions(
            clientId: '279905180897-m7jrrlp8rorqd6dvv5sl1qolp58eji2p.apps.googleusercontent.com', // Apple Service ID
            redirectUri: Uri.parse('https://test/callbacks/sign_in_with_apple'),
          ),
        );
      } else {
        // iOS
        return await SignInWithApple.getAppleIDCredential(
          scopes: [AppleIDAuthorizationScopes.email, AppleIDAuthorizationScopes.fullName],
        );
      }
    } on PlatformException catch (e) {
      debugPrint('Apple login PlatformException: ${e.message}');
      return null;
    } catch (e, s) {
      debugPrint('Apple login error: $e');
      debugPrintStack(stackTrace: s);
      return null;
    }
  }
}
