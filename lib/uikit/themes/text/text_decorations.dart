import 'package:flutter/material.dart';
import 'package:time_machine/uikit/themes/ui_colors.dart';

InputDecoration inputFormDecoration(BuildContext context) => InputDecoration(
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(10.0),
      ),
      hintStyle: const TextStyle(
        color: UIColors.grey,
        fontWeight: FontWeight.normal,
      ),
      isDense: true,
      filled: true,
      fillColor: Theme.of(context).colorScheme.secondary,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
    );
