import 'dart:math';

import 'package:circular_widgets/circular_widgets.dart';
import 'package:flutter/material.dart';

///Создаёт виджет в виде системы с центральным виджетом и его саттелитами.
///Система занимает всё доступное место.
class PlanetarSystem extends StatelessWidget {
  const PlanetarSystem({
    super.key,
    required this.satellites,
    required this.centralWidget,
    this.innerSpacing = 10,
    this.satellitesSpacing = 20,
  });
  final List<Widget> satellites;
  final Widget centralWidget;
  final double innerSpacing;
  final double satellitesSpacing;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        return CircularWidgets(
          config: CircularWidgetConfigCreator.bySpacings(
            satellitesCount: satellites.length,
            systemRadius: min(constraints.maxWidth, constraints.maxHeight) / 2,
            innerSpacing: innerSpacing,
            satellitesSpacing: satellitesSpacing,
          ),
          centerWidgetBuilder: (_) => ClipOval(child: centralWidget),
          itemBuilder: (_, i) => ClipOval(child: satellites[i]),
          itemsLength: satellites.length,
        );
      },
    );
  }
}

extension CircularWidgetConfigCreator on CircularWidgetConfig {
  /// Создаёт конфиг посредством промежутков между элементами
  static CircularWidgetConfig bySpacings({
    /// количество cателлитов
    required int satellitesCount,

    /// Пробел между центральным виджетом и сателлитом
    required double innerSpacing,

    /// Пробел между сателлитами
    required double satellitesSpacing,

    /// Радиус системы
    required double systemRadius,
  }) {
    const degrees2Radians = pi / 180.0;
    double radians(double degrees) => degrees * degrees2Radians;
    final angleBetweenSatellites = 360 / satellitesCount;

    // здесь приведено решение следующей системы уравнений:
    // systemRadius = 2*itemRadius + innerSpacing + centralWidgetRadius
    // distanceBetweenItemCenters = 2*itemRadius + satellitespacing
    // distanceBetweenItemCenters = 2*sin(angleBetweensatellites/2)*(systemRadius - itemRadius)
    final s = sin(radians(angleBetweenSatellites / 2));
    final itemRadius =
        (2 * s * systemRadius - satellitesSpacing) / (2 * (1 + s));
    final centerWidgetRadius = systemRadius - 2 * itemRadius - innerSpacing;

    return CircularWidgetConfig(
      innerSpacing: innerSpacing,
      itemRadius: itemRadius,
      centerWidgetRadius: centerWidgetRadius,
    );
  }
}
