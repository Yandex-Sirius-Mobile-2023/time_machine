import 'package:flutter/material.dart';
import 'package:time_machine/uikit/ui_consts.dart';

class UIText extends StatelessWidget {
  final String text;

  const UIText(
    this.text, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(UIConsts.paddings / 2),
      child: Text(text),
    );
  }
}
