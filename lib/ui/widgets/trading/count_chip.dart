import 'package:flutter/material.dart';
import 'package:time_machine/uikit/ui_colors.dart';

class CountChip extends StatelessWidget {
  final double width, height;
  final int count;
  const CountChip({
    Key? key,
    required this.width,
    required this.height,
    required this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: UIColors.cyanBright,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(4, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: Center(
        child: Text(
          count.toString(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
