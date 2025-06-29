import 'package:flutter/material.dart';

class MatchingScreen extends StatelessWidget {
  const MatchingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Padding(
          padding: EdgeInsets.all(16),
          child: Text("매칭", style: TextStyle(fontSize: 24)),
        ),
        Expanded(child: Center(child: Text("매칭 contents"))),
      ],
    );
  }
}
