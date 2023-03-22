import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:home_inventory/constant/colors.dart';
import 'package:home_inventory/widget/line_chart.dart';
import 'package:home_inventory/widget/nestedappbar.dart';

class ItemDetailScreen extends StatefulWidget {
  const ItemDetailScreen({super.key});

  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NestedAppBar(title: "Item detail"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title("Product Name"),
            spacer10(),
            dataText("Basamati Rice"),
            spacer10(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                columnLabelData("Product Quantity", "12"),
                columnLabelData("Net Quantity", "120 Kg"),
              ],
            ),
            spacer10(),
            title("Price"),
            spacer10(),
            dataText("12,000 Rs"),
            spacer10(),
            title("Price Graph"),
            spacer10(),
            Container(
              height: 400,
              // color: Colors.white,
              padding: const EdgeInsets.all(8.0),
              child: const LineChartWidget(dayList: [
                1,
                2,
                3,
                4,
                5,
                6,
                7,
                8,
                9,
                10,
                11,
                12,
                13,
                14,
                15,
                16,
                17,
                18,
                19,
                20,
                21,
                22,
                23,
                24,
                25,
                26,
                27,
                28,
                29,
                30
              ], datapoint: [
                1,
                2,
                3,
                4,
                0,
                1,
                2,
                3,
                4,
                0,
                1,
                2,
                3,
                4,
                0,
                1,
                2,
                3,
                4,
                0,
                1,
                2,
                3,
                4,
                0,
                1,
                2,
                3,
                4,
                0
              ]),
            )
          ],
        ),
      ),
    );
  }

  Column columnLabelData(String label, String data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title(label),
        spacer5(),
        dataText(data),
      ],
    );
  }

  SizedBox spacer10() => const SizedBox(height: 10);
  SizedBox spacer5() => const SizedBox(height: 5);

  Text dataText(String text) {
    return Text(
      text,
      style: TextStyle(
          color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700),
    );
  }

  Text title(String text) {
    return Text(
      text,
      style: const TextStyle(
          color: AppColors.yellow, fontWeight: FontWeight.w500, fontSize: 18),
    );
  }
}
