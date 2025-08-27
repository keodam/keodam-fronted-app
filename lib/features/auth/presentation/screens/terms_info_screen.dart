import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keodam/core/theme/text_styles.dart';
import 'package:keodam/features/auth/presentation/widgets/terms_bottom_button.dart';
import 'package:keodam/features/auth/presentation/widgets/terms_web_view_section.dart';

class TermsInfoScreen extends ConsumerStatefulWidget {
  final String? title;
  const TermsInfoScreen({super.key, this.title = ''});

  @override
  ConsumerState<TermsInfoScreen> createState() => _TermsInfoScreenState();
}

class _TermsInfoScreenState extends ConsumerState<TermsInfoScreen> {
  InAppWebViewController? webViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(widget.title ?? '설정', style: AppTextStyle.extraBold20.copyWith(color: Colors.black)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TermsWebViewSection(
            webViewController: webViewController,
            onWebViewCreated: (controller) {
              webViewController = controller;
            },
          ),
          const TermsBottomButton(),
        ],
      ),
    );
  }
}
