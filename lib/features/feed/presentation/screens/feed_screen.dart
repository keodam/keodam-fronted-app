import 'package:flutter/material.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Padding(
          padding: EdgeInsets.all(16),
          child: Text("피드", style: TextStyle(fontSize: 24)),
        ),
        Expanded(child: Center(child: Text("피드 contents"))),
      ],
    );
  }
}
