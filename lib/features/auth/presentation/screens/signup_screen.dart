import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keodam/features/auth/presentation/widgets/mobile_auth_bottom_button.dart';
import 'package:keodam/features/auth/presentation/widgets/user_info_section.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  late final TextEditingController nameController;
  late final TextEditingController birthController;
  late final TextEditingController genderController;
  late final TextEditingController phoneController;
  late final FocusNode genderFocus;
  late final FocusNode birthFocus;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    birthController = TextEditingController();
    genderController = TextEditingController();
    phoneController = TextEditingController();
    genderFocus = FocusNode();
    birthFocus = FocusNode();
  }

  @override
  void dispose() {
    nameController.dispose();
    birthController.dispose();
    genderController.dispose();
    phoneController.dispose();
    genderFocus.dispose();
    birthFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('회원가입')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: UserInfoSection(
          nameController: nameController,
          birthController: birthController,
          phoneController: phoneController,
          genderController: genderController,
          genderFocus: genderFocus,
          birthFocus: birthFocus,
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
          child: MobileAuthBottomButton(onPressed: () {}),
        ),
      ),
    );
  }
}
