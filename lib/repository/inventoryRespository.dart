import 'package:home_inventory/model/inventory/inventoryModel.dart';
import 'package:home_inventory/model/inventory/productModel.dart';
import 'package:home_inventory/services/inventoryAPIService.dart';

class InventoryRepository {
  final InventoryApiServices _services = InventoryApiServices();

  // get list of inventory

  Future<List<inventoryModel>> getInventory() async {
    final response = await _services.inventoryList();
    return response;
  }

  // get inventory product
  Future<InventoryDetailModel> getInventoryPrd(int id) async {
    final response = await _services.inventoryProductList(id);
    return response;
  }
}
