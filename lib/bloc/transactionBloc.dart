import 'dart:async';

import 'package:home_inventory/model/transaction/ocrCreate.dart';
import 'package:home_inventory/model/transaction/transDetail.dart';
import 'package:home_inventory/model/transaction/transactionModel.dart';
import 'package:home_inventory/repository/transactionRepository.dart';
import 'package:home_inventory/response/transactionResponse.dart';

class TransactionBloc {
  late TransationRepository _transationRepository;

  // controller
  late StreamController<TransactionResponse<OCRCreate>> _controller;
  late StreamController<TransactionResponse<List<TransactionRecordModel>>>
      _userPurchasecontroller;
  late StreamController<TransactionResponse<List<TransactionRecordModel>>>
      _invPurchasecontroller;
  late StreamController<TransactionResponse<TransDetail>>
      _purchaseDetailcontroller;

  // sink
  StreamSink<TransactionResponse<OCRCreate>> get ocrCreateSink =>
      _controller.sink;
  StreamSink<TransactionResponse<List<TransactionRecordModel>>>
      get userPurchaseSink => _userPurchasecontroller.sink;
  StreamSink<TransactionResponse<List<TransactionRecordModel>>>
      get invPurchaseSink => _invPurchasecontroller.sink;
  StreamSink<TransactionResponse<TransDetail>> get purchaseDetailSink =>
      _purchaseDetailcontroller.sink;

  // stream

  Stream<TransactionResponse<OCRCreate>> get ocrCreateStream =>
      _controller.stream;

  Stream<TransactionResponse<List<TransactionRecordModel>>>
      get userPurchaseStream => _userPurchasecontroller.stream;
  Stream<TransactionResponse<List<TransactionRecordModel>>>
      get invPurchaseStream => _invPurchasecontroller.stream;

  Stream<TransactionResponse<TransDetail>> get purchaseDetailStream =>
      _purchaseDetailcontroller.stream;

  TransactionBloc() {
    _controller = StreamController<TransactionResponse<OCRCreate>>();
    _userPurchasecontroller =
        StreamController<TransactionResponse<List<TransactionRecordModel>>>();
    _invPurchasecontroller =
        StreamController<TransactionResponse<List<TransactionRecordModel>>>();
    _purchaseDetailcontroller =
        StreamController<TransactionResponse<TransDetail>>();
    _transationRepository = TransationRepository();
  }

  ocrCreate(String text, String market, int invAssociated) async {
    ocrCreateSink.add(TransactionResponse.loading("Posting data.."));
    try {
      OCRCreate ocrCreateData =
          await _transationRepository.ocrCreate(text, market, invAssociated);
      ocrCreateSink.add(TransactionResponse.completed(ocrCreateData));
    } catch (e) {
      ocrCreateSink.add(TransactionResponse.error(e.toString()));
    }
  }

  userPurchaseRecord() async {
    userPurchaseSink.add(TransactionResponse.loading("Fetching data"));
    try {
      List<TransactionRecordModel> data =
          await _transationRepository.userPurchaseRecord();

      userPurchaseSink.add(TransactionResponse.completed(data));
    } catch (e) {
      userPurchaseSink.add(TransactionResponse.error(e.toString()));
    }
  }

  invPurchaseRecord() async {
    invPurchaseSink.add(TransactionResponse.loading("Fetching data"));
    try {
      List<TransactionRecordModel> data =
          await _transationRepository.invPurchaseRecord();

      invPurchaseSink.add(TransactionResponse.completed(data));
    } catch (e) {
      invPurchaseSink.add(TransactionResponse.error(e.toString()));
    }
  }

  transactionDetail(int id) async {
    purchaseDetailSink.add(TransactionResponse.loading("Fetching data"));
    try {
      TransDetail data = await _transationRepository.transactionDetail(id);

      purchaseDetailSink.add(TransactionResponse.completed(data));
    } catch (e) {
      purchaseDetailSink.add(TransactionResponse.error(e.toString()));
    }
  }
}
