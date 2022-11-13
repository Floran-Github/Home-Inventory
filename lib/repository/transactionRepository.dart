import 'package:home_inventory/model/transaction/ocrCreate.dart';
import 'package:home_inventory/services/transactionAPIService.dart';

class TransationRepository {
  final TransactionApiService _service = TransactionApiService();

  // ocrcreate repository

  Future<OCRCreate> ocrCreate(String text,String market,int invAssociated) async {
    final response = await _service.ocrCreate(text,market,invAssociated);
    return response;
  }

  
}
