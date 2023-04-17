import 'package:flutter/material.dart';
import 'count_chip.dart';

class StockCirclePreview extends StatelessWidget {
  final int count;
  final Widget child;
  const StockCirclePreview({Key? key, required this.count, required this.child})
      : assert(count >= 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ClipOval(child: child),
        Positioned(
          right: 4,
          top: 4,
          child: CountChip(
            width: 58,
            height: 28,
            count: count,
          ),
        ),
      ],
    );
  }
}
