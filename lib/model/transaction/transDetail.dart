// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:home_inventory/model/inventory/productModel.dart';

class TransDetail {
  String market;
  String transDate;
  double totalAmount;
  int totalItem;
  List<ProductModel> products;
  TransDetail({
    required this.market,
    required this.transDate,
    required this.totalAmount,
    required this.totalItem,
    required this.products,
  });

  TransDetail copyWith({
    String? market,
    String? transDate,
    double? totalAmount,
    int? totalItem,
    List<ProductModel>? products,
  }) {
    return TransDetail(
      market: market ?? this.market,
      transDate: transDate ?? this.transDate,
      totalAmount: totalAmount ?? this.totalAmount,
      totalItem: totalItem ?? this.totalItem,
      products: products ?? this.products,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'market': market,
      'transDate': transDate,
      'totalAmount': totalAmount,
      'totalItem': totalItem,
      'products': products.map((x) => x.toMap()).toList(),
    };
  }

  factory TransDetail.fromMap(Map<String, dynamic> map) {
    return TransDetail(
      market: map['market'] as String,
      transDate: map['transDate'] as String,
      totalAmount: map['totalAmount'] as double,
      totalItem: map['totalItem'] as int,
      products: List<ProductModel>.from(
        (map['products']).map<ProductModel>(
          (x) => ProductModel.fromMap(x),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory TransDetail.fromJson(String source) =>
      TransDetail.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TransDetail(market: $market, transDate: $transDate, totalAmount: $totalAmount, totalItem: $totalItem, products: $products)';
  }

  @override
  bool operator ==(covariant TransDetail other) {
    if (identical(this, other)) return true;

    return other.market == market &&
        other.transDate == transDate &&
        other.totalAmount == totalAmount &&
        other.totalItem == totalItem &&
        listEquals(other.products, products);
  }

  @override
  int get hashCode {
    return market.hashCode ^
        transDate.hashCode ^
        totalAmount.hashCode ^
        totalItem.hashCode ^
        products.hashCode;
  }
}
