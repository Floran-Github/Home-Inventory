import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:home_inventory/constant/colors.dart';
import 'package:home_inventory/widget/appbar.dart';
import 'package:home_inventory/widget/line_chart.dart';
import 'package:home_inventory/widget/nestedappbar.dart';
import 'package:home_inventory/widget/pie_chart.dart';

const List<String> list = <String>['Daily', 'Weekly', 'Monthly', 'Yearly'];

class InventoryDashboard extends StatefulWidget {
  const InventoryDashboard({super.key});

  @override
  State<InventoryDashboard> createState() => _InventoryDashboardState();
}

class _InventoryDashboardState extends State<InventoryDashboard> {
  String dropdownValue = list.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NestedAppBar(title: "Inventory"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Dashboard",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Purchase Stats",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.symmetric(vertical: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColors.sharedInv,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Most visited store",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Reliance Store",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.greenShade,
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.all(10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Total Purchase amount",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            SizedBox(height: 30),
                            Text(
                              "Rs 12,000",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ]),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.greenShade,
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.all(10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Total Item Purchased",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            SizedBox(height: 30),
                            Text(
                              "200",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ]),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 13,
              ),
              Row(
                children: [
                  const Expanded(
                      child: Text(
                    "Graphical Representation",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  )),
                  Container(
                    decoration: BoxDecoration(
                        color: AppColors.yellow,
                        borderRadius: BorderRadius.circular(6)),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                    child: DropdownButton<String>(
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      style: const TextStyle(color: Colors.black),
                      underline: Container(
                        height: 0,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          dropdownValue = value!;
                        });
                      },
                      items: list.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
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
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Nutrition Stats",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 10,
              ),
              const PieChartWidget(),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Top food items",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              foodCard(),
              foodCard(),
              foodCard(),
            ],
          ),
        ),
      ),
    );
  }

  Container foodCard() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Image.asset(
            "assets/images/food.png",
            width: 100,
          ),
          const SizedBox(
            width: 30,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Burger",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "No of times consumed: 6",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
