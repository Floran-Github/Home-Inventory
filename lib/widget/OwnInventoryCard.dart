import 'package:flutter/material.dart';
import 'package:home_inventory/constant/colors.dart';
import 'package:home_inventory/constant/routes.dart';
import 'package:home_inventory/model/inventory/inventoryModel.dart';

class OwnInventoryCard extends StatelessWidget {
  const OwnInventoryCard({Key? key, this.inventoryName, required this.invData})
      : super(key: key);
  final String? inventoryName;
  final inventoryModel invData;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, Routes.iMainRoute,
          arguments: {'invData': invData}),
      child: Card(
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
                  style: const TextStyle(fontSize: 24, color: AppColors.white),
                  textAlign: TextAlign.center,
                )),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
