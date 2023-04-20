// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:time_machine/core/model/portfolio_state.dart';

import 'package:time_machine/ui/widgets/planetar_system.dart';
import 'package:time_machine/uikit/ui_consts.dart';
// / / import 'package:time_machine/uikit/ui_colors.dart';
// import 'package:time_machine/uikit/ui_consts.dart';

import 'central_item_button_widget.dart';

class CentralButtonWidget extends StatelessWidget {
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final Function(double) getRadius;
  final List<Widget> satellites;
  final Function(Period period) onSuccess;
  final int initIndex;

  const CentralButtonWidget({
    Key? key,
    required this.onTap,
    required this.onLongPress,
    required this.getRadius,
    required this.satellites,
    required this.onSuccess,
    required this.initIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String text = UIConsts.periods(context)[initIndex];

    return PlanetarSystem(
        innerSpacing: 20,
        satellitesSpacing: 30,
        calculatedConfigGetter: (config) {
          getRadius(config.centerWidgetRadius);
        },
        satellites: satellites,
        centralWidget: CentralItemButtonWidget(
          text: text,
          onTap: onTap,
          onLongPress: onLongPress,
          isBlur: false,
          onSuccess: onSuccess,
          initIndex: initIndex,
        ));
  }
}
