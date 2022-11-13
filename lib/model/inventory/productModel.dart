// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:home_inventory/model/inventory/inventoryModel.dart';

class InventoryDetail {
  inventoryModel invdetail;
  List<ProductModel> prdList;
  InventoryDetail({
    required this.invdetail,
    required this.prdList,
  });

  InventoryDetail copyWith({
    inventoryModel? invdetail,
    List<ProductModel>? prdList,
  }) {
    return InventoryDetail(
      invdetail: invdetail ?? this.invdetail,
      prdList: prdList ?? this.prdList,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'invdetail': invdetail.toMap(),
      'prdList': prdList.map((x) => x.toMap()).toList(),
    };
  }

  factory InventoryDetail.fromMap(Map<String, dynamic> map) {
    return InventoryDetail(
      invdetail: inventoryModel.fromMap(map['invdetail'] as Map<String,dynamic>),
      prdList: List<ProductModel>.from((map['prdList']).map<ProductModel>((x) => ProductModel.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory InventoryDetail.fromJson(String source) => InventoryDetail.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'InventoryDetail(invdetail: $invdetail, prdList: $prdList)';

  @override
  bool operator ==(covariant InventoryDetail other) {
    if (identical(this, other)) return true;
  
    return 
      other.invdetail == invdetail &&
      listEquals(other.prdList, prdList);
  }

  @override
  int get hashCode => invdetail.hashCode ^ prdList.hashCode;
}

class ProductModel {
  int id;
  String prdName;
  bool freezerPrd;
  bool readyToEat;
  String product_type;
  String product_weight_category;
  List<ProductPriceHistory> priceHistory;
  int prdQty;
  int product_weight_per_quantity;
  int totalquantity;
  ProductModel({
    required this.id,
    required this.prdName,
    required this.freezerPrd,
    required this.readyToEat,
    required this.product_type,
    required this.product_weight_category,
    required this.priceHistory,
    required this.prdQty,
    required this.product_weight_per_quantity,
    required this.totalquantity,
  });

  ProductModel copyWith({
    int? id,
    String? prdName,
    bool? freezerPrd,
    bool? readyToEat,
    String? product_type,
    String? product_weight_category,
    List<ProductPriceHistory>? priceHistory,
    int? prdQty,
    int? product_weight_per_quantity,
    int? totalquantity,
  }) {
    return ProductModel(
      id: id ?? this.id,
      prdName: prdName ?? this.prdName,
      freezerPrd: freezerPrd ?? this.freezerPrd,
      readyToEat: readyToEat ?? this.readyToEat,
      product_type: product_type ?? this.product_type,
      product_weight_category:
          product_weight_category ?? this.product_weight_category,
      priceHistory: priceHistory ?? this.priceHistory,
      prdQty: prdQty ?? this.prdQty,
      product_weight_per_quantity:
          product_weight_per_quantity ?? this.product_weight_per_quantity,
      totalquantity: totalquantity ?? this.totalquantity,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'prdName': prdName,
      'freezerPrd': freezerPrd,
      'readyToEat': readyToEat,
      'product_type': product_type,
      'product_weight_category': product_weight_category,
      'priceHistory': priceHistory.map((x) => x.toMap()).toList(),
      'prdQty': prdQty,
      'product_weight_per_quantity': product_weight_per_quantity,
      'totalquantity': totalquantity,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as int,
      prdName: map['prdName'] as String,
      freezerPrd: map['freezerPrd'] as bool,
      readyToEat: map['readyToEat'] as bool,
      product_type: map['product_type'] as String,
      product_weight_category: map['product_weight_category'] as String,
      priceHistory: List<ProductPriceHistory>.from(
        (map['priceHistory']).map<ProductPriceHistory>(
          (x) => ProductPriceHistory.fromMap(x as Map<String, dynamic>),
        ),
      ),
      prdQty: map['prdQty'] as int,
      product_weight_per_quantity: map['product_weight_per_quantity'] as int,
      totalquantity: map['totalquantity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductModel(id: $id, prdName: $prdName, freezerPrd: $freezerPrd, readyToEat: $readyToEat, product_type: $product_type, product_weight_category: $product_weight_category, priceHistory: $priceHistory, prdQty: $prdQty, product_weight_per_quantity: $product_weight_per_quantity, totalquantity: $totalquantity)';
  }

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.prdName == prdName &&
        other.freezerPrd == freezerPrd &&
        other.readyToEat == readyToEat &&
        other.product_type == product_type &&
        other.product_weight_category == product_weight_category &&
        listEquals(other.priceHistory, priceHistory) &&
        other.prdQty == prdQty &&
        other.product_weight_per_quantity == product_weight_per_quantity &&
        other.totalquantity == totalquantity;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        prdName.hashCode ^
        freezerPrd.hashCode ^
        readyToEat.hashCode ^
        product_type.hashCode ^
        product_weight_category.hashCode ^
        priceHistory.hashCode ^
        prdQty.hashCode ^
        product_weight_per_quantity.hashCode ^
        totalquantity.hashCode;
  }
}

class ProductPriceHistory {
  int id;
  int prdAssociated_id;
  double prdPrice;
  String date;
  ProductPriceHistory({
    required this.id,
    required this.prdAssociated_id,
    required this.prdPrice,
    required this.date,
  });

  ProductPriceHistory copyWith({
    int? id,
    int? prdAssociated_id,
    double? prdPrice,
    String? date,
  }) {
    return ProductPriceHistory(
      id: id ?? this.id,
      prdAssociated_id: prdAssociated_id ?? this.prdAssociated_id,
      prdPrice: prdPrice ?? this.prdPrice,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'prdAssociated_id': prdAssociated_id,
      'prdPrice': prdPrice,
      'date': date,
    };
  }

  factory ProductPriceHistory.fromMap(Map<String, dynamic> map) {
    return ProductPriceHistory(
      id: map['id'] as int,
      prdAssociated_id: map['prdAssociated_id'] as int,
      prdPrice: map['prdPrice'] as double,
      date: map['date'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductPriceHistory.fromJson(String source) =>
      ProductPriceHistory.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductPriceHistory(id: $id, prdAssociated_id: $prdAssociated_id, prdPrice: $prdPrice, date: $date)';
  }

  @override
  bool operator ==(covariant ProductPriceHistory other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.prdAssociated_id == prdAssociated_id &&
        other.prdPrice == prdPrice &&
        other.date == date;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        prdAssociated_id.hashCode ^
        prdPrice.hashCode ^
        date.hashCode;
  }
}
