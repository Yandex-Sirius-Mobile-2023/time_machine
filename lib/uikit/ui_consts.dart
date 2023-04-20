import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

abstract class UIConsts {
  static const paddings = 16.0;
  static const doublePaddings = 2 * paddings;

  static const Duration duration = Duration(milliseconds: 100);

  static List<String> periods(BuildContext context) => [
        AppLocalizations.of(context)!.day,
        AppLocalizations.of(context)!.week,
        AppLocalizations.of(context)!.month,
        AppLocalizations.of(context)!.quarter,
        AppLocalizations.of(context)!.halfYear,
        AppLocalizations.of(context)!.year,
      ];
}
