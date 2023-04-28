import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartWidget extends StatelessWidget {
  final List<int> dayList;
  final List<int> datapoint;
  const LineChartWidget({
    Key? key,
    required this.dayList,
    required this.datapoint,
  }) : super(key: key);

  LineTouchData get lineTouchData => LineTouchData(
      handleBuiltInTouches: true,
      touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8)));

  @override
  Widget build(BuildContext context) {
    int maxX = dayList.last;
    int maxY = 4;

    return LineChart(
      LineChartData(
          minX: 0,
          minY: 0,
          maxX: maxX.toDouble(),
          maxY: maxY.toDouble(),
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
              rightTitles:
                  AxisTitles(sideTitles: SideTitles(showTitles: false)),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) => Text('$value'),
              ))),
          borderData: FlBorderData(
              show: true,
              border: const Border(
                bottom: BorderSide(color: Colors.transparent),
                left: BorderSide(color: Colors.transparent),
                right: BorderSide(color: Colors.transparent),
                top: BorderSide(color: Colors.transparent),
              )),
          lineTouchData: lineTouchData,
          lineBarsData: [
            LineChartBarData(
                isCurved: false,
                isStrokeCapRound: true,
                curveSmoothness: 0.2,
                dotData: FlDotData(show: false),
                belowBarData: BarAreaData(show: false),
                spots: List.generate(datapoint.length, (i) {
                  return FlSpot(i.toDouble(), datapoint[i].toDouble());
                })),
          ]),
      swapAnimationDuration: const Duration(milliseconds: 250),
    );
  }
}
