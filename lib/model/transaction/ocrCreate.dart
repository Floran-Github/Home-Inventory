// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class RecordItem {
  String prdName;
  int prdQty;
  int totalPrice;
  int product_weight_per_quantity;
  RecordItem({
    required this.prdName,
    required this.prdQty,
    required this.totalPrice,
    required this.product_weight_per_quantity,
  });

  RecordItem copyWith({
    String? prdName,
    int? prdQty,
    int? totalPrice,
    int? product_weight_per_quantity,
  }) {
    return RecordItem(
      prdName: prdName ?? this.prdName,
      prdQty: prdQty ?? this.prdQty,
      totalPrice: totalPrice ?? this.totalPrice,
      product_weight_per_quantity:
          product_weight_per_quantity ?? this.product_weight_per_quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'prdName': prdName,
      'prdQty': prdQty,
      'totalPrice': totalPrice,
      'product_weight_per_quantity': product_weight_per_quantity,
    };
  }

  factory RecordItem.fromMap(Map<String, dynamic> map) {
    return RecordItem(
      prdName: map['prdName'] as String,
      prdQty: map['prdQty'] as int,
      totalPrice: map['totalPrice'] as int,
      product_weight_per_quantity: map['product_weight_per_quantity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory RecordItem.fromJson(String source) =>
      RecordItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RecordItem(prdName: $prdName, prdQty: $prdQty, totalPrice: $totalPrice, product_weight_per_quantity: $product_weight_per_quantity)';
  }

  @override
  bool operator ==(covariant RecordItem other) {
    if (identical(this, other)) return true;

    return other.prdName == prdName &&
        other.prdQty == prdQty &&
        other.totalPrice == totalPrice &&
        other.product_weight_per_quantity == product_weight_per_quantity;
  }

  @override
  int get hashCode {
    return prdName.hashCode ^
        prdQty.hashCode ^
        totalPrice.hashCode ^
        product_weight_per_quantity.hashCode;
  }
}

class OCRCreate {
  List<RecordItem> recordItems;
  int totalPrice;
  int transId;
  OCRCreate({
    required this.recordItems,
    required this.totalPrice,
    required this.transId,
  });

  OCRCreate copyWith({
    List<RecordItem>? recordItems,
    int? totalPrice,
    int? transId,
  }) {
    return OCRCreate(
      recordItems: recordItems ?? this.recordItems,
      totalPrice: totalPrice ?? this.totalPrice,
      transId: transId ?? this.transId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'recordItems': recordItems.map((x) => x.toMap()).toList(),
      'totalPrice': totalPrice,
      'transId': transId,
    };
  }

  factory OCRCreate.fromMap(Map<String, dynamic> map) {
    return OCRCreate(
      recordItems: List<RecordItem>.from(
        (map['recordItems'] as List<int>).map<RecordItem>(
          (x) => RecordItem.fromMap(x as Map<String, dynamic>),
        ),
      ),
      totalPrice: map['totalPrice'] as int,
      transId: map['transId'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory OCRCreate.fromJson(String source) =>
      OCRCreate.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'OCRCreate(recordItems: $recordItems, totalPrice: $totalPrice, transId: $transId)';

  @override
  bool operator ==(covariant OCRCreate other) {
    if (identical(this, other)) return true;

    return listEquals(other.recordItems, recordItems) &&
        other.totalPrice == totalPrice &&
        other.transId == transId;
  }

  @override
  int get hashCode =>
      recordItems.hashCode ^ totalPrice.hashCode ^ transId.hashCode;
}
