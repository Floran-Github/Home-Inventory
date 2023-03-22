import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class PieChartWidget extends StatefulWidget {
  const PieChartWidget({super.key});

  @override
  State<PieChartWidget> createState() => _PieChartWidgetState();
}

class _PieChartWidgetState extends State<PieChartWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 400,
          padding: const EdgeInsets.all(8.0),
          child: PieChart(PieChartData(
              sectionsSpace: 0,
              borderData: FlBorderData(
                show: false,
              ),
              centerSpaceRadius: 160,
              sections: [
                PieChartSectionData(
                    color: Colors.amber,
                    value: 50,
                    title: "50%",
                    radius: 15,
                    showTitle: false),
                PieChartSectionData(
                    color: Colors.green,
                    value: 20,
                    title: "20%",
                    radius: 15,
                    showTitle: false),
                PieChartSectionData(
                    color: Colors.redAccent,
                    value: 20,
                    title: "20%",
                    radius: 15,
                    showTitle: false),
                PieChartSectionData(
                    color: Colors.blueAccent,
                    value: 10,
                    title: "40%",
                    radius: 15,
                    showTitle: false),
              ])),
        ),
        PiechartIndicator(Colors.amber, "Protein"),
        PiechartIndicator(Colors.green, "Fat"),
        PiechartIndicator(Colors.redAccent, "Vitamin"),
        PiechartIndicator(Colors.blueAccent, "Iron"),
      ],
    );
  }

  Container PiechartIndicator(Color color, String text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: color,
            ),
          ),
          SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}
