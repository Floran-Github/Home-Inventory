import 'dart:convert';
import 'dart:io';
import 'package:home_inventory/model/auth/authModel.dart';
import 'package:home_inventory/model/auth/loginModel.dart';
import 'package:home_inventory/model/auth/registerModel.dart';
import 'package:home_inventory/preference/preferences.dart';
import 'package:home_inventory/utils/apiException.dart';
import 'package:http/http.dart' as http;

import '../constant/constant.dart';

class AuthApiService {
  Preference prefs = Preference();

  // Login
  Future<dynamic> isAuth() async {
    try {
      String? token = await prefs.getToken();
      http.Response res = await http.get(
          Uri.parse('${Constant.baseURL}auth/user'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Token $token'
          });
      //  checking received response status code and converting it to json if got 20x status
      var responseBody = _returnResponse(res);
      return authModel.fromMap(responseBody);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
  }

  Future<dynamic> login(String username, String password) async {
    try {
      http.Response res =
          await http.post(Uri.parse('${Constant.baseURL}auth/login'),
              headers: <String, String>{'Content-Type': 'application/json'},
              body: jsonEncode(<String, String>{
                'username': username,
                'password': password,
              }));

      var responseBody = _returnResponse(res);
      return loginModel.fromMap(responseBody);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
  }

  Future<dynamic> register(
      String username, String email, String password, String password2) async {
    try {
      http.Response res =
          await http.post(Uri.parse('${Constant.baseURL}auth/register'),
              headers: <String, String>{'Content-Type': 'application/json'},
              body: jsonEncode(<String, String>{
                'username': username,
                'password': password,
                'password2': password2,
                "email": email
              }));
       var responseBody = _returnResponse(res);
      return registerModel.fromMap(responseBody);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
  }
}

dynamic _returnResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
      var responseJson = json.decode(response.body.toString());
      return responseJson;
    case 201:
      var responseJson = json.decode(response.body.toString());
      return responseJson;
    case 204:
      return "true";
    case 400:
      throw BadRequestException(response.body.toString());
    case 401:
      throw BadRequestException(response.body.toString());
    case 403:
      throw UnauthorisedException(response.body.toString());
    case 500:
    default:
      throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
  }
}
