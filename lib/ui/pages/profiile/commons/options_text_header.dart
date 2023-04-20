import 'package:flutter/material.dart';

class OptionsTextHeader extends StatelessWidget {
  final String text;
  const OptionsTextHeader(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 32,
        ),
        textAlign: TextAlign.start,
      ),
    );
  }
}
