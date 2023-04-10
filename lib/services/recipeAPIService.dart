import 'dart:convert';
import 'dart:io';

import 'package:home_inventory/constant/constant.dart';
import 'package:home_inventory/model/receipe/receipeListModel.dart';
import 'package:home_inventory/preference/preferences.dart';
import 'package:home_inventory/utils/apiException.dart';
import 'package:http/http.dart' as http;

class RecipeAPI {
  Preference prefs = Preference();

  static Map<String, String> _headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
  };

  Future<dynamic> recipeList() async {
    try {
      String? token = await prefs.getToken();
      int? invPk = await prefs.getInvid();

      http.Response res = await http.get(
        Uri.parse("${Constant.baseURL}receipes/list/$invPk"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Token $token'
        },
      );

      var responseBody = _returnResponse(res);

      List<ReceipeModel> receipeList = List.from(responseBody)
          .map((item) => ReceipeModel.fromMap(item))
          .toList();

      return receipeList;
    } on SocketException {
      throw FetchDataException("No Internet Connection");
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
}
