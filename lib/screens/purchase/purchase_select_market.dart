import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:home_inventory/constant/colors.dart';
import 'package:home_inventory/constant/routes.dart';
import 'package:home_inventory/widget/nestedappbar.dart';

enum RadioOptions { reliance, dmart, bigBazar, other }

class PurchaseCreatePageSelectMarket extends StatefulWidget {
  const PurchaseCreatePageSelectMarket({super.key});

  @override
  State<PurchaseCreatePageSelectMarket> createState() =>
      _PurchaseCreatePageSelectMarketState();
}

const List<String> address = <String>[
  'Crystal Paradise Mall, Off Veera Desai Road, Near Janki Center, Dattaji Salvi Road, Andheri (West), Pincode : 400053',
  '120 Feet Road, Salasar Bhoomi, Temba lane, Bhayander (West), Pincode : 401101',
  'Crystal Paraqwedise Mall, Off Veera Desai Road, Near Janki Center, Dattaji Salvi Road, Andheri (West), Pincode : 400053',
  '120 Feet Road,qweqwe Salasar Bhoomi, Temba lane, Bhayander (West), Pincode : 401101',
  'Crystal Paradiqweqwese Mall, Off Veera Desai Road, Near Janki Center, Dattaji Salvi Road, Andheri (West), Pincode : 400053',
  '120 Feet Road, qweqweqeSalasar Bhoomi, Temba lane, Bhayander (West), Pincode : 401101',
  'Crystal Paradise qweq  qwerMall, Off Veera Desai Road, Near Janki Center, Dattaji Salvi Road, Andheri (West), Pincode : 400053',
  '120 Feet Road, Salaqwqwrqwrsar Bhoomi, Temba lane, Bhayander (West), Pincode : 401101',
  'Crystal Paradise Maqwrqwrqrqwll, Off Veera Desai Road, Near Janki Center, Dattaji Salvi Road, Andheri (West), Pincode : 400053',
  '120 Feet Road, Salaqwqwrqrsar Bhoomi, Temba lane, Bhayander (West), Pincode : 401101',
  'Crystal Paradise Malqrqwrrl, Off Veera Desai Road, Near Janki Center, Dattaji Salvi Road, Andheri (West), Pincode : 400053',
  '120 Feet Road, Salaqw2222qqrqqwrqwrqwsar Bhoomi, Temba lane, Bhayander (West), Pincode : 401101'
];

class _PurchaseCreatePageSelectMarketState
    extends State<PurchaseCreatePageSelectMarket> {
  RadioOptions? _radioOptions = RadioOptions.reliance;

  String selectedAddress = address.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NestedAppBar(title: "Create Purchase"),
      body: SingleChildScrollView(
          child: Container(
        margin: const EdgeInsets.all(10),
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: AppColors.greenShade,
            borderRadius: BorderRadius.circular(15)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            "Supermarket:",
            style: TextStyle(
                color: AppColors.white,
                fontSize: 23,
                fontWeight: FontWeight.w600),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    radioInput("Reliance", RadioOptions.reliance),
                    radioInput("Big Bazar", RadioOptions.bigBazar),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    radioInput("DMart", RadioOptions.dmart),
                    radioInput("Other", RadioOptions.other),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              actionBtn(Icons.camera, "Scan The Bill", (() {
                Navigator.pushNamed(context, Routes.sourceSelect,arguments: {'market':_radioOptions.toString()});
              })),
              const SizedBox(
                width: 20,
              ),
              actionBtn(Icons.create, "Enter Item Manually", (() {
                Navigator.pushNamed(context, Routes.manualEntry);
              })),
            ],
          )
        ]),
      )),
    );
  }

  Expanded actionBtn(IconData icondata, String label, onPressed) {
    return Expanded(
      child: MaterialButton(
        onPressed: onPressed,
        color: AppColors.greenShade2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
          child: Column(
            children: [
              Icon(
                icondata,
                size: 70,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                label,
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }

  RadioListTile<RadioOptions> radioInput(
      String label, RadioOptions optionValue) {
    return RadioListTile<RadioOptions>(
      contentPadding: EdgeInsets.all(0),
      activeColor: AppColors.white,
      title: Text(
        label,
        style: TextStyle(color: AppColors.white, fontSize: 20),
      ),
      value: optionValue,
      groupValue: _radioOptions,
      onChanged: (RadioOptions? value) {
        setState(() {
          _radioOptions = value;
        });
      },
    );
  }
}
