import 'package:flutter/material.dart';
import 'package:keodam/core/theme/colors.dart';
import 'package:keodam/core/theme/text_styles.dart';

class SingleButtonDialog extends StatelessWidget {
  final String title;
  final String? message;
  final String buttonText;
  final VoidCallback? onPressed;

  const SingleButtonDialog({
    super.key,
    required this.title,
    this.message,
    this.buttonText = '확인',
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 360),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 52.0),
                child: Column(
                  children: [
                    Text(
                      title,
                      style: AppTextStyle.semiBold16.copyWith(color: textBlack),
                      textAlign: TextAlign.center,
                    ),
                    if (message != null) ...[
                      const SizedBox(height: 12),
                      Text(
                        message!,
                        style: AppTextStyle.regular14.copyWith(color: textGray),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ],
                ),
              ),
              Divider(height: 1, color: backgroundColor01),
              SizedBox(
                height: 48,
                width: double.infinity,
                child: TextButton(
                  onPressed: onPressed ?? () => Navigator.of(context).pop(),
                  style: TextButton.styleFrom(
                    foregroundColor: textBlue02,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                  ),
                  child: Text(buttonText, style: AppTextStyle.bold18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
