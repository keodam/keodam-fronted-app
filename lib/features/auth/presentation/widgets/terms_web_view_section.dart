import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keodam/features/auth/providers/terms_provider.dart';

class TermsWebViewSection extends ConsumerWidget {
  final InAppWebViewController? webViewController;
  final Function(InAppWebViewController) onWebViewCreated;

  const TermsWebViewSection({super.key, this.webViewController, required this.onWebViewCreated});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final termsState = ref.watch(termsNotifierProvider);

    return Expanded(
      child: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(url: WebUri('https://www.mozilla.org/en-US/about/legal/terms/services/')),
            onWebViewCreated: onWebViewCreated,
            onLoadStart: (controller, url) {
              ref.read(termsNotifierProvider.notifier).setLoading(true);
              ref.read(termsNotifierProvider.notifier).setError(false);
            },
            onLoadStop: (controller, url) {
              ref.read(termsNotifierProvider.notifier).setLoading(false);
            },
            onLoadError: (controller, url, code, message) {
              ref.read(termsNotifierProvider.notifier).setLoading(false);
              ref.read(termsNotifierProvider.notifier).setError(true);
              debugPrint('웹뷰 에러: $message (코드: $code)');
            },
          ),
          if (termsState.isLoading) const Align(alignment: Alignment.center, child: CircularProgressIndicator()),
          if (termsState.hasError)
            const Align(
              alignment: Alignment.center,
              child: Text('페이지를 불러올 수 없습니다.', style: TextStyle(color: Colors.grey)),
            ),
        ],
      ),
    );
  }
}
