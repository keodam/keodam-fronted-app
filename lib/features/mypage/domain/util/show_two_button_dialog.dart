import 'package:flutter/material.dart';
import 'package:keodam/core/theme/colors.dart';
import 'package:keodam/core/theme/text_styles.dart';

Future<bool?> showTwoButtonDialog(
  BuildContext context, {
  required String title,
  String? confirmText,
  String? cancelText,
}) {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 360),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 80.0),
                child: Text(
                  title,
                  style: AppTextStyle.semiBold16.copyWith(color: textBlack),
                  textAlign: TextAlign.center,
                ),
              ),
              Divider(height: 1.5, color: backgroundColor01),
              const SizedBox(height: 1),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 63,
                      child: TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text(
                          cancelText ?? '아니요',
                          style: AppTextStyle.bold18,
                        ),
                      ),
                    ),
                  ),
                  Container(width: 1, height: 63, color: backgroundColor01),
                  Expanded(
                    child: SizedBox(
                      height: 63,
                      child: TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: Text(
                          confirmText ?? '예',
                          style: AppTextStyle.bold18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
