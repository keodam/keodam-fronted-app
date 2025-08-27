import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keodam/core/theme/text_styles.dart';
import 'package:keodam/features/auth/providers/auth_provider.dart';

class UserInfoSection extends ConsumerStatefulWidget {
  final TextEditingController genderController;
  final FocusNode genderFocus;
  final FocusNode birthFocus;
  final TextEditingController nameController;
  final TextEditingController birthController;
  final TextEditingController phoneController;

  const UserInfoSection({
    super.key,
    required this.nameController,
    required this.birthController,
    required this.phoneController,
    required this.genderController,
    required this.genderFocus,
    required this.birthFocus,
  });

  @override
  ConsumerState<UserInfoSection> createState() => _UserInfoSectionState();
}

class _UserInfoSectionState extends ConsumerState<UserInfoSection> {
  @override
  Widget build(BuildContext context) {
    final genderDigit = ref.watch(
      authNotifierProvider.select((s) => s.genderDigit),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('이름(실명)', style: AppTextStyle.medium16),
        const SizedBox(height: 8),
        SizedBox(
          width: 131,
          height: 37,
          child: TextField(
            key: const ValueKey('name'),
            controller: widget.nameController,
            onChanged: (value) {
              ref.read(authNotifierProvider.notifier).setFirstName(value);
            },
            decoration: _decoration(context),
          ),
        ),
        const SizedBox(height: 16),
        Text('생년월일', style: AppTextStyle.medium16),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 156,
              height: 37,
              child: TextField(
                key: const ValueKey('birth'),
                controller: widget.birthController,
                focusNode: widget.birthFocus,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(6),
                ],
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (mounted) {
                      ref.read(authNotifierProvider.notifier).setBirthDate(value);
                    }
                  });

                  if (value.length == 6) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (mounted && widget.genderFocus.canRequestFocus) {
                        FocusScope.of(context).requestFocus(widget.genderFocus);
                      }
                    });
                  }
                },
                decoration: _decoration(context),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
              child: Text('-', style: TextStyle(fontSize: 18)),
            ),
            SizedBox(
              width: 156,
              child: Column(
                children: [
                  AnimatedBuilder(
                    animation: widget.genderFocus,
                    builder: (context, child) {
                      return GestureDetector(
                        onTap: () {
                          if (widget.genderFocus.canRequestFocus) {
                            FocusScope.of(context).requestFocus(widget.genderFocus);
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          height: 37,
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: widget.genderFocus.hasFocus ? Colors.blue : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 20,
                                child: TextField(
                                  key: const ValueKey('gender-digit'),
                                  controller: widget.genderController,
                                  focusNode: widget.genderFocus,
                                  maxLength: 1,
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp(r'[1-4]')),
                                  ],
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    counterText: '',
                                    contentPadding: EdgeInsets.zero,
                                    isDense: true,
                                  ),
                                  onChanged: (value) {
                                    if (value.isNotEmpty && !RegExp(r'^[1-4]$').hasMatch(value)) {
                                      widget.genderController.clear();
                                      return;
                                    }
                                    WidgetsBinding.instance.addPostFrameCallback((_) {
                                      if (mounted) {
                                        ref.read(authNotifierProvider.notifier).setGenderDigit(value);
                                      }
                                    });
                                  },
                                ),
                              ),
                              const Text(
                                '******',
                                style: TextStyle(
                                  fontSize: 20,
                                  letterSpacing: 2,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 4),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '뒷 1자리 입력',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  InputDecoration _decoration(BuildContext context) => InputDecoration(
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.blue, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      );
}
