import 'package:flutter/material.dart';
import 'package:home_inventory/bloc/transactionBloc.dart';
import 'package:home_inventory/model/transaction/transactionModel.dart';
import 'package:home_inventory/preference/preferences.dart';
import 'package:home_inventory/response/transactionResponse.dart';
import 'package:home_inventory/widget/nestedappbar.dart';

import '../../../constant/colors.dart';
import '../../../constant/routes.dart';
import '../../../widget/PurchaseRecordCard.dart';

class InventoryPurchasePage extends StatefulWidget {
  const InventoryPurchasePage({super.key});

  @override
  State<InventoryPurchasePage> createState() => _InventoryPurchasePageState();
}

class _InventoryPurchasePageState extends State<InventoryPurchasePage> {
  TransactionBloc? _bloc;
  Preference prefs = Preference();
  List<TransactionRecordModel>? data = [];

  @override
  void initState() {
    _bloc = TransactionBloc();
    _bloc?.invPurchaseRecord();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NestedAppBar(
        title: "Home Inventory",
      ),
      floatingActionButton: FloatingActionButton(
          heroTag: "inventorycreate",
          shape: const CircleBorder(),
          backgroundColor: AppColors.white,
          onPressed: () => Navigator.pushNamed(context, Routes.selectMarket),
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
                "Inventory Purchase Record",
                style: TextStyle(fontSize: 23),
              ),
            ),
            StreamBuilder<TransactionResponse<List<TransactionRecordModel>>>(
              stream: _bloc?.invPurchaseStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  switch (snapshot.data?.status) {
                    case Status.LOADING:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    case Status.COMPLETED:
                      data = snapshot.data?.data;
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data?.data.length,
                        itemBuilder: (context, index) => PurchaseRecordCard(
                          id: data![index].id,
                          inventory: data![index].invAssociated,
                          date: data![index].transDate,
                          amount: data![index].totalAmount,
                          qty: data![index].totalItem,
                        ),
                      );
                    case Status.ERROR:
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                          snapshot.data!.msg,
                          style: const TextStyle(fontSize: 20),
                        )));
                      });

                      return const Center(child: Text(("Error occured")));
                    default:
                      return const Center(child: Text(("Error occured")));
                  }
                }
                return const Center(child: Text("No Purchase Record"));
              },
            )
          ],
        ),
      )),
    );
  }
}
