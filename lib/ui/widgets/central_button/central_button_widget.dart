// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:time_machine/ui/widgets/planetar_system.dart';
// import 'package:time_machine/uikit/ui_colors.dart';
// import 'package:time_machine/uikit/ui_consts.dart';

import 'central_item_button_widget.dart';

class CentralButtonWidget extends StatelessWidget {
  final VoidCallback onTap;
  final Function(double) getRadius;

  const CentralButtonWidget({
    Key? key,
    required this.onTap,
    required this.getRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String text = "7 дн";

    return PlanetarSystem(
        innerSpacing: 20,
        satellitesSpacing: 30,
        calculatedConfigGetter: (config) {
          getRadius(config.centerWidgetRadius);
        },
        satellites: [
          Image.asset("assets/images/ali.png"),
          Image.asset("assets/images/microsoft.png"),
          Image.asset("assets/images/amazon.png"),
          Image.asset("assets/images/apple.png"),
          Image.asset("assets/images/mac.png"),
          Image.asset("assets/images/tesla.png"),
          Image.asset("assets/images/toyota.png"),
          Image.asset("assets/images/yandex.png"),
        ],
        centralWidget: CentralItemButtonWidget(
          text: text,
          onTap: onTap,
          isBlur: false,
        ));
  }
}
