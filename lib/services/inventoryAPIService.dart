import 'dart:convert';
import 'dart:io';

import 'package:home_inventory/constant/constant.dart';
import 'package:home_inventory/model/inventory/inventoryModel.dart';
import 'package:home_inventory/model/inventory/productModel.dart';
import 'package:home_inventory/preference/preferences.dart';
import 'package:http/http.dart' as http;

import '../utils/apiException.dart';

class InventoryApiServices {
  Preference prefs = Preference();

  // get inventory
  Future<dynamic> inventoryList() async {
    try {
      String? token = await prefs.getToken();
      http.Response res = await http.get(
          Uri.parse("${Constant.baseURL}inventory/"),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Token $token'
          });

      var responseBody = _returnResponse(res);
      List<inventoryModel> invList = List.from(responseBody)
          .map((item) => inventoryModel.fromMap(item))
          .toList();
      return invList;
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
  }

  // get inventory product
  Future<dynamic> inventoryProductList(int id) async {
    try {
      String? token = await prefs.getToken();
      http.Response res = await http.get(
          Uri.parse("${Constant.baseURL}inventory/$id"),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Token $token'
          });
      var responseBody = _returnResponse(res);
      
      return InventoryDetailModel.fromMap(responseBody);
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
