import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_inventory/constant/colors.dart';
import 'package:home_inventory/model/transaction/transDetail.dart';

class PurchaseRecordItem extends StatelessWidget {
  const PurchaseRecordItem({Key? key, required this.data, required this.index})
      : super(key: key);
  final int index;
  final TransItemModel data;
  @override
  Widget build(BuildContext context) {
    return Card(
        color: AppColors.purple,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: AppColors.purple),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 1, color: AppColors.white)),
              ),
              child: Text(
                "Item No: $index",
                style: TextStyle(color: AppColors.white, fontSize: 18),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20, left: 8, right: 8, top: 8),
              child: Text(
                data.prdAssociated,
                style: TextStyle(
                    color: AppColors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600),
              ),
            ),
            purchaseCardRow("Price", data.totalPrice),
            purchaseCardRow("Qty", data.prdQty),
          ]),
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
