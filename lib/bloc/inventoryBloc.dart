import 'dart:async';

import 'package:home_inventory/model/inventory/inventoryModel.dart';
import 'package:home_inventory/model/inventory/productModel.dart';
import 'package:home_inventory/repository/inventoryRespository.dart';
import 'package:home_inventory/response/inventoryResponse.dart';

class InventoryBloc {
  late InventoryRepository _inventoryRepository;

  // controller
  late StreamController<InventoryRepsonse<List<inventoryModel>>> _controller;
  late StreamController<InventoryRepsonse<InventoryDetailModel>>
      _productController;

  //  sink
  StreamSink<InventoryRepsonse<List<inventoryModel>>> get inventorySink =>
      _controller.sink;
  StreamSink<InventoryRepsonse<InventoryDetailModel>> get inventoryPrdSink =>
      _productController.sink;

  // stream
  Stream<InventoryRepsonse<List<inventoryModel>>> get inventoryStream =>
      _controller.stream;
  Stream<InventoryRepsonse<InventoryDetailModel>> get inventoryPrdStream =>
      _productController.stream;

  // constructor

  InventoryBloc() {
    _controller = StreamController<InventoryRepsonse<List<inventoryModel>>>();
    _productController =
        StreamController<InventoryRepsonse<InventoryDetailModel>>();
    _inventoryRepository = InventoryRepository();
  }

  // get inventory
  getInventory() async {
    inventorySink.add(InventoryRepsonse.loading("Fetching data"));
    try {
      List<inventoryModel> invList = await _inventoryRepository.getInventory();
      inventorySink.add(InventoryRepsonse.completed(invList));
    } catch (e) {
      inventorySink.add(InventoryRepsonse.error(e.toString()));
    }
  }

  // get inventory product
  getInventoryPrd(int id) async {
    inventoryPrdSink.add(InventoryRepsonse.loading("Fetching data.."));
    try {
      InventoryDetailModel prdList =
          await _inventoryRepository.getInventoryPrd(id);
      inventoryPrdSink.add(InventoryRepsonse.completed(prdList));
    } catch (e) {
      print(e);
      inventoryPrdSink.add(InventoryRepsonse.error(e.toString()));
    }
  }
}
