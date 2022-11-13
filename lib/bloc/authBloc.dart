import 'dart:async';

import 'package:home_inventory/model/auth/authModel.dart';
import 'package:home_inventory/model/auth/loginModel.dart';
import 'package:home_inventory/model/auth/registerModel.dart';
import 'package:home_inventory/repository/authRepository.dart';
import 'package:home_inventory/response/authResponse.dart';

class AuthBloc {
  late AuthRepository _authRepository;

  // controller
  late StreamController<AuthRepsonse<authModel>> _authController;
  late StreamController<AuthRepsonse<loginModel>> _loginController;
  late StreamController<AuthRepsonse<registerModel>> _registerController;

  // sink
  StreamSink<AuthRepsonse<authModel>> get authSink => _authController.sink;
  StreamSink<AuthRepsonse<loginModel>> get loginSink => _loginController.sink;
  StreamSink<AuthRepsonse<registerModel>> get registerSink =>
      _registerController.sink;

  // stream
  Stream<AuthRepsonse<authModel>> get authStream => _authController.stream;
  Stream<AuthRepsonse<loginModel>> get loginStream => _loginController.stream;
  Stream<AuthRepsonse<registerModel>> get registerStream =>
      _registerController.stream;

  AuthBloc() {
    _authController = StreamController<AuthRepsonse<authModel>>();
    _loginController = StreamController<AuthRepsonse<loginModel>>();
    _registerController = StreamController<AuthRepsonse<registerModel>>();

    _authRepository = AuthRepository();
  }

  // is Authenticated
  fetchIsAuth() async {
    authSink.add(AuthRepsonse.loading("Fetching Data"));

    try {
      authModel authData = await _authRepository.isAuth();
      authSink.add(AuthRepsonse.completed(authData));
    } catch (e) {
      authSink.add(AuthRepsonse.error(e.toString()));
    }
  }

  // login
  login(String username, String password) async {
    loginSink.add(AuthRepsonse.loading("Loging.."));
    try {
      loginModel loginData = await _authRepository.login(username, password);
      loginSink.add(AuthRepsonse.completed(loginData));
    } catch (e) {
      print(e);
      loginSink.add(AuthRepsonse.error(e.toString()));
    }
  }

  // register
  register(
      String username, String password, String password2, String email) async {
    registerSink.add(AuthRepsonse.loading("Registering..."));
    try {
      registerModel registerData =
          await _authRepository.register(username, email, password, password2);
      registerSink.add(AuthRepsonse.completed(registerData));
    } catch (e) {
      registerSink.add(AuthRepsonse.error(e.toString()));
    }
  }
}
