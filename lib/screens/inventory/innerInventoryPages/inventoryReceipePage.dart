import 'package:flutter/material.dart';
import 'package:home_inventory/bloc/receipeBloc.dart';
import 'package:home_inventory/constant/colors.dart';
import 'package:home_inventory/constant/routes.dart';
import 'package:home_inventory/model/receipe/receipeListModel.dart';
import 'package:home_inventory/response/receipeResponse.dart';
import 'package:home_inventory/widget/nestedappbar.dart';

class InventoryReceipe extends StatefulWidget {
  const InventoryReceipe({super.key});

  @override
  State<InventoryReceipe> createState() => _InventoryReceipeState();
}

class _InventoryReceipeState extends State<InventoryReceipe> {
  List<ReceipeModel>? receipes = [];
  ReceipeBloc? _bloc;
  @override
  void initState() {
    super.initState();
    _bloc = ReceipeBloc();
    _bloc?.getReceipe();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NestedAppBar(title: "Inventory"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
            child: Column(
          children: [
            title(),
            spacer10(),
            StreamBuilder<ReceipeResponse<List<ReceipeModel>>>(
              stream: _bloc?.receipeStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  switch (snapshot.data?.status) {
                    case Status.LOADING:
                      return Center(
                          child: CircularProgressIndicator(
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ));
                    case Status.COMPLETED:
                      receipes = snapshot.data?.data.toList();
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: receipes!.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                                color: AppColors.myInv,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    receipes![index].food_item,
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Duration",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800),
                                    ),
                                    Text(receipes![index].duration),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      );
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
                      break;
                  }
                }
                return const Text("Add product to get suggestions");
              },
            ),
          ],
        )),
      ),
    );
  }

  GestureDetector receipeCard() {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, Routes.receipePage),
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.sharedInv),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/food.png"),
              const Text(
                "Burger",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.schedule,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "45 Min",
                    style: TextStyle(fontSize: 20),
                  )
                ],
              )
            ]),
      ),
    );
  }

  Text title() {
    return const Text(
      "What would you like 2 make?",
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
    );
  }

  SizedBox spacer10() {
    return const SizedBox(
      height: 10,
    );
  }
}
