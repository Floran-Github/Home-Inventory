import 'package:flutter/material.dart';
import 'package:home_inventory/bloc/inventoryBloc.dart';
import 'package:home_inventory/model/inventory/inventoryModel.dart';
import 'package:home_inventory/model/inventory/productModel.dart';
import 'package:home_inventory/preference/preferences.dart';
import 'package:home_inventory/response/inventoryResponse.dart';
import 'package:home_inventory/widget/inventory_prod_card.dart';

import '../../../widget/nestedappbar.dart';

class InventoryMainPage extends StatefulWidget {
  const InventoryMainPage({super.key});

  @override
  State<InventoryMainPage> createState() => _InventoryMainPageState();
}

class _InventoryMainPageState extends State<InventoryMainPage> {
  InventoryBloc? _bloc;
  Preference prefs = Preference();
  @override
  void initState() {
    _bloc = InventoryBloc();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    inventoryModel invData = arguments['invData'];

    _bloc?.getInventoryPrd(invData.id);

    prefs.setInvid(invData.id);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    inventoryModel invData = arguments['invData'];
    List<ProductModel>? invprdList = [];

    return Scaffold(
        appBar: const NestedAppBar(
          title: "Inventory",
        ),
        body: StreamBuilder<InventoryRepsonse<InventoryDetailModel>>(
          stream: _bloc?.inventoryPrdStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data?.status) {
                case Status.LOADING:
                  return Center(
                      child: CircularProgressIndicator(
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ));
                case Status.COMPLETED:
                  invprdList = snapshot.data?.data.prdList.toList();
                  return CustomScrollView(
                    slivers: [
                      const SliverToBoxAdapter(
                        child: SizedBox(
                          height: 10,
                        ),
                      ),
                      invDetailBox(snapshot.data!.data.invdetail),
                      detail(context),
                      SliverList(
                          delegate: SliverChildListDelegate([
                        GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: invprdList!.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio:
                                MediaQuery.of(context).size.width /
                                    (MediaQuery.of(context).size.height / 1.4),
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return InventoryPrdCard(
                              index: index,
                              prdData: invprdList![index],
                            );
                          },
                        )
                      ])),
                    ],
                  );
                case Status.ERROR:
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                      snapshot.data!.msg,
                      style: const TextStyle(fontSize: 20),
                    )));
                  });
                  return const Center(child: Text("No Product"));
                default:
                  return const Center(child: Text("No Product"));
              }
            }
            return const Center(child: Text("No Product"));
          },
        ));
  }

  SliverToBoxAdapter invDetailBox(inventoryModel invData) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.blue[700], borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Name: ",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 23),
                ),
                Text(
                  invData.invName,
                  style: const TextStyle(fontSize: 26),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Owner: ",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 23),
                          ),
                          Text(
                            invData.user_associated,
                            style: const TextStyle(fontSize: 26),
                          ),
                        ]),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Shared with :",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 23),
                          ),
                          Text(
                            "${invData.sharedTo.length} others",
                            style: const TextStyle(fontSize: 26),
                          ),
                        ]),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter detail(
    BuildContext context,
  ) {
    return const SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Text(
          "Items:",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 23),
        ),
      ),
    );
  }
}
