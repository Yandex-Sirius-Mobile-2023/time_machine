import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GraphCostWidget extends StatelessWidget {
  const GraphCostWidget({
    super.key,
    required this.data,
  });

  final List<List> data;

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
                // tooltipPadding: EdgeInsets.all(15 / 2),
                tooltipMargin: 15,
                fitInsideHorizontally: true,
                fitInsideVertically: true,
                tooltipBgColor: backgroundPrice.withOpacity(0.3),
                getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                  return touchedBarSpots.map((barSpot) {
                    return LineTooltipItem(
                      '${barSpot.y.toInt()}',
                      const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 10,
                        color: Colors.white,
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
          // minX: 0,
          // // maxX: _data[widget.timeType].length.toDouble() -
          // //     1, //length of data set
          // // minY: _data[widget.timeType].reduce(min).toDouble() -
          // //     1, //set to lowest v
          // // maxY: _data[widget.timeType].reduce(max).toDouble() +
          // //     1, //set to highest v
          lineBarsData: [
            LineChartBarData(
              color: const Color.fromRGBO(20, 20, 20, 0.2),
              spots:
                  data.map((List e) => FlSpot(e[0], e[1].toDouble())).toList(),
              //FlSpot(2.6, 4),
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
                    Color.fromRGBO(0, 190, 180, 0.3),
                    Color.fromRGBO(0, 190, 180, 0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
