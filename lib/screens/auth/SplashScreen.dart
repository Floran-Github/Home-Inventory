import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:home_inventory/bloc/authBloc.dart';
import 'package:home_inventory/model/auth/authModel.dart';
import 'package:home_inventory/response/authResponse.dart';

import '../../constant/colors.dart';
import '../../constant/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AuthBloc? _authBloc;
  @override
  void initState() {
    super.initState();
    _authBloc = AuthBloc();
    _authBloc?.fetchIsAuth();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          StreamBuilder<AuthRepsonse<authModel>>(
              stream: _authBloc?.authStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  switch (snapshot.data?.status) {
                    case Status.LOADING:
                      return mainArea();
                    case Status.COMPLETED:
                      WidgetsBinding.instance.addPostFrameCallback((_) =>
                          Navigator.pushNamedAndRemoveUntil(
                              context, Routes.basePageRoute, (route) => false));
                      break;
                    case Status.ERROR:
                      if (snapshot.data!.msg ==
                          "Error During Communication: No Internet Connection") {
                        return error();
                      }

                      WidgetsBinding.instance.addPostFrameCallback(
                        (_) => Navigator.pushReplacementNamed(
                            context, Routes.welcomeRoute),
                      );
                      break;
                    default:
                      return error();
                  }
                }
                return mainArea();
              }),
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

  Expanded error() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Icon(
              CupertinoIcons.wifi_slash,
              size: 100.0,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          MaterialButton(
            onPressed: () async {
              _authBloc?.fetchIsAuth();
            },
            color: AppColors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Refresh",
                style: TextStyle(fontSize: 25, color: AppColors.black),
              ),
            ),
          )
        ],
      ),
    );
  }

  Expanded mainArea() {
    return const Expanded(
      child: Center(
          child: Text(
        "Home Inventory",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 72, fontWeight: FontWeight.w400),
      )),
    );
  }
}
