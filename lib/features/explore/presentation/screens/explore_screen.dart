import 'package:flutter/material.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Padding(
          padding: EdgeInsets.all(16),
          child: Text("탐색", style: TextStyle(fontSize: 24)),
        ),
        Expanded(child: Center(child: Text("탐색 contents"))),
      ],
    );
  }
}
