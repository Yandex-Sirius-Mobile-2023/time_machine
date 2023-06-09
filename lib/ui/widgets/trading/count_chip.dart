import 'package:flutter/material.dart';
import 'package:time_machine/uikit/themes/ui_colors.dart';
import 'package:time_machine/uikit/ui_consts.dart';

/// Chip with number display.
class CountChip extends StatelessWidget {
  final int count;
  final double minWidth, maxWidth;
  const CountChip({
    Key? key,
    required this.count,
    required this.minWidth,
    required this.maxWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: UIConsts.paddings / 3, horizontal: UIConsts.paddings / 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(UIConsts.doublePaddings),
        color: UIColors.cyanBright,
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(3, 3),
            blurRadius: 4,
          ),
        ],
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth, minWidth: minWidth),
          child: Text(
            count.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
