import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keodam/core/theme/colors.dart';
import 'package:keodam/core/theme/text_styles.dart';
import 'package:keodam/features/auth/presentation/widgets/user_info_section.dart';
import 'package:keodam/features/auth/providers/auth_provider.dart';
import 'package:keodam/features/auth/providers/timer_provider.dart';
import 'package:keodam/features/auth/presentation/widgets/auth_code_section.dart';
import 'package:keodam/features/auth/presentation/widgets/carrier_selection_section.dart';
import 'package:keodam/features/auth/presentation/widgets/mobile_auth_bottom_button.dart';
import 'package:keodam/features/auth/presentation/widgets/phone_auth_section.dart';

class MobileAuthScreen extends ConsumerStatefulWidget {
  const MobileAuthScreen({super.key});

  @override
  ConsumerState<MobileAuthScreen> createState() => _MobileAuthScreenState();
}

class _MobileAuthScreenState extends ConsumerState<MobileAuthScreen> {
  late final TextEditingController _nameController;
  late final TextEditingController _birthController;
  late final TextEditingController _phoneController;
  late final TextEditingController _genderController;
  late final TextEditingController _authCodeController;

  late final FocusNode _genderFocusNode;
  late final FocusNode _birthFocusNode;
  late final FocusNode _authCodeFocusNode;
  late final FocusNode _phoneFocusNode;

  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController();
    _birthController = TextEditingController();
    _phoneController = TextEditingController();
    _genderController = TextEditingController();
    _authCodeController = TextEditingController();

    _genderFocusNode = FocusNode();
    _birthFocusNode = FocusNode();
    _authCodeFocusNode = FocusNode();
    _phoneFocusNode = FocusNode();

    _scrollController = ScrollController();

    _genderFocusNode.addListener(_onFocusChange);
    _birthFocusNode.addListener(_onFocusChange);
    _authCodeFocusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _nameController.dispose();
    _birthController.dispose();
    _phoneController.dispose();
    _genderController.dispose();
    _authCodeController.dispose();

    _genderFocusNode.dispose();
    _birthFocusNode.dispose();
    _authCodeFocusNode.dispose();

    _scrollController.dispose();
    super.dispose();
  }

  void _onRequestAuth() {
    final timerState = ref.read(timerNotifierProvider);
    if (timerState == 0) {
      ref.read(authNotifierProvider.notifier).setPhoneNumberVerified(true);
      ref.read(timerNotifierProvider.notifier).startTimer(180);
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) {
          FocusScope.of(context).requestFocus(_authCodeFocusNode);
        }
      });
    }
  }

  void _onResendRequest() {
    ref.read(timerNotifierProvider.notifier).startTimer(180);
    if (mounted) {
      FocusScope.of(context).requestFocus(_authCodeFocusNode);
    }
  }

  bool get _canSubmit {
    return _nameController.text.trim().isNotEmpty &&
        _birthController.text.trim().isNotEmpty &&
        _genderController.text.trim().isNotEmpty &&
        _phoneController.text.trim().isNotEmpty &&
        _authCodeController.text.trim().isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
        ),
        title: Text('휴대폰 본인인증', style: AppTextStyle.extraBold20.copyWith(color: Colors.black)),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  Divider(thickness: 7, color: backgroundColor01),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 48),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 사용자 정보 입력 위젯
                        UserInfoSection(
                          nameController: _nameController,
                          birthController: _birthController,
                          phoneController: _phoneController,
                          genderController: _genderController,
                          genderFocus: _genderFocusNode,
                          birthFocus: _birthFocusNode,
                        ),
                        const SizedBox(height: 21),
                        CarrierSelectionSection(phoneFocusNode: _phoneFocusNode),
                        const SizedBox(height: 30),
                        PhoneAuthSection(
                          onRequestAuth: _onRequestAuth,
                          scrollController: _scrollController,
                          phoneFocusNode: _phoneFocusNode,
                        ),
                        AuthCodeSection(
                          authCodeController: _authCodeController,
                          authCodeFocusNode: _authCodeFocusNode,
                          onResendRequest: _onResendRequest,
                          scrollController: _scrollController,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: AnimatedPadding(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        padding: EdgeInsets.only(bottom: _authCodeFocusNode.hasFocus ? MediaQuery.of(context).viewInsets.bottom : 0.0),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            child: MobileAuthBottomButton(
              onPressed:
                  _canSubmit
                      ? () {
                        final name = _nameController.text.trim();
                        final birth = '${_birthController.text.trim()}-${_genderController.text.trim()}';
                        final phone = _phoneController.text.trim();
                        final phoneAuthCode = _authCodeController.text.trim();
                        if (name == '') {
                          showPhoneAuthErrorAlertDialog(context, '이름을 확인해주세요.\n(ex.홍길동) | 한글, 영문만 가능');
                          return;
                        } else if (birth == '') {
                          showPhoneAuthErrorAlertDialog(context, '생년월일을 확인해주세요.\n(ex.990508 - 2)');
                          return;
                        } else if (phone == '') {
                          showPhoneAuthErrorAlertDialog(context, '휴대폰번호 형식을 확인해주세요.\n(ex.010-1234-5678)');
                          return;
                        } else if (phoneAuthCode == '') {
                          showPhoneAuthErrorAlertDialog(context, '인증번호가 일치하지 않습니다.\n다시 입력해주세요.');
                          return;
                        }
                        _onRequestAuth();
                      }
                      : null,
            ),
          ),
        ),
      ),
    );
  }
}

void showPhoneAuthErrorAlertDialog(BuildContext context, String content) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 40),
        child: Container(
          width: 357,
          height: 250,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.white),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 81),
              Text(content, textAlign: TextAlign.center, style: AppTextStyle.semiBold16),
              const SizedBox(height: 24),
              const Spacer(),
              Divider(height: 1.5, color: backgroundColor01),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: TextButton.styleFrom(foregroundColor: Colors.blue, textStyle: AppTextStyle.bold18),
                  child: const Text('확인'),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
