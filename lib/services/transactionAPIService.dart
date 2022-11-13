import 'dart:convert';
import 'dart:io';

import 'package:home_inventory/constant/constant.dart';
import 'package:home_inventory/model/transaction/ocrCreate.dart';
import 'package:home_inventory/preference/preferences.dart';
import 'package:http/http.dart' as http;

import '../utils/apiException.dart';

class TransactionApiService {
  Preference prefs = Preference();

  //ocr
  Future<dynamic> ocrCreate(
      String text, String market, int invAssociated) async {
    try {
      String? token = await prefs.getToken();
      http.Response res = await http.post(
          Uri.parse('${Constant.baseURL}transaction/create/ocr'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Token $token'
          },
          body: jsonEncode(<String, dynamic>{
            'scannedData': text,
            'market': market,
            'invAssociated': invAssociated
          }));

      var responseBody = _returnResponse(res);
      return OCRCreate.fromMap(responseBody);
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
  }

  // transList
  
  // transDetail

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
