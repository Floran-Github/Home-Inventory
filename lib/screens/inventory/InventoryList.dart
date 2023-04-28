import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:home_inventory/bloc/inventoryBloc.dart';
import 'package:home_inventory/constant/colors.dart';
import 'package:home_inventory/model/inventory/inventoryModel.dart';
import 'package:home_inventory/preference/preferences.dart';
import 'package:home_inventory/response/inventoryResponse.dart';
import 'package:home_inventory/widget/OwnInventoryCard.dart';
import 'package:home_inventory/widget/SharedInventoryCard.dart';
import 'package:home_inventory/widget/appbar.dart';

class InventoryListPage extends StatefulWidget {
  const InventoryListPage({Key? key}) : super(key: key);

  @override
  State<InventoryListPage> createState() => _InventoryListPageState();
}

class _InventoryListPageState extends State<InventoryListPage>
    with
        AutomaticKeepAliveClientMixin<InventoryListPage>,
        TickerProviderStateMixin {
  var tempinv = [0, 1, 1, 0, 0, 1, 1, 1, 1, 0];

  InventoryBloc? _inventoryBloc;
  Preference prefs = Preference();
  String? id;
  List<inventoryModel>? invList = [];
  Future<void> getId() async {
    var tempid = await prefs.getUsername();
    setState(() {
      id = tempid;
    });
  }

  @override
  void initState() {
    super.initState();
    _inventoryBloc = InventoryBloc();
    _inventoryBloc?.getInventory();
    getId();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var isportait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      appBar: const CustomAppBar(),
      floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: AppColors.white,
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: const Color(0xff393939),
                    title: const Text("Create New Inventory"),
                    scrollable: true,
                    actions: [
                      MaterialButton(
                        onPressed: () {},
                        color: AppColors.sharedInv,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                        child: const Text(
                          "Create",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      )
                    ],
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Inventory Name",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          decoration: InputDecoration(
                              hintText: "Inventory Name",
                              hintStyle:
                                  const TextStyle(color: Color(0xfff9f9f9)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      const BorderSide(color: Colors.white))),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  );
                });
          },
          child: const Icon(
            Icons.add,
            color: AppColors.mediumgreen,
            size: 50,
          )),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: StreamBuilder<InventoryRepsonse<List<inventoryModel>>>(
          stream: _inventoryBloc?.inventoryStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data?.status) {
                case Status.LOADING:
                  return Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).textTheme.bodyText1?.color,
                    ),
                  );
                case Status.COMPLETED:
                  invList = snapshot.data?.data.toList();
                  return CustomScrollView(slivers: [
                    pageheader(context),
                    SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: isportait ? 2 : 4),
                        delegate: SliverChildBuilderDelegate(
                            childCount: invList?.length,
                            (BuildContext context, int index) {
                          return invList![index].user_associated == id!
                              ? OwnInventoryCard(
                                  inventoryName: invList![index].invName,
                                  invData: invList![index],
                                )
                              : SharedInventoryCard(
                                  inventoryName: invList![index].invName,
                                  invData: invList![index],
                                );
                        }))
                  ]);

                case Status.ERROR:
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                      snapshot.data!.msg,
                      style: const TextStyle(fontSize: 20),
                    )));
                  });
                  break;
                default:
                  return const Center(
                    child: Text("No Inventory found"),
                  );
              }
            }
            return const Center(
              child: Text("No Inventory found"),
            );
          },
        ),
      ),
    );
  }

  SliverToBoxAdapter pageheader(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        child: const Text(
          "Inventories",
          style: TextStyle(fontSize: 23),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
