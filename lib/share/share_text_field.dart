import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keodam_app/styles/app_colors.dart';

/// 공통 텍스트 필드 위젯
class ShareTextField extends StatelessWidget {
  final String? label;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  final int? maxLength;
  final double? width;
  final TextAlign textAlign;
  final Widget? suffix;
  final bool enabled;
  final ValueChanged<String>? onChanged;
  final Color? fillColor;
  final Color? hintColor;
  final EdgeInsetsGeometry? contentPadding;
  final double borderRadius;
  final double height;
  final FocusNode? focusNode;
  final bool autofocus;
  final bool readOnly;
  final VoidCallback? onTap;
  final bool showCounter;
  final TextStyle? style;
  final TextStyle? labelStyle;
  final double labelSpacing;

  const ShareTextField({
    super.key,
    this.label,
    this.hintText,
    this.controller,
    this.keyboardType,
    this.inputFormatters,
    this.obscureText = false,
    this.maxLength,
    this.width,
    this.textAlign = TextAlign.start,
    this.suffix,
    this.enabled = true,
    this.onChanged,
    this.fillColor,
    this.hintColor,
    this.contentPadding,
    this.borderRadius = 8,
    this.height = 44,
    this.focusNode,
    this.autofocus = false,
    this.readOnly = false,
    this.onTap,
    this.showCounter = false,
    this.style,
    this.labelStyle,
    this.labelSpacing = 8,
  }) : _isOutline = false;

  /// Outline 스타일의 텍스트 필드 생성자
  /// 흰색 배경에 1.5 width의 AppColors.border 테두리
  const ShareTextField.outline({
    super.key,
    this.label,
    this.hintText,
    this.controller,
    this.keyboardType,
    this.inputFormatters,
    this.obscureText = false,
    this.maxLength,
    this.width,
    this.textAlign = TextAlign.start,
    this.suffix,
    this.enabled = true,
    this.onChanged,
    this.fillColor,
    this.hintColor,
    this.contentPadding,
    this.borderRadius = 8,
    this.height = 44,
    this.focusNode,
    this.autofocus = false,
    this.readOnly = false,
    this.onTap,
    this.showCounter = false,
    this.style,
    this.labelStyle,
    this.labelSpacing = 8,
  }) : _isOutline = true;

  final bool _isOutline;

  @override
  Widget build(BuildContext context) {
    Widget textField = TextField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      obscureText: obscureText,
      maxLength: maxLength,
      textAlign: textAlign,
      enabled: enabled,
      onChanged: onChanged,
      focusNode: focusNode,
      autofocus: autofocus,
      readOnly: readOnly,
      onTap: onTap,
      style: style ??
          const TextStyle(color: AppColors.textPrimary,),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: hintColor ?? AppColors.gray400,),
        filled: true,
        fillColor: _isOutline
            ? AppColors.white
            : enabled
            ? (fillColor ?? AppColors.inputBackground)
            : AppColors.border,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: _isOutline
              ? const BorderSide(
            color: AppColors.border,
            width: 1.5,
          )
              : BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: _isOutline
              ? const BorderSide(
            color: AppColors.border,
            width: 1.5,
          )
              : BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: AppColors.primary,
            width: _isOutline ? 1.5 : 1,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: _isOutline
              ? const BorderSide(
            color: AppColors.border,
            width: 1.5,
          )
              : BorderSide.none,
        ),
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(
              horizontal: 16,
            ),
        counterText: showCounter ? null : '',
        suffix: suffix,
      ),
    );

    textField = SizedBox(
      height: height,
      child: textField,
    );

    if (width != null) {
      textField = SizedBox(
        width: width,
        child: textField,
      );
    }

    if (label != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label!,
          ),
          SizedBox(height: labelSpacing),
          textField,
        ],
      );
    }

    return textField;
  }
}