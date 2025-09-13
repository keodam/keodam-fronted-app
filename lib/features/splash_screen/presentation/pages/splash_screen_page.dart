import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:keodam_app/core/error/failures.dart';
import 'package:keodam_app/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:keodam_app/routes/app_router.dart';

class SplashScreenPage extends HookConsumerWidget {
  const SplashScreenPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateNotifierProvider);
    final authNotifier = ref.read(authStateNotifierProvider.notifier);

    useEffect(() {
      // 앱 시작 시 인증 상태 초기화
      WidgetsBinding.instance.addPostFrameCallback((_) {
        authNotifier.initializeAuth();
      });
      return null;
    }, []);

    // 상태에 따른 라우팅
    ref.listen(authStateNotifierProvider, (previous, next) {
      next.when(
        initial: () {
          // 초기 상태에서는 아무것도 하지 않음
        },
        loading: () {
          // 로딩 중에는 아무것도 하지 않음
        },
        authenticated: (_) {
          // 인증된 사용자는 홈 페이지로 이동
          context.goNamed(AppRoutes.home.name);
        },
        unauthenticated: () {
          // 인증되지 않은 사용자는 로그인 페이지로 이동
          context.goNamed(AppRoutes.signIn.name);
        },
        error: (_) {
          // 에러 상태에서는 재시도 UI 표시
        },
      );
    });

    return Scaffold(
      body: Center(
        child: authState.when(
          initial: () => const _LoadingWidget(),
          loading: () => const _LoadingWidget(),
          authenticated: (_) => const _LoadingWidget(),
          unauthenticated: () => const _LoadingWidget(),
          error: (failure) => _ErrorWidget(
            message: switch (failure) {
              NetworkFailure(message: final message) => message ?? '네트워크 연결을 확인해주세요.',
              ServerFailure(message: final message) => message ?? '서버 오류가 발생했습니다.',
              UnauthorizedFailure(message: final message) => message ?? '인증이 필요합니다.',
              CacheFailure(message: final message) => message ?? '캐시 오류가 발생했습니다.',
              UnknownFailure(message: final message) => message ?? '알 수 없는 오류가 발생했습니다.',
            },
            onRetry: () => authNotifier.retry(),
          ),
        ),
      ),
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(),
        SizedBox(height: 16),
        Text(
          'Keodam',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorWidget({
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.error_outline,
          size: 64,
          color: Colors.red,
        ),
        const SizedBox(height: 16),
        Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.red,
          ),
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: onRetry,
          child: const Text('재시도'),
        ),
      ],
    );
  }
}
