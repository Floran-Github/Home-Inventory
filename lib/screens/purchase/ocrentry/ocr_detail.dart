import 'package:flutter/material.dart';
import 'package:home_inventory/constant/routes.dart';
import 'package:home_inventory/model/transaction/ocrCreate.dart';
import 'package:home_inventory/widget/nestedappbar.dart';

import '../../../constant/colors.dart';
import '../../../preference/preferences.dart';

class OCRDetailScreen extends StatefulWidget {
  const OCRDetailScreen({super.key});

  @override
  State<OCRDetailScreen> createState() => _OCRDetailScreenState();
}

class _OCRDetailScreenState extends State<OCRDetailScreen> {
  OCRCreate? ocrData;
  int? invId;
  Preference prefs = Preference();

  @override
  void initState() {
    getCredits();
    super.initState();
  }

  Future<void> getCredits() async {
    invId = await prefs.getInvid();
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    setState(() {
      ocrData = arguments['ocrData'];
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NestedAppBar(title: "Scanned Detail"),
      bottomNavigationBar: bottomContainer(ocrData!.totalPrice),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamedAndRemoveUntil(
            context, Routes.purhcaseDetailRoute, (route) => false,
            arguments: {'invData': prefs.getInvid()}),
        shape: CircleBorder(),
        backgroundColor: AppColors.greenShade,
        child: Icon(
          Icons.arrow_right_alt_rounded,
          color: AppColors.white,
          size: 24,
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Items",
              style: TextStyle(fontSize: 21),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: ocrData!.recordItems.length,
              itemBuilder: (context, index) {
                return listItem(ocrData!.recordItems[index]);
              },
            )
          ],
        ),
      )),
    );
  }

  Container bottomContainer(int totalAmount) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.greenShade, borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      child: Text(
        "Total Amount : $totalAmount",
        style: TextStyle(color: AppColors.white, fontSize: 22),
      ),
    );
  }

  Container listItem(RecordItem data) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
      decoration: BoxDecoration(
          color: AppColors.yellow, borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                data.prdName,
                style: const TextStyle(
                    color: AppColors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w900),
              ),
              Row(
                children: [
                  MaterialButton(
                      minWidth: 0,
                      color: Colors.blueAccent,
                      onPressed: () {},
                      shape: const CircleBorder(),
                      elevation: 0,
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                      )),
                  MaterialButton(
                      minWidth: 0,
                      color: Colors.redAccent,
                      onPressed: () {},
                      shape: const CircleBorder(),
                      elevation: 0,
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      )),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              containerText("Qty", data.prdQty.toString()),
              containerText("Amount", data.totalPrice.toString()),
              containerText(
                  "Units", data.product_weight_per_quantity.toString()),
            ],
          )
        ],
      ),
    );
  }

  Flexible containerText(String label, String data) => Flexible(
        child: Text(
          "$label: $data",
          style: const TextStyle(
              color: AppColors.black,
              fontSize: 18,
              fontWeight: FontWeight.w700),
        ),
      );
}
