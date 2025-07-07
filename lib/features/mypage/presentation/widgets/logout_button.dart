import 'package:flutter/material.dart';
import 'package:keodam/core/theme/colors.dart';
import 'package:keodam/core/theme/text_styles.dart';

class LogoutButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool enabled;

  const LogoutButton({super.key, required this.onPressed, this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: enabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: pureWhite,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(vertical: 21),
          textStyle: AppTextStyle.bold22,
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(
          '로그아웃',
          style: AppTextStyle.bold22.copyWith(color: textBlack),
        ),
      ),
    );
  }
}
