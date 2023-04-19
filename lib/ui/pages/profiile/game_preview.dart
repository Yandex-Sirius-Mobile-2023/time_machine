import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GamePreview extends StatelessWidget {
  const GamePreview({super.key});

  @override
  Widget build(BuildContext context) {
    String gamePreviewText = AppLocalizations.of(context)!.myGames;
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            gamePreviewText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
              fontSize: 32,
            ),
            textAlign: TextAlign.start,
          ),
        ),
        ...List.generate(
          6,
          (index) => const Card(
            margin: EdgeInsets.all(8),
            child: SizedBox(height: 256),
          ),
        ),
      ],
    );
  }
}
