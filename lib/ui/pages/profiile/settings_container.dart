import 'package:flutter/material.dart';
import 'package:time_machine/uikit/ui_colors.dart';

class SettingsContainer extends StatelessWidget {
  const SettingsContainer({super.key});

  static final settingButton = OutlinedButton(
    onPressed: () {},
    child: const Text("Настройки"),
  );

  static final startGameButton = FilledButton(
    onPressed: () {},
    style: FilledButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    ),
    child: const Text("Начать игру"),
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Row(
          children: [
            Expanded(child: startGameButton),
            const SizedBox(width: 16),
            Expanded(child: settingButton),
          ],
        ),
      ),
    );
  }
}
