import 'package:flutter/material.dart';

Future<T?> showUIBottomSheet<T>({
  required BuildContext context,
  required Widget content,
}) {
  return showModalBottomSheet<T>(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
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
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHandler(),
          Flexible(child: child),
        ],
      ),
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
