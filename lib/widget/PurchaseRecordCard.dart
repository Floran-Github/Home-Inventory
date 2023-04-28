import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_inventory/constant/colors.dart';
import 'package:home_inventory/constant/routes.dart';

class PurchaseRecordCard extends StatelessWidget {
  const PurchaseRecordCard(
      {Key? key,
      required this.inventory,
      required this.date,
      required this.amount,
      this.qty, required this.id})
      : super(key: key);
  final int id;
  final String inventory;
  final String date;
  final double amount;
  final int? qty;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.sharedInv,
      child: MaterialButton(
        padding: const EdgeInsets.all(0.0),
        onPressed: () => Navigator.pushNamed(
            context, Routes.purhcaseDetailRoute,
            arguments: {'id': id}),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColors.purhcaseCardGreen),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 1, color: AppColors.white)),
                ),
                child: Text(
                  "Purchase for: $inventory",
                  style: const TextStyle(color: AppColors.black, fontSize: 18),
                ),
              ),
              purchaseCardDateRow(date),
              purchaseCardRow("Amount", amount),
              purchaseCardRow("Quantity", qty),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding purchaseCardDateRow(data) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8),
      child: RichText(
          text: TextSpan(children: <TextSpan>[
        TextSpan(
            text: "Date : ",
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontSize: 17)),
        TextSpan(
            text: "$data",
            style: GoogleFonts.montserrat(color: Colors.black, fontSize: 17)),
      ])),
    );
  }

  Padding purchaseCardRow(String label, data) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8),
      child: RichText(
          text: TextSpan(children: <TextSpan>[
        TextSpan(
            text: "$label : ",
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontSize: 23)),
        TextSpan(
            text: "$data",
            style: GoogleFonts.montserrat(color: Colors.black, fontSize: 23)),
      ])),
    );
  }
}
