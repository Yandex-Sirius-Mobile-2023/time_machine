import 'package:flutter/material.dart';
import 'package:time_machine/app.dart';
import 'package:time_machine/uikit/themes/ui_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          children: [
            Expanded(
              child: _StartGameButton(
                rounded: rounded,
                textPadding: textPadding,
                onPressed: () => Navigator.of(context)
                    .pushReplacementNamed(AppRoutes.chooseStockURL),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            const Expanded(
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
  final Function() onPressed;
  const _StartGameButton({
    required this.rounded,
    required this.textPadding,
    required this.onPressed,
  });

  final double rounded;
  final double textPadding;

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
          AppLocalizations.of(context)!.startGame,
          style: const TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _SettingsButton extends StatelessWidget {
  final double rounded;
  const _SettingsButton({
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
        child: Text(
          AppLocalizations.of(context)!.setSettings,
          style: const TextStyle(color: UIColors.cyanBright),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
