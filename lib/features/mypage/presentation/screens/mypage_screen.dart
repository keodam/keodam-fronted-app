import 'package:flutter/material.dart';

class MypageScreen extends StatelessWidget {
  const MypageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Padding(
          padding: EdgeInsets.all(16),
          child: Text("마이페이지", style: TextStyle(fontSize: 24)),
        ),
        Expanded(child: Center(child: Text("마이페이지 contents"))),
      ],
    );
  }
}
