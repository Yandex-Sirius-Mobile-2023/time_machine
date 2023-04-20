import 'package:flutter/material.dart';
import 'package:time_machine/ui/pages/profiile/profile_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../commons/options_text_header.dart';

class GamePreviewFragment extends StatelessWidget {
  const GamePreviewFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: containerBottomPadding),
      children: [
        OptionsTextHeader(
          AppLocalizations.of(context)!.myGames,
        ),
        ...List.generate(
          6,
          (index) => const Card(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: SizedBox(height: 256),
          ),
        ),
      ],
    );
  }
}
