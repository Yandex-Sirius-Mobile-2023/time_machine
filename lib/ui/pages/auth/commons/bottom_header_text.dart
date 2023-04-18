import 'package:flutter/material.dart';
import 'package:time_machine/uikit/themes/text/text_style.dart';

class SignBottomHeaderText extends StatelessWidget {
  final String message;

  const SignBottomHeaderText(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      style: infoStyle.copyWith(fontSize: 16),
    );
  }
}
