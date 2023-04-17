import 'package:flutter/material.dart';
import 'package:time_machine/uikit/ui_colors.dart';

class SettingsContainer extends StatelessWidget {
  const SettingsContainer({super.key});

  static const double textPadding = 8;
  static const double rounded = 8;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(rounded),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Row(
          children: const [
            Expanded(
              child: _StartGameButton(
                rounded: rounded,
                textPadding: textPadding,
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: _SettingsButton(
                textPadding: textPadding,
                rounded: rounded,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StartGameButton extends StatelessWidget {
  const _StartGameButton({
    super.key,
    required this.rounded,
    required this.textPadding,
  });

  final double rounded;
  final double textPadding;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () {},
      style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(rounded),
        ),
        backgroundColor: UIColors.cyanBright,
      ),
      child: Padding(
        padding: EdgeInsets.all(textPadding),
        child: const Text(
          "Начать\nигру",
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _SettingsButton extends StatelessWidget {
  final double rounded;
  const _SettingsButton({
    super.key,
    required this.textPadding,
    required this.rounded,
  });

  final double textPadding;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
          side: const BorderSide(
            width: 2.0,
            color: UIColors.cyanBright,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(rounded),
          )),
      child: Padding(
        padding: EdgeInsets.all(textPadding),
        child: const Text(
          "Изменить\nНастройки",
          style: TextStyle(color: UIColors.cyanBright),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
