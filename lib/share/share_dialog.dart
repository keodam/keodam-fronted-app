import 'package:flutter/material.dart';
import 'package:keodam_app/styles/app_colors.dart';

class ShareDialog extends StatelessWidget {
  final String title;
  final String? subTitle;
  final String confirmText;
  final VoidCallback? onConfirm;

  const ShareDialog({
    super.key,
    required this.title,
    this.subTitle,
    this.confirmText = '확인',
    this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.black,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            if (subTitle != null) ...[
              const SizedBox(height: 8),
              Text(
                subTitle!,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.gray600,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: onConfirm ?? () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  confirmText,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 간편한 사용을 위한 static method
  static Future<void> show({
    required BuildContext context,
    required String title,
    String? subTitle,
    String confirmText = '확인',
    VoidCallback? onConfirm,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => ShareDialog(
        title: title,
        subTitle: subTitle,
        confirmText: confirmText,
        onConfirm: onConfirm,
      ),
    );
  }
}
/**
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ShareDialog(title: 'asd',);
      },
    );
 */


