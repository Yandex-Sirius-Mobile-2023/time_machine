import 'package:flutter/material.dart';
import 'package:time_machine/ui/pages/profiile/profile_page.dart';

import '../commons/options_text_header.dart';

class GamePreviewFragment extends StatelessWidget {
  static const String gamePreviewText = "My games";

  const GamePreviewFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: containerBottomPadding),
      children: [
        const OptionsTextHeader(
          gamePreviewText,
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
