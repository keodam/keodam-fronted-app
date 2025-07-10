import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:keodam/core/theme/colors.dart';

class SectionDivider extends HookWidget  {
  final double height;
  const SectionDivider({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(height: height, color: pureWhite);
  }
}
