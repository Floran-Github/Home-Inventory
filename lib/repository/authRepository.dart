import 'package:home_inventory/model/auth/authModel.dart';
import 'package:home_inventory/model/auth/loginModel.dart';
import 'package:home_inventory/model/auth/registerModel.dart';
import 'package:home_inventory/services/authAPIService.dart';

class AuthRepository {
  final AuthApiService _service = AuthApiService();

  // auth repository

  Future<authModel> isAuth() async {
    final response = await _service.isAuth();
    return response;
  }

  // login repository
  Future<loginModel> login(String username, String password) async {
    final response = await _service.login(username, password);
    return response;
  }

  // register repository
  Future<registerModel> register(
      String username, String email, String password, String password2) async {
    final response =
        await _service.register(username, email, password, password2);
    return response;
  }
}
