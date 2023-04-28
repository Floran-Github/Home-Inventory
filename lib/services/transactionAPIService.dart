import 'dart:convert';
import 'dart:io';

import 'package:home_inventory/constant/constant.dart';
import 'package:home_inventory/model/transaction/ocrCreate.dart';
import 'package:home_inventory/model/transaction/transDetail.dart';
import 'package:home_inventory/model/transaction/transactionModel.dart';
import 'package:home_inventory/preference/preferences.dart';
import 'package:http/http.dart' as http;

import '../utils/apiException.dart';

class TransactionApiService {
  Preference prefs = Preference();

  //ocr create
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

  // user transList
  Future<dynamic> userPurchaseRecord() async {
    try {
      String? token = await prefs.getToken();
      http.Response res = await http.get(
          Uri.parse('${Constant.baseURL}transaction/user/list'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Token $token'
          });

      var responseBody = _returnResponse(res);

      List<TransactionRecordModel> data = List.from(responseBody)
          .map((item) => TransactionRecordModel.fromMap(item))
          .toList();

      return data;
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
  }

  // inv transList
  Future<dynamic> invPurchaseRecord() async {
    try {
      String? token = await prefs.getToken();
      int? id = await prefs.getInvid();

      http.Response res = await http.get(
          Uri.parse('${Constant.baseURL}transaction/inv/$id'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Token $token'
          });

      var responseBody = _returnResponse(res);

      List<TransactionRecordModel> data = List.from(responseBody)
          .map((item) => TransactionRecordModel.fromMap(item))
          .toList();

      return data;
    } on SocketException {
      throw FetchDataException("No Internet Connection");
    }
  }

  // transDetail
  Future<dynamic> transactionDetail(int id) async {
    try {
      String? token = await prefs.getToken();

      http.Response res = await http.get(
          Uri.parse('${Constant.baseURL}transaction/detail/$id'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'Token $token'
          });

      var responseBody = _returnResponse(res);

      TransDetail data = TransDetail.fromMap(responseBody);
      return data;
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
