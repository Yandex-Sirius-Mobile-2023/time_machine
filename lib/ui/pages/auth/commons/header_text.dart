import 'package:flutter/material.dart';

class SignHeaderText extends StatelessWidget {
  final String message;
  const SignHeaderText(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text(
        message,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.5,
        ),
        textAlign: TextAlign.justify,
      ),
    );
  }
}
