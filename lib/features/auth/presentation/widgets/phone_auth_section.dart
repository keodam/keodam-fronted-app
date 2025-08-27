import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keodam/core/theme/colors.dart';
import 'package:keodam/core/theme/text_styles.dart';
import 'package:keodam/features/auth/providers/auth_provider.dart';
import 'package:keodam/features/auth/providers/timer_provider.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PhoneAuthSection extends ConsumerStatefulWidget {
  final VoidCallback onRequestAuth;
  final FocusNode phoneFocusNode;
  final ScrollController? scrollController;

  const PhoneAuthSection({super.key, required this.phoneFocusNode, required this.onRequestAuth, this.scrollController});

  @override
  ConsumerState<PhoneAuthSection> createState() => _PhoneAuthSectionState();
}

class _PhoneAuthSectionState extends ConsumerState<PhoneAuthSection> {
  late TextEditingController _phoneController;
  late MaskTextInputFormatter _phoneNumberMaskFormatter;
  late FocusNode _phoneFocusNode;
  final GlobalKey _phoneSectionKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
    _phoneNumberMaskFormatter = MaskTextInputFormatter(mask: '###-####-####', filter: {'#': RegExp(r'[0-9]')});
    _phoneFocusNode = FocusNode();

    _phoneFocusNode.addListener(() {
      if (_phoneFocusNode.hasFocus && widget.scrollController != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            _scrollToWidget();
          }
        });
      }
    });
  }

  void _scrollToWidget() {
    if (_phoneSectionKey.currentContext != null && widget.scrollController != null) {
      Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted && widget.scrollController != null) {
          final targetOffset = 150.0;

          widget.scrollController!.jumpTo(targetOffset);
        }
      });
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final timerState = ref.watch(timerNotifierProvider);

    if (_phoneController.text != authState.phoneNumber) {
      _phoneController.text = authState.phoneNumber;
    }

    return Column(
      key: _phoneSectionKey,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('휴대폰번호', style: AppTextStyle.medium16),
        const SizedBox(height: 5),
        Row(
          children: [
            Flexible(
              flex: 2,
              child: SizedBox(
                height: 44,
                child: TextField(
                  controller: _phoneController,
                  focusNode: _phoneFocusNode,
                  onChanged: (value) {
                    ref.read(authNotifierProvider.notifier).setPhoneNumber(value);
                  },
                  keyboardType: TextInputType.phone,
                  inputFormatters: [_phoneNumberMaskFormatter],
                  enabled: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.blue, width: 2),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 17),
            Flexible(
              flex: 1,
              child: GestureDetector(
                onTap: timerState == 0 ? widget.onRequestAuth : null,
                child: Container(
                  height: 44,
                  decoration: BoxDecoration(
                    border: Border.all(color: backgroundColor01),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(child: Text('인증요청', style: AppTextStyle.bold16.copyWith(color: textBlue02))),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
