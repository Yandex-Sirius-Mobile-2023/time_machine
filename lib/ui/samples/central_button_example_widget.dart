import 'package:flutter/material.dart';
import 'package:time_machine/ui/widgets/central_button/blur_central_button_widget.dart';
import 'package:time_machine/ui/widgets/central_button/central_button_widget.dart';

class CentralButtonExampleWidget extends StatefulWidget {
  const CentralButtonExampleWidget({super.key});

  @override
  State<CentralButtonExampleWidget> createState() =>
      _CentralButtonExampleWidgetState();
}

class _CentralButtonExampleWidgetState
    extends State<CentralButtonExampleWidget> {
  bool isBlur = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlurCentralButtonWidget(isBlur: isBlur),
            ElevatedButton(
                onPressed: () => setState(() => isBlur = !isBlur),
                child: Text(
                  "Press me",
                  style: Theme.of(context).textTheme.labelLarge,
                ))
          ],
        ),
      ),
    );
  }
}
