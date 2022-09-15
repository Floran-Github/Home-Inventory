import 'package:flutter/material.dart';
import 'package:home_inventory/constant/colors.dart';
import 'package:home_inventory/screens/dashboard/Dashboard.dart';
import 'package:home_inventory/screens/inventory/InventoryList.dart';
import 'package:home_inventory/screens/options/OptionsPage.dart';
import 'package:home_inventory/screens/purchase/PurchasePage.dart';

class BasePage extends StatefulWidget {
  const BasePage({Key? key}) : super(key: key);

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> with TickerProviderStateMixin {
  int index = 1;
  late TabController tabController;
  List<String> tabs = [
    "Dashboard",
    "Inventory",
    "Purchase",
    "Option",
  ];

  @override
  void initState() {
    super.initState();
    tabController =
        TabController(initialIndex: 1, length: tabs.length, vsync: this);
  }

  Widget iconContainer({iconName}) {
    return Container(
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
      ),
      child: Icon(
        iconName,
        size: 30,
        color: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      iconContainer(iconName: Icons.bar_chart_outlined),
      iconContainer(iconName: Icons.inventory),
      iconContainer(iconName: Icons.shopping_basket),
      iconContainer(iconName: Icons.more_vert_sharp),
    ];

    return Scaffold(
      body: TabBarView(
        controller: tabController,
        children: const [
          DashboardPage(),
          InventoryListPage(),
          PurchasePage(),
          OptionPage()
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(color: AppColors.mediumgreen),
        child: TabBar(
          indicator: const BoxDecoration(color: AppColors.darkbgreen),
          controller: tabController,
          tabs: [
            Tab(
              child: items[0],
            ),
            Tab(
              child: items[1],
            ),
            Tab(
              child: items[2],
            ),
            Tab(
              child: items[3],
            )
          ],
        ),
      ),
    );
  }
}
