import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keodam/core/theme/colors.dart';
import 'package:keodam/core/theme/text_styles.dart';

class ButtonLgWhite extends ConsumerWidget {
  final VoidCallback? onPressed;
  final String title;

  const ButtonLgWhite({super.key, this.onPressed, required this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(pureWhite),
          elevation: WidgetStateProperty.all(0),
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(vertical: 21),
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: backgroundColor01, width: 1.5),
            ),
          ),
          overlayColor: WidgetStateProperty.all(Colors.transparent),
        ),
        child: Text(
          title,
          style: AppTextStyle.bold22.copyWith(color: textBlue02),
        ),
      ),
    );
  }
}
