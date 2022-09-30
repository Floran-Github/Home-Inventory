import 'dart:async';

import 'package:flutter/material.dart';

import '../../constant/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 1500),
        () => Navigator.popAndPushNamed(context, Routes.welcomeRoute));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Expanded(
            child: Center(
                child: Text(
              "Home Inventory",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 72, fontWeight: FontWeight.w400),
            )),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Column(
                children: const [
                  Text(
                    "From",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w100),
                  ),
                  Text(
                    "Floran",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w100),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
