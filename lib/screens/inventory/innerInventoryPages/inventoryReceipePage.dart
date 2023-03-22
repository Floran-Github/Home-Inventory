import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:home_inventory/constant/colors.dart';
import 'package:home_inventory/constant/routes.dart';
import 'package:home_inventory/widget/nestedappbar.dart';

class InventoryReceipe extends StatefulWidget {
  const InventoryReceipe({super.key});

  @override
  State<InventoryReceipe> createState() => _InventoryReceipeState();
}

class _InventoryReceipeState extends State<InventoryReceipe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NestedAppBar(title: "Inventory"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomScrollView(
          slivers: [
            spacer10(),
            title(),
            spacer10(),
            SliverToBoxAdapter(
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6)),
                    hintText: "Search Receipes",
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: const Icon(Icons.search)),
              ),
            ),
            spacer10(),
            spacer10(),
            title2(),
            spacer10(),
            SliverList(
                delegate: SliverChildListDelegate([
              Expanded(
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 20,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 1.4),
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return receipeCard();
                  },
                ),
              )
            ]))
          ],
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

  SliverToBoxAdapter title() {
    return const SliverToBoxAdapter(
      child: Text(
        "What would you like 2 make?",
        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
      ),
    );
  }

  SliverToBoxAdapter title2() {
    return const SliverToBoxAdapter(
      child: Text(
        "Recepies based on items you ",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
      ),
    );
  }

  SliverToBoxAdapter spacer10() {
    return const SliverToBoxAdapter(
      child: SizedBox(
        height: 10,
      ),
    );
  }
}
