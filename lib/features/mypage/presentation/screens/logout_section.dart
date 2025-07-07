import 'package:flutter/material.dart';
import 'package:keodam/core/theme/colors.dart';
import 'package:keodam/features/mypage/presentation/widgets/logout_button.dart';

class LogoutSection extends StatelessWidget {
  const LogoutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor01,
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Column(
        children: [LogoutButton(onPressed: () {}), SizedBox(height: 16)],
      ),
    );
  }
}
