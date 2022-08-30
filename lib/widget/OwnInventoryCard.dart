import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:home_inventory/constant/colors.dart';

class OwnInventoryCard extends StatelessWidget {
  const OwnInventoryCard({Key? key, this.inventoryName}) : super(key: key);
  final String? inventoryName;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.myInv,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: AppColors.myInv),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 1, color: AppColors.white)),
              ),
              child: const Text(
                "My Inventory",
                style: TextStyle(color: AppColors.white),
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Text(
                "$inventoryName",
                style: TextStyle(fontSize: 24, color: AppColors.white),
                textAlign: TextAlign.center,
              )),
            ))
          ],
        ),
      ),
    );
  }
}
