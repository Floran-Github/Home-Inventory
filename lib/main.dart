import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_inventory/constant/colors.dart';
import 'package:home_inventory/constant/routes.dart';
import 'package:home_inventory/screens/BasePage.dart';
import 'package:home_inventory/screens/InventoryBasePage.dart';
import 'package:home_inventory/screens/auth/SplashScreen.dart';
import 'package:home_inventory/screens/auth/login.dart';
import 'package:home_inventory/screens/auth/sign_in.dart';
import 'package:home_inventory/screens/auth/welcomePage.dart';
import 'package:home_inventory/screens/inventory/InventoryList.dart';
import 'package:home_inventory/screens/inventory/innerInventoryPages/inventoryMainpage.dart';
import 'package:home_inventory/screens/inventory/innerInventoryPages/item_detail_screen.dart';
import 'package:home_inventory/screens/inventory/innerInventoryPages/receipe/receipe_page.dart';
import 'package:home_inventory/screens/purchase/PurchaseOCRpage.dart';
import 'package:home_inventory/screens/purchase/PurhcaseDetail.dart';
import 'package:home_inventory/screens/purchase/manulentry/purchase_manul_entry.dart';
import 'package:home_inventory/screens/purchase/ocrentry/bill_image_crop.dart';
import 'package:home_inventory/screens/purchase/ocrentry/ocr_detail.dart';
import 'package:home_inventory/screens/purchase/purchase_select_market.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Home Inventory",
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData(
          useMaterial3: true,
          textTheme: GoogleFonts.poppinsTextTheme(
              Theme.of(context).textTheme.apply(bodyColor: AppColors.black)),
          primaryTextTheme:
              GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
          scaffoldBackgroundColor: AppColors.lightgreen,
          appBarTheme:
              const AppBarTheme(backgroundColor: AppColors.lightgreen)),
      darkTheme: ThemeData(
          useMaterial3: true,
          textTheme: GoogleFonts.poppinsTextTheme(
              Theme.of(context).textTheme.apply(bodyColor: AppColors.white)),
          scaffoldBackgroundColor: Color(0xff303030),
          primaryTextTheme:
              GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
          appBarTheme: const AppBarTheme(backgroundColor: Color(0xff303030))),
      home: const SplashScreen(),
      routes: {
        Routes.signinRoute: (context) => const SigninPage(),
        Routes.loginRoute: (context) => LoginPage(),
        Routes.splashRoute: (context) => const SplashScreen(),
        Routes.basePageRoute: (context) => const BasePage(),
        Routes.homePageRoute: (context) => const InventoryListPage(),
        Routes.purhcaseDetailRoute: (context) => const PurhcaseDetailPage(),
        Routes.purchaseCreateRoute: (context) => const PurcaseOCRPage(),
        Routes.welcomeRoute: (context) => const WelcomePage(),
        Routes.iMainRoute: (context) => const InventoryBasePage(),
        Routes.selectMarket: (context) =>
            const PurchaseCreatePageSelectMarket(),
        Routes.manualEntry: (context) => const ManualEntryPage(),
        Routes.sourceSelect: (context) => const BillImageCrop(),
        Routes.ocrDetail: (context) => const OCRDetailScreen(),
        Routes.receipePage: (context) => const ReceipePage(),
        Routes.itemdetailPage: (context) => const ItemDetailScreen()
      },
      // initialRoute: Routes.welcomeRoute,
    );
  }
}
