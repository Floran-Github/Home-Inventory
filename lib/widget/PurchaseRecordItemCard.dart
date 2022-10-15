import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_inventory/constant/colors.dart';

class PurchaseRecordItem extends StatelessWidget {
  const PurchaseRecordItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: AppColors.purple,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: AppColors.purple),
          child: Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 1, color: AppColors.white)),
                ),
                child: const Text(
                  "Item No: 1",
                  style: TextStyle(color: AppColors.white, fontSize: 18),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 20, left: 8, right: 8, top: 8),
                child: Text(
                  "India gate basmati rice 5kg",
                  style: TextStyle(
                      color: AppColors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w600),
                ),
              ),
              purchaseCardRow("Price", "1200 Rs"),
              purchaseCardRow("Qty", 12),
            ]),
          ),
        ));
  }

  Padding purchaseCardRow(String label, data) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8),
      child: Flexible(
        child: RichText(
            text: TextSpan(children: <TextSpan>[
          TextSpan(
              text: "$label : ",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 20)),
          TextSpan(
              text: "$data",
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 20)),
        ])),
      ),
    );
  }
}
