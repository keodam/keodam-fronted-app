import 'package:flutter/material.dart';
import 'package:keodam/core/theme/text_styles.dart';

class AgreementTitleSection extends StatelessWidget {
  final String text;
  final String titie;
  final bool checked;
  final Function(bool) onChanged;
  final VoidCallback onTextTap;
  const AgreementTitleSection({
    super.key,
    required this.text,
    required this.titie,
    required this.checked,
    required this.onChanged,
    required this.onTextTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            onChanged(!checked);
          },
          child:
              checked
                  ? Image.asset('assets/images/check.png', width: 13, height: 13)
                  : Container(
                    width: 13,
                    height: 13,
                    decoration: BoxDecoration(color: const Color(0xFFD9D9D9), borderRadius: BorderRadius.circular(3)),
                  ),
        ),
        const SizedBox(width: 11),
        Expanded(
          child: GestureDetector(
            onTap: onTextTap,
            child: Text(text, style: AppTextStyle.regular14.copyWith(color: Colors.black)),
          ),
        ),
      ],
    );
  }
}
