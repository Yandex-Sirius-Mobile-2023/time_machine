import 'package:flutter/material.dart';
import 'package:time_machine/ui/pages/auth/commons/bottom_header_text.dart';

class SignHeaderText extends StatelessWidget {
  final String message;
  final String bottomMessage;
  const SignHeaderText({
    super.key,
    required this.message,
    required this.bottomMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
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
        ),
        SignBottomHeaderText(bottomMessage),
      ],
    );
  }
}
