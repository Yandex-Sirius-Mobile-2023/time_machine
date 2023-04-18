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
    this.calculatedConfigGetter,
    this.centerRelativeSize,
    this.minCenterRelativeSize = 0.5,
  });
  final List<Widget> satellites;
  final Widget centralWidget;
  final double innerSpacing;
  final double satellitesSpacing;
  final Function(CircularWidgetConfig)? calculatedConfigGetter;

  /// от 0 до 1
  final double? centerRelativeSize;

  /// от 0 до 1
  final double minCenterRelativeSize;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final minimalDimension =
            min(constraints.maxWidth, constraints.maxHeight);
        final systemRadius = minimalDimension / 2;

        late final CircularWidgetConfig config;

        if (centerRelativeSize != null) {
          final centerWidgetRadius = systemRadius * centerRelativeSize!;
          config = CircularWidgetConfigCreator.fixedCenter(
            centerRadius: centerWidgetRadius,
            innerSpacing: innerSpacing,
            satellitesSpacing: satellitesSpacing,
            systemRadius: systemRadius,
            satellitesCount: satellites.length,
          );
        } else {
          config = CircularWidgetConfigCreator.bySpacings(
            satellitesCount: satellites.length,
            systemRadius: systemRadius,
            innerSpacing: innerSpacing,
            satellitesSpacing: satellitesSpacing,
            minimalCentralRadius: systemRadius * minCenterRelativeSize,
          );
        }
        calculatedConfigGetter?.call(config);
        return CircularWidgets(
          config: config,
          centerWidgetBuilder: (_) => ClipOval(child: centralWidget),
          itemBuilder: (_, i) => ClipOval(child: satellites[i]),
          itemsLength: satellites.length,
        );
      },
    );
  }
}

// глобально система описывается следующей системой уравнений:
// systemRadius = 2*itemRadius + innerSpacing + centralWidgetRadius
// distanceBetweenItemCenters = 2*itemRadius + satellitespacing
// distanceBetweenItemCenters = 2*sin(angleBetweensatellites/2)*(systemRadius - itemRadius)
abstract class CircularWidgetConfigCreator {
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

    /// Миинимальный радиус центрального виджета
    double? minimalCentralRadius,
  }) {
    final angleBetweenSatellites = 360 / satellitesCount;
    final s = sin(_radians(angleBetweenSatellites / 2));
    final itemRadius =
        (2 * s * systemRadius - satellitesSpacing) / (2 * (1 + s));
    final centerWidgetRadius = systemRadius - 2 * itemRadius - innerSpacing;

    if (minimalCentralRadius != null &&
        minimalCentralRadius > centerWidgetRadius) {
      return CircularWidgetConfig(
        innerSpacing: innerSpacing,
        itemRadius: (systemRadius - innerSpacing - minimalCentralRadius) / 2,
        centerWidgetRadius: minimalCentralRadius,
      );
    } else {
      return CircularWidgetConfig(
        innerSpacing: innerSpacing,
        itemRadius: itemRadius,
        centerWidgetRadius: centerWidgetRadius,
      );
    }
  }

  static CircularWidgetConfig fixedCenter({
    required double centerRadius,
    required double innerSpacing,
    required double satellitesSpacing,
    required double systemRadius,
    required int satellitesCount,
  }) {
    final angleBetweenSatellites = 360 / satellitesCount;
    final s = sin(_radians(angleBetweenSatellites / 2));

    return CircularWidgetConfig(
      innerSpacing: innerSpacing,
      itemRadius: (2 * s * systemRadius - satellitesSpacing) / (2 * (1 + s)),
      centerWidgetRadius: centerRadius,
    );
  }

  static double _radians(double degrees) {
    const degrees2Radians = pi / 180.0;
    return degrees * degrees2Radians;
  }
}
