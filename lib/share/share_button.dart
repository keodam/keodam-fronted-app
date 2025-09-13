import 'package:flutter/material.dart';
import 'package:keodam_app/styles/app_colors.dart';

/// 공통 앱 버튼
class ShareButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isOutlined;
  final bool isSmall;
  final Color? textColor;
  final double? width;
  final Widget? icon;
  final bool disabled;

  const ShareButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.width,
    this.icon,
    this.disabled = false,
  })  : isOutlined = false,
        isSmall = false,
        textColor = null;

  const ShareButton.outline({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.textColor,
    this.width,
    this.icon,
    this.disabled = false,
  })  : isOutlined = true,
        isSmall = false;

  const ShareButton.small({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.width,
    this.icon,
    this.disabled = false,
  })  : isOutlined = false,
        isSmall = true,
        textColor = null;

  const ShareButton.smallOutline({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.textColor,
    this.width,
    this.icon,
    this.disabled = false,
  })  : isOutlined = true,
        isSmall = true;

  double get _height {
    // Small 버튼은 TextFormField와 같은 높이 (48px)
    return isSmall ? 44 : 66;
  }

  double get _fontSize {
    // 모든 버튼의 텍스트 크기를 14로 통일
    return isSmall ? 16 : 22;
  }

  EdgeInsetsGeometry get _padding {
    if (isSmall) {
      // Small 버튼은 TextFormField와 같은 패딩
      return const EdgeInsets.symmetric(horizontal: 16,);
    }
    return const EdgeInsets.symmetric(horizontal: 24,);
  }

  Color get _backgroundColor {
    if (disabled || isLoading || onPressed == null) {
      return AppColors.border;
    }
    if (isOutlined) {
      return Colors.white;
    }
    return AppColors.primary;
  }

  Color get _textColor {
    if (disabled || onPressed == null) {
      return AppColors.gray400;
    }
    if (textColor != null) return textColor!;
    if (isOutlined) {
      return AppColors.primary;
    }
    return Colors.white;
  }

  Border? get _border {
    if (isOutlined) {
      return Border.all(
        color: disabled ? AppColors.inputBackground : AppColors.border,
        width: 1.5,
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final isEnabled = !disabled && !isLoading && onPressed != null;

    Widget child;

    if (isLoading) {
      child = SizedBox(
        width: isSmall ? 16 : 20,
        height: isSmall ? 16 : 20,
        child: CircularProgressIndicator(
          strokeWidth: isSmall ? 2 : 3,
          color: _textColor,
        ),
      );
    } else {
      child = Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            icon!,
            const SizedBox(width: 8),
          ],
          Text(
            text,
            style: TextStyle(
              color: _textColor,
              fontWeight: FontWeight.w600,
              fontSize: _fontSize,
            ),
          ),
        ],
      );
    }

    return GestureDetector(
      onTap: isEnabled ? onPressed : null,
      child: Container(
        height: _height,
        width: width,
        padding: _padding,
        decoration: BoxDecoration(
          color: _backgroundColor,
          borderRadius: BorderRadius.circular(isSmall ? 8 : 10),
          border: _border,
        ),
        child: Center(child: child),
      ),
    );
  }
}