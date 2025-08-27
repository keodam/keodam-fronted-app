import 'package:flutter/material.dart';
import 'package:keodam/core/theme/colors.dart';

class SocialLoginButton extends StatelessWidget {
  final String imagePath;
  final String text;
  final VoidCallback? onPressed;
  final double imageWidth;
  final double imageHeight;
  final double leftPadding;

  const SocialLoginButton({
    super.key,
    required this.imagePath,
    required this.text,
    this.onPressed,
    this.imageWidth = 20,
    this.imageHeight = 20,
    this.leftPadding = 5,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: backgroundColor01), borderRadius: BorderRadius.circular(10)),
      width: 345,
      height: 54,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: EdgeInsets.zero,
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: leftPadding),
            SizedBox(width: imageWidth, height: imageHeight, child: Image.asset(imagePath, fit: BoxFit.contain)),
            const SizedBox(width: 12),
            Text(text, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
          ],
        ),
      ),
    );
  }
}
