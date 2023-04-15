// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GraphCostWidget extends StatelessWidget {
  const GraphCostWidget({
    Key? key,
    required this.data,
    required this.isSingleWidget,
  }) : super(key: key);

  final List<List<double>> data;
  final bool isSingleWidget;

  @override
  Widget build(BuildContext context) {
    const double defaultPadding = 15;

    const Color backgroundPrice = Color.fromRGBO(215, 245, 245, 1);

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
                tooltipBgColor: backgroundPrice.withOpacity(1),
                getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                  return touchedBarSpots.map((barSpot) {
                    return LineTooltipItem(
                      '${barSpot.y.toInt()}',
                      const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 10,
                        color: Colors.black,
                      ),
                    );
                  }).toList();
                }),
            getTouchedSpotIndicator:
                (LineChartBarData barData, List<int> spotIndexes) =>
                    spotIndexes.map((spotIndex) {
              return TouchedSpotIndicatorData(
                FlLine(
                  color: const Color.fromRGBO(20, 20, 20, 0.2),
                  strokeWidth: 1,
                  dashArray: [3, 6],
                ),
                FlDotData(
                  getDotPainter: (spot, percent, barData, index) {
                    return FlDotCirclePainter(
                      radius: 1,
                      color: Colors.white54,
                      strokeWidth: 2,
                      strokeColor: const Color.fromRGBO(20, 20, 20, 0.2),
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
              color: isSingleWidget
                  ? const Color.fromRGBO(0, 190, 180, 1)
                  : const Color.fromRGBO(20, 20, 20, 0.2),
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
                gradient: const LinearGradient(
                  colors: [
                    Color.fromRGBO(0, 190, 180, 0.5),
                    Color.fromRGBO(0, 190, 180, 0),
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
