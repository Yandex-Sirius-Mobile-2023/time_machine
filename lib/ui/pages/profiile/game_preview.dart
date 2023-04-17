import 'package:flutter/material.dart';

class GamePreview extends StatelessWidget {
  static const String gamePreviewText = "Your game";

  const GamePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text(
          gamePreviewText,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 32,
          ),
        ),
      ],
    );
  }
}
