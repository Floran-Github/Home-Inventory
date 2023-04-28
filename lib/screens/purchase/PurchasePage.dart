import 'package:flutter/material.dart';
import 'package:home_inventory/bloc/transactionBloc.dart';
import 'package:home_inventory/constant/routes.dart';
import 'package:home_inventory/model/transaction/transactionModel.dart';
import 'package:home_inventory/response/transactionResponse.dart';
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
  TransactionBloc? _transactionBloc;

  @override
  void initState() {
    _transactionBloc = TransactionBloc();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _transactionBloc?.userPurchaseRecord();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    List<TransactionRecordModel>? data = [];

    return Scaffold(
      appBar: const CustomAppBar(),
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
            StreamBuilder<TransactionResponse<List<TransactionRecordModel>>>(
              stream: _transactionBloc?.userPurchaseStream,
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
                return const Text("No Records");
              },
            )
          ],
        ),
      )),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
