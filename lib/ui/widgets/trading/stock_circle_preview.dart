import 'package:flutter/material.dart';
import 'count_chip.dart';

class StockCirclePreview extends StatelessWidget {
  /// A number that represents the stocks quantity.
  final int count;
  final Widget child;
  final double minWidth, maxWidth;
  final Function() onPressed;
  const StockCirclePreview({
    Key? key,
    required this.count,
    required this.child,
    required this.onPressed,
    this.minWidth = 28,
    this.maxWidth = 48,
  })  : assert(count >= 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        child,
        Positioned(
          right: 0,
          top: 0,
          child: CountChip(
            count: count,
            minWidth: minWidth,
            maxWidth: maxWidth,
          ),
        ),
        ClipOval(
          child: InkWell(
            onTap: onPressed,
          ),
        ),
      ],
    );
  }
}
