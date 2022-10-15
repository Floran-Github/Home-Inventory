import 'package:flutter/material.dart';
import 'package:home_inventory/model/auth/loginModel.dart';
import 'package:home_inventory/response/authResponse.dart';
import '../../bloc/authBloc.dart';
import '../../constant/routes.dart';
import '../../preference/preferences.dart';

import '../../constant/colors.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Preference prefs = Preference();
  AuthBloc? _bloc;

  @override
  void initState() {
    _bloc = AuthBloc();
    super.initState();
  }

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
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                "Login Page",
                style: TextStyle(fontSize: 46),
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
                      label("Username"),
                      const SizedBox(
                        height: 4,
                      ),
                      usernameInput(),
                      const SizedBox(
                        height: 4,
                      ),
                      label("Password"),
                      const SizedBox(
                        height: 4,
                      ),
                      passwordInput(context),
                      const SizedBox(
                        height: 12,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      StreamBuilder<AuthRepsonse<loginModel>>(
                          stream: _bloc?.loginStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              switch (snapshot.data?.status) {
                                case Status.LOADING:
                                  return loadingBtn(context);
                                case Status.COMPLETED:
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    prefs.setToken(snapshot.data!.data.token);
                                    prefs.setUsername(
                                        snapshot.data!.data.user.username);
                                    Navigator.pushNamedAndRemoveUntil(context,
                                        Routes.basePageRoute, (route) => false);
                                  });
                                  break;
                                case Status.ERROR:
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                            content: Text(
                                      "Username or Password not valid",
                                      style: TextStyle(fontSize: 20),
                                    )));
                                  });
                                  return loginBtn(context);
                                default:
                                  return loginBtn(context);
                              }
                            }
                            return loginBtn(context);
                          }),
                      const SizedBox(height: 20)
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
                    child: const Text(
                      "Don't have an Account!",
                      style: TextStyle(color: AppColors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  TextFormField passwordInput(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: AppColors.black),
      obscureText: true,
      controller: passwordController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter password';
        }
        return null;
      },
      onFieldSubmitted: (v) =>
          login(context, usernameController.text, passwordController.text),
      decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.white,
          hintStyle: const TextStyle(fontSize: 12, color: Colors.grey),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          hintText: 'Password'),
    );
  }

  TextFormField usernameInput() {
    return TextFormField(
      style: const TextStyle(color: AppColors.black),
      controller: usernameController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
      decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.white,
          hintStyle: const TextStyle(fontSize: 12, color: Colors.grey),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          hintText: 'Username'),
    );
  }

  Text label(String label) {
    return Text(
      label,
      style: const TextStyle(fontSize: 16),
    );
  }

  // login function
  login(BuildContext context, String username, String password) {
    FocusScope.of(context).requestFocus(FocusNode());

    if (_formKey.currentState!.validate()) {
      _bloc?.login(username, password);
    }
  }

  Center loginBtn(BuildContext context) {
    return Center(
      child: MaterialButton(
        color: AppColors.white,
        minWidth: double.infinity,
        height: 55,
        shape: RoundedRectangleBorder(
            side: const BorderSide(color: AppColors.darkbgreen),
            borderRadius: BorderRadius.circular(15)),
        onPressed: () =>
            login(context, usernameController.text, passwordController.text),
        child: const Text(
          "Log In",
          style: TextStyle(fontSize: 25, color: AppColors.darkbgreen),
        ),
      ),
    );
  }
}

Center loadingBtn(BuildContext context) {
  return Center(
    child: MaterialButton(
      color: AppColors.white,
      minWidth: double.infinity,
      height: 55,
      shape: RoundedRectangleBorder(
          side: const BorderSide(color: AppColors.darkbgreen),
          borderRadius: BorderRadius.circular(15)),
      onPressed: () {},
      child: const CircularProgressIndicator(
        color: AppColors.white,
      ),
    ),
  );
}
