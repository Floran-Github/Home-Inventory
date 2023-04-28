import 'package:home_inventory/model/transaction/ocrCreate.dart';
import 'package:home_inventory/model/transaction/transDetail.dart';
import 'package:home_inventory/model/transaction/transactionModel.dart';
import 'package:home_inventory/services/transactionAPIService.dart';

class TransationRepository {
  final TransactionApiService _service = TransactionApiService();

  // ocrcreate repository

  Future<OCRCreate> ocrCreate(
      String text, String market, int invAssociated) async {
    final response = await _service.ocrCreate(text, market, invAssociated);
    return response;
  }

  //  user purchase record
  Future<List<TransactionRecordModel>> userPurchaseRecord() async {
    final res = await _service.userPurchaseRecord();
    return res;
  }

  //  inv purchase record
  Future<List<TransactionRecordModel>> invPurchaseRecord() async {
    final res = await _service.invPurchaseRecord();
    return res;
  }

  // purhcase detail
  Future<TransDetail> transactionDetail(int id) async {
    final res = await _service.transactionDetail(id);
    return res;
  }
}
