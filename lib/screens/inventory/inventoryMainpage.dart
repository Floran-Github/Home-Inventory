import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../widget/PurchaseRecordCard.dart';
import '../../widget/PurchaseRecordItemCard.dart';
import '../../widget/appbar.dart';
import '../../widget/nestedappbar.dart';

class InventoryMainPage extends StatefulWidget {
  const InventoryMainPage({super.key});

  @override
  State<InventoryMainPage> createState() => _InventoryMainPageState();
}

class _InventoryMainPageState extends State<InventoryMainPage> {
  @override
  Widget build(BuildContext context) {
    var isportait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
        appBar: NestedAppBar(
          title: "Inventory",
        ),
        body: CustomScrollView(slivers: [
          SliverToBoxAdapter(
            child: const SizedBox(
              height: 10,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.blue[700],
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Name: ",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 23),
                      ),
                      Text(
                        "Inventory_1",
                        style: const TextStyle(fontSize: 26),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Owner: ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 23),
                                ),
                                Text(
                                  "Saad Mulla",
                                  style: const TextStyle(fontSize: 26),
                                ),
                              ]),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Shared with :",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 23),
                                ),
                                Text(
                                  "10 others",
                                  style: const TextStyle(fontSize: 26),
                                ),
                              ]),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          detail(context),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isportait ? 2 : 4, childAspectRatio: 0.7),
            delegate:
                SliverChildBuilderDelegate(childCount: 10, (context, index) {
              return const PurchaseRecordItem();
            }),
          )
        ]));
  }

  SliverToBoxAdapter detail(
    BuildContext context,
  ) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Items:",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 23),
            ),
          ],
        ),
      ),
    );
  }
}
