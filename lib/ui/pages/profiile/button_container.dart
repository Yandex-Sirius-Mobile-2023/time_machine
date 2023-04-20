// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:time_machine/app.dart';
import 'package:time_machine/uikit/themes/ui_colors.dart';

class ButtonsContainer extends StatelessWidget {
  final Function() onSwitchPressed;
  final String rightButtonText;
  final String leftButtonText;
  const ButtonsContainer({
    Key? key,
    required this.onSwitchPressed,
    required this.rightButtonText,
    required this.leftButtonText,
  }) : super(key: key);

  static const double textPadding = 8;
  static const double rounded = 8;

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Card(
      color: colorScheme.background,
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(rounded),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Row(
          children: [
            Expanded(
              child: _StartGameButton(
                rounded: rounded,
                textPadding: textPadding,
                onPressed: () => Navigator.of(context)
                    .pushReplacementNamed(AppRoutes.chooseStockURL),
                text: leftButtonText,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: _SettingsButton(
                text: rightButtonText,
                textPadding: textPadding,
                rounded: rounded,
                onPressed: onSwitchPressed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StartGameButton extends StatelessWidget {
  final Function() onPressed;
  const _StartGameButton({
    Key? key,
    required this.onPressed,
    required this.rounded,
    required this.textPadding,
    required this.text,
  }) : super(key: key);

  final double rounded;
  final double textPadding;
  final String text;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(rounded),
        ),
        backgroundColor: UIColors.cyanBright,
      ),
      child: Padding(
        padding: EdgeInsets.all(textPadding),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _SettingsButton extends StatelessWidget {
  final double rounded;
  final Function() onPressed;
  final String text;

  const _SettingsButton({
    required this.textPadding,
    required this.rounded,
    required this.onPressed,
    required this.text,
  });

  final double textPadding;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: const BorderSide(
          width: 2.0,
          color: UIColors.cyanBright,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(rounded),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(textPadding),
        child: Text(
          text,
          style: const TextStyle(color: UIColors.cyanBright),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
