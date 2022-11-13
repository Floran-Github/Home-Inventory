import 'dart:async';

import 'package:home_inventory/model/transaction/ocrCreate.dart';
import 'package:home_inventory/repository/transactionRepository.dart';
import 'package:home_inventory/response/transactionResponse.dart';

class TransactionBloc {
  late TransationRepository _transationRepository;

  // controller
  late StreamController<TransactionResponse<OCRCreate>> _controller;

  // sink
  StreamSink<TransactionResponse<OCRCreate>> get ocrCreateSink =>
      _controller.sink;

  // stream

  Stream<TransactionResponse<OCRCreate>> get ocrCreateStream =>
      _controller.stream;

  TransactionBloc() {
    _controller = StreamController<TransactionResponse<OCRCreate>>();
    _transationRepository = TransationRepository();
  }

  ocrCreate(String text,String market,int invAssociated) async {
    ocrCreateSink.add(TransactionResponse.loading("Posting data.."));
    try {
      OCRCreate ocrCreateData = await _transationRepository.ocrCreate(text,market,invAssociated);
      ocrCreateSink.add(TransactionResponse.completed(ocrCreateData));
    } catch (e) {
      ocrCreateSink.add(TransactionResponse.error(e.toString()));
    }
  }
}
