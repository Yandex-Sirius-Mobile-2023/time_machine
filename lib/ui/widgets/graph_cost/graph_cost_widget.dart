import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:time_machine/uikit/ui_colors.dart';

class GraphCostWidget extends StatelessWidget {
  const GraphCostWidget({
    super.key,
    required this.data,
  });

  final List<List<double>> data;

  @override
  Widget build(BuildContext context) {
    const double defaultPadding = 15;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3 * defaultPadding),
      child: LineChart(
        LineChartData(
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
                tooltipMargin: 15, // отступы для кликабельных точек
                fitInsideHorizontally: true,
                fitInsideVertically:
                    true, // чтобы кликабельные окошки не попадали за виджет
                tooltipBgColor: UIColors.white.withOpacity(0.3),
                getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                  return touchedBarSpots.map((barSpot) {
                    return LineTooltipItem(
                      '${barSpot.y.toInt()}',
                      const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 10,
                        color: UIColors.white,
                      ),
                    );
                  }).toList();
                }),
            getTouchedSpotIndicator:
                (LineChartBarData barData, List<int> spotIndexes) =>
                    spotIndexes.map((spotIndex) {
              return TouchedSpotIndicatorData(
                FlLine(
                  color: UIColors.black.withOpacity(0.2),
                  strokeWidth: 1,
                  dashArray: [3, 6],
                ),
                FlDotData(
                  getDotPainter: (spot, percent, barData, index) {
                    return FlDotCirclePainter(
                      radius: 1,
                      color: UIColors.white.withOpacity(0.54),
                      strokeWidth: 2,
                      strokeColor: UIColors.black.withOpacity(0.2),
                    );
                  },
                ),
              );
            }).toList(),
            // реакция на клики + кастомизация для проекта
          ),
          gridData: FlGridData(
            show: false,
          ),
          titlesData: FlTitlesData(
            show: false,
          ),
          borderData: FlBorderData(
            show: false,
          ),
          // скрыл доп тулы для демонстрации графиков
          // // minX: 0,
          // // maxX: _data[widget.timeType].length.toDouble() -
          // //     1, //length of data set
          // // minY: _data[widget.timeType].reduce(min).toDouble() -
          // //     1, //set to lowest v
          // // maxY: _data[widget.timeType].reduce(max).toDouble() +
          // //     1, //set to highest v
          lineBarsData: [
            LineChartBarData(
              color: UIColors.black.withOpacity(0.2),
              spots:
                  data.map((List e) => FlSpot(e[0], e[1].toDouble())).toList(),
              isCurved: false,
              barWidth: 2,
              isStrokeCapRound: false,
              dotData: FlDotData(
                show: false,
              ),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    UIColors.cyanBright.withOpacity(0.3),
                    UIColors.cyanBright.withOpacity(0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            // демонстрация данных
          ],
        ),
      ),
    );
  }
}
