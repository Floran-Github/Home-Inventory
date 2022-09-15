import 'package:flutter/material.dart';
import 'package:home_inventory/constant/colors.dart';

class SharedInventoryCard extends StatelessWidget {
  const SharedInventoryCard({Key? key, this.inventoryName}) : super(key: key);
  final String? inventoryName;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.sharedInv,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColors.sharedInv),
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
                "Shared Inventory",
                style: TextStyle(color: AppColors.white),
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Text(
                "$inventoryName",
                style: const TextStyle(fontSize: 24, color: AppColors.white),
                textAlign: TextAlign.center,
              )),
            ))
          ],
        ),
      ),
    );
  }
}
