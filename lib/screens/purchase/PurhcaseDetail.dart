import 'package:flutter/material.dart';
import 'package:home_inventory/model/inventory/inventoryModel.dart';
import 'package:home_inventory/widget/PurchaseRecordItemCard.dart';
import 'package:home_inventory/widget/nestedappbar.dart';

class PurhcaseDetailPage extends StatefulWidget {
  const PurhcaseDetailPage({Key? key}) : super(key: key);

  @override
  State<PurhcaseDetailPage> createState() => _PurhcaseDetailPageState();
}

class _PurhcaseDetailPageState extends State<PurhcaseDetailPage> {
  @override
  Widget build(BuildContext context) {
    var isportait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      appBar: const NestedAppBar(title: "Purchase Record"),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: const SizedBox(
              height: 10,
            ),
          ),
          detail(
              context, "27 August 2022", "Dmart India,kandevali", 8000.0, 2500),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isportait ? 2 : 4, childAspectRatio: 0.65),
            delegate:
                SliverChildBuilderDelegate(childCount: 10, (context, index) {
              return  PurchaseRecordItem();
            }),
          )
        ],
      ),
    );
  }

  SliverToBoxAdapter detail(
      BuildContext context, String date, String shopName, double amt, int qty) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Date :",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 23),
            ),
            Text(
              date,
              style: const TextStyle(fontSize: 26),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Purchase from :",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 23),
            ),
            Text(
              shopName,
              style: const TextStyle(fontSize: 26),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text(
                    "Amount :",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 23),
                  ),
                  Text(
                    "Rs: $amt",
                    style: const TextStyle(fontSize: 26),
                  ),
                ]),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text(
                    "No of item:",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 23),
                  ),
                  Text(
                    "$qty",
                    style: const TextStyle(fontSize: 26),
                  ),
                ]),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Item :",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 23),
            ),
          ],
        ),
      ),
    );
  }
}
