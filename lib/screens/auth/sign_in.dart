import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:home_inventory/constant/colors.dart';

import '../../constant/routes.dart';
import '../BasePage.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  State<SigninPage> createState() => SigninPageState();
}

class SigninPageState extends State<SigninPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController password2 = TextEditingController();
  String? emailError;
  String? passwordError;
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
            const Text(
              "Register Page",
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
                    emailInput(label: "Email", controller: emailController),
                    const SizedBox(
                      height: 12,
                    ),
                    makeInput(
                        label: "Password",
                        obsureText: true,
                        controller: passwordController),
                    SizedBox(
                      height: 12,
                    ),
                    makeInput(
                        label: "Confirm Password",
                        obsureText: true,
                        controller: password2),
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
                          "Register",
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
                    Navigator.pushNamed(context, Routes.loginRoute);
                  },
                  child: Text(
                    'Already have an Account!',
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
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              hintText: 'Enter ' + label),
        )
      ],
    );
  }

  Widget emailInput({label, controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          controller: controller,
          validator: (value) => EmailValidator.validate(value!)
              ? null
              : "Please enter a valid email",
          decoration: InputDecoration(
              fillColor: AppColors.white,
              filled: true,
              hintStyle: const TextStyle(fontSize: 12, color: Colors.grey),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              hintText: 'Enter ' + label),
        )
      ],
    );
  }
}
