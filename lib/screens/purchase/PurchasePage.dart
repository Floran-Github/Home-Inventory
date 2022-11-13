import 'package:flutter/material.dart';
import 'package:home_inventory/constant/routes.dart';
import 'package:home_inventory/widget/appbar.dart';

import '../../constant/colors.dart';
import '../../widget/PurchaseRecordCard.dart';

class PurchasePage extends StatefulWidget {
  const PurchasePage({Key? key}) : super(key: key);

  @override
  State<PurchasePage> createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage>
    with AutomaticKeepAliveClientMixin<PurchasePage>, TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: const CustomAppBar(),
      // floatingActionButton: FloatingActionButton(
      //     heroTag: "create",
      //     shape: const CircleBorder(),
      //     backgroundColor: AppColors.white,
      //     onPressed: () => Navigator.pushNamed(context, Routes.selectMarket),
      //     child: const Icon(
      //       Icons.add,
      //       color: AppColors.mediumgreen,
      //       size: 50,
      //     )),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: const Text(
                "Purchase Record",
                style: TextStyle(fontSize: 23),
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

  @override
  bool get wantKeepAlive => true;
}
