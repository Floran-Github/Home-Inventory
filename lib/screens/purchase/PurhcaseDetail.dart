import 'package:flutter/material.dart';
import 'package:home_inventory/bloc/transactionBloc.dart';
import 'package:home_inventory/model/inventory/inventoryModel.dart';
import 'package:home_inventory/model/transaction/transDetail.dart';
import 'package:home_inventory/response/transactionResponse.dart';
import 'package:home_inventory/widget/PurchaseRecordItemCard.dart';
import 'package:home_inventory/widget/nestedappbar.dart';

class PurhcaseDetailPage extends StatefulWidget {
  const PurhcaseDetailPage({Key? key}) : super(key: key);

  @override
  State<PurhcaseDetailPage> createState() => _PurhcaseDetailPageState();
}

class _PurhcaseDetailPageState extends State<PurhcaseDetailPage> {
  TransactionBloc? _bloc;

  @override
  void initState() {
    _bloc = TransactionBloc();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    int id = arguments['id'];
    _bloc?.transactionDetail(id);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var isportait = MediaQuery.of(context).orientation == Orientation.portrait;
    List<TransItemModel> itemData = [];
    return Scaffold(
      appBar: const NestedAppBar(title: "Purchase Record"),
      body: StreamBuilder<TransactionResponse<TransDetail>>(
        stream: _bloc?.purchaseDetailStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data?.status) {
              case Status.LOADING:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case Status.COMPLETED:
                return MainSec(context, isportait, snapshot.data!.data);
              case Status.ERROR:
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                    snapshot.data!.msg,
                    style: const TextStyle(fontSize: 20),
                  )));
                });
                return errorMsg();
              default:
                return errorMsg();
            }
          }
          return errorMsg();
        },
      ),
    );
  }

  Center errorMsg() {
    return const Center(
      child: Text("Something went wrong"),
    );
  }

  CustomScrollView MainSec(
      BuildContext context, bool isportait, TransDetail data) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 10,
          ),
        ),
        detail(
            context,
            data.recordDetail.transDate,
            data.recordDetail.marketAssocaited,
            data.recordDetail.totalAmount,
            data.recordDetail.totalItem),
        SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isportait ? 2 : 4, childAspectRatio: 0.65),
          delegate: SliverChildBuilderDelegate(
              childCount: data.prdDetail.length, (context, index) {
            return PurchaseRecordItem(
              index: index,
              data: data.prdDetail[index],
            );
          }),
        )
      ],
    );
  }

  SliverToBoxAdapter detail(
      BuildContext context, String date, String shopName, double amt, int qty) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Date :",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 23),
            ),
            Text(
              date,
              style: const TextStyle(fontSize: 26),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Purchase from :",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 23),
            ),
            Text(
              shopName,
              style: const TextStyle(fontSize: 26),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text(
                    "Amount :",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 23),
                  ),
                  Text(
                    "Rs: $amt",
                    style: const TextStyle(fontSize: 26),
                  ),
                ]),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text(
                    "No of item:",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 23),
                  ),
                  Text(
                    "$qty",
                    style: const TextStyle(fontSize: 26),
                  ),
                ]),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Item :",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 23),
            ),
          ],
        ),
      ),
    );
  }
}
