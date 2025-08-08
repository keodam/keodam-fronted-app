import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keodam/core/theme/colors.dart';
import 'package:keodam/core/theme/text_styles.dart';

class CustomTextField extends ConsumerWidget {
  final String hintText;
  final StateProvider<String> targetProvider;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final double? height;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.targetProvider,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.height,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textField = TextField(
      onChanged: (value) {
        ref.read(targetProvider.notifier).state = value;
      },
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
        isDense: true,
        contentPadding:
            height == null
                ? const EdgeInsets.symmetric(vertical: 10, horizontal: 12)
                : EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: (height! - 20) / 2,
                ),
        hintText: hintText,
        hintStyle: AppTextStyle.regular14.copyWith(color: textGray),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: backgroundColor01, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: backgroundColor01, width: 1.5),
        ),
      ),
    );

    return height == null
        ? textField
        : SizedBox(height: height, child: textField);
  }
}
