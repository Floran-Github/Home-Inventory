import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:home_inventory/widget/nestedappbar.dart';

import '../../constant/colors.dart';
import '../../constant/routes.dart';
import '../../widget/PurchaseRecordCard.dart';
import '../../widget/appbar.dart';

class InventoryPurchasePage extends StatefulWidget {
  const InventoryPurchasePage({super.key});

  @override
  State<InventoryPurchasePage> createState() => _InventoryPurchasePageState();
}

class _InventoryPurchasePageState extends State<InventoryPurchasePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NestedAppBar(
        title: "Home Inventory",
      ),
      floatingActionButton: FloatingActionButton(
          heroTag: "inventorycreate",
          shape: const CircleBorder(),
          backgroundColor: AppColors.white,
          onPressed: () =>
              Navigator.pushNamed(context, Routes.purchaseCreateRoute),
          child: const Icon(
            Icons.add,
            color: AppColors.mediumgreen,
            size: 50,
          )),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: const Text(
                "Ghatkopar Inventory Purchase Record",
                style: TextStyle(fontSize: 23, color: Colors.amber),
              ),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index) => PurchaseRecordCard(
                inventory: "Inventory ${index + 1}",
                date: "1$index Septemeber 2022",
                amount: index + 1 * 105.90,
                qty: index + 34,
              ),
            )
          ],
        ),
      )),
    );
  }
}
