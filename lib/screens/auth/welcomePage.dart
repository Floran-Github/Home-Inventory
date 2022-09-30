import 'package:flutter/material.dart';

import '../../constant/colors.dart';
import '../../constant/routes.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(height: 40),
                  const Text("Welcome",
                      style: TextStyle(
                        fontSize: 50,
                      )),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, right: 10.0, left: 10.0),
                    child: Image.asset(
                      'assets/images/welcome.png',
                      width: 397,
                      height: 316,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 30.0, bottom: 30.0),
                    child: Text("Track your budget easily",
                        style: TextStyle(
                          fontSize: 20,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: MaterialButton(
                      color: AppColors.white,
                      minWidth: double.infinity,
                      height: 60,
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(color: AppColors.white),
                          borderRadius: BorderRadius.circular(15)),
                      onPressed: () =>
                          {Navigator.pushNamed(context, Routes.loginRoute)},
                      child: const Text(
                        "Login",
                        style: TextStyle(fontSize: 24, color: AppColors.black),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: MaterialButton(
                      color: AppColors.darkbgreen,
                      minWidth: double.infinity,
                      height: 60,
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(color: AppColors.white),
                          borderRadius: BorderRadius.circular(15)),
                      onPressed: () =>
                          {Navigator.pushNamed(context, Routes.signinRoute)},
                      child: const Text(
                        "Register",
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
