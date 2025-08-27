import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:keodam/core/theme/text_styles.dart';

class TermsBottomButton extends StatelessWidget {
  const TermsBottomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 34),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: GestureDetector(
          onTap: () {
            context.pop();
          },
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.blue),
            child: Center(child: Text('닫기', style: AppTextStyle.bold22.copyWith(color: Colors.white))),
          ),
        ),
      ),
    );
  }
}
