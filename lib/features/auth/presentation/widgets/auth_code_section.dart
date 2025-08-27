import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keodam/core/theme/colors.dart';
import 'package:keodam/core/theme/text_styles.dart';
import 'package:keodam/features/auth/providers/auth_provider.dart';
import 'package:keodam/features/auth/providers/timer_provider.dart';

class AuthCodeSection extends ConsumerStatefulWidget {
  final TextEditingController authCodeController;
  final FocusNode authCodeFocusNode;
  final VoidCallback onResendRequest;
  final ScrollController? scrollController;

  const AuthCodeSection({
    super.key,
    required this.authCodeController,
    required this.authCodeFocusNode,
    required this.onResendRequest,
    this.scrollController,
  });

  @override
  ConsumerState<AuthCodeSection> createState() => _AuthCodeSectionState();
}

class _AuthCodeSectionState extends ConsumerState<AuthCodeSection> {
  final GlobalKey _authCodeSectionKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    widget.authCodeFocusNode.addListener(() {
      if (widget.authCodeFocusNode.hasFocus && widget.scrollController != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            _scrollToWidget();
          }
        });
      }
    });
  }

  void _scrollToWidget() {
    if (_authCodeSectionKey.currentContext != null && widget.scrollController != null) {
      Future.delayed(const Duration(milliseconds: 150), () {
        if (mounted && widget.scrollController != null) {
          final targetOffset = 200.0;

          widget.scrollController!.jumpTo(targetOffset);
        }
      });
    }
  }

  String _formatTime(int seconds) {
    final min = seconds ~/ 60;
    final sec = seconds % 60;
    return '${min.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final timerState = ref.watch(timerNotifierProvider);

    if (!authState.isPhoneNumberVerified) {
      return const SizedBox.shrink();
    }

    return Column(
      key: _authCodeSectionKey,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 22),
        RichText(
          text: TextSpan(
            text: '휴대폰으로 전송된\n',
            style: AppTextStyle.bold18.copyWith(color: Colors.black),
            children: <TextSpan>[
              TextSpan(text: '인증번호', style: AppTextStyle.bold18.copyWith(color: textBlue02)),
              TextSpan(text: '를 입력해주세요', style: AppTextStyle.bold18.copyWith(color: Colors.black)),
            ],
          ),
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            Flexible(
              flex: 2,
              child: SizedBox(
                height: 44,
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: widget.authCodeController,
                  focusNode: widget.authCodeFocusNode,
                  onChanged: (value) {
                    print(value);
                    ref.read(authNotifierProvider.notifier).setAuthCode(value);
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.blue, width: 2),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    suffix:
                        timerState > 0
                            ? Text(
                              _formatTime(timerState),
                              style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                            )
                            : null,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 17),
            Flexible(
              flex: 1,
              child: GestureDetector(
                onTap: widget.onResendRequest,
                child: Container(
                  height: 44,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F1FE),
                    border: Border.all(color: const Color(0xFFE8F1FE)),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      '다시요청',
                      style: TextStyle(color: Colors.blue.shade600, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
