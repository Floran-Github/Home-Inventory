import 'package:flutter/material.dart';
import '../../constant/routes.dart';
import 'sign_in.dart';

import '../../constant/colors.dart';
import '../BasePage.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () => {Navigator.pop(context)},
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black
                : Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              "Login Page",
              style: TextStyle(fontSize: 36),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0, left: 20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    makeInput(
                        label: "Username", controller: usernameController),
                    const SizedBox(
                      height: 12,
                    ),
                    makeInput(
                        label: "Password",
                        obsureText: true,
                        controller: passwordController),
                    const SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: MaterialButton(
                        color: AppColors.white,
                        minWidth: double.infinity,
                        height: 55,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: AppColors.darkbgreen),
                            borderRadius: BorderRadius.circular(15)),
                        onPressed: () => {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BasePage(),
                              ),
                              (route) => false)
                        },
                        child: Text(
                          "Log In",
                          style: TextStyle(
                              fontSize: 20, color: AppColors.darkbgreen),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.signinRoute);
                  },
                  child: Text(
                    "Don't have an Account!",
                    style: TextStyle(color: AppColors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget makeInput({label, obsureText = false, controller}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(fontSize: 16),
      ),
      const SizedBox(
        height: 4,
      ),
      TextFormField(
        style: TextStyle(color: AppColors.black),
        controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
        obscureText: obsureText,
        decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.white,
            hintStyle: const TextStyle(fontSize: 12, color: Colors.grey),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            hintText: 'Enter ' + label),
      )
    ],
  );
}
