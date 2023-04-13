import 'package:flutter/material.dart';

Future<T?> showUIBottomSheet<T>(BuildContext context, Widget content) {
  return showModalBottomSheet<T>(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(32),
    ),
    builder: (_) => UIBottomSheetFrame(
      child: content,
    ),
  );
}

class UIBottomSheetFrame extends StatelessWidget {
  final Widget child;

  const UIBottomSheetFrame({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHandler(),
        child,
      ],
    );
  }

  Widget _buildHandler() {
    return SizedBox(
      height: 32,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(4),
          ),
          height: 8,
          width: 80,
        ),
      ),
    );
  }
}
