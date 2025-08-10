import 'dart:math';
import 'package:flutter/material.dart';
import 'package:keodam/core/theme/colors.dart';
import 'package:keodam/core/theme/text_styles.dart';

class RouletteSlicesPainter extends CustomPainter {
  final List<String> items;
  RouletteSlicesPainter(this.items);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final sweepAngle = 2 * pi / items.length;
    final paint = Paint()..style = PaintingStyle.fill;

    for (int i = 0; i < items.length; i++) {
      paint.color = i.isEven ? const Color(0xffE6F1FF) : pureWhite;

      final startAngle = i * sweepAngle;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        true,
        paint,
      );
      final textPainter = TextPainter(
        text: TextSpan(
          text: items[i],
          style: AppTextStyle.regular12.copyWith(color: textBlack),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();

      final angle = startAngle + sweepAngle / 2;
      final textOffset = Offset(
        center.dx + (radius * 0.7) * cos(angle) - textPainter.width / 2,
        center.dy + (radius * 0.7) * sin(angle) - textPainter.height / 2,
      );

      textPainter.paint(canvas, textOffset);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
