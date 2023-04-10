import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:home_inventory/bloc/receipeBloc.dart';
import 'package:home_inventory/constant/colors.dart';
import 'package:home_inventory/constant/routes.dart';
import 'package:home_inventory/model/receipe/receipeListModel.dart';
import 'package:home_inventory/response/receipeResponse.dart';
import 'package:home_inventory/services/recipeAPIService.dart';
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
    // _bloc?.getReceipe();
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
            spacer10(),
            title(),
            spacer10(),
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6)),
                  hintText: "Search Receipes",
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: const Icon(Icons.search)),
            ),
            spacer10(),
            spacer10(),
            title2(),
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
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: receipes!.length,
                        itemBuilder: (context, index) {
                          return Container(
                            child: Column(
                              children: [
                                Text(receipes![index].food_item),
                                Text(receipes![index].duration),
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
                return Text("Add product to get suggestions");
              },
            ),
            // ListView.builder(
            //   physics: const NeverScrollableScrollPhysics(),
            //   shrinkWrap: true,
            // )
          ],
        )
            // [SliverList(
            //     delegate: SliverChildListDelegate([
            //   Expanded(
            //     child: GridView.builder(
            //       physics: const NeverScrollableScrollPhysics(),
            //       shrinkWrap: true,
            //       itemCount: 20,
            //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //         crossAxisCount: 2,
            //         childAspectRatio: MediaQuery.of(context).size.width /
            //             (MediaQuery.of(context).size.height / 1.4),
            //       ),
            //       itemBuilder: (BuildContext context, int index) {
            //         return receipeCard();
            //       },
            //     ),
            //   )
            // ]))],
            ),
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
    return Text(
      "What would you like 2 make?",
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
    );
  }

  Text title2() {
    return Text(
      "Recepies based on items you ",
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
    );
  }

  SizedBox spacer10() {
    return SizedBox(
      height: 10,
    );
  }
}
