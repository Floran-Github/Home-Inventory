// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:home_inventory/model/transaction/transactionModel.dart';

class TransDetail {
  TransactionRecordModel recordDetail;
  List<TransItemModel> prdDetail;
  TransDetail({
    required this.recordDetail,
    required this.prdDetail,
  });

  TransDetail copyWith({
    TransactionRecordModel? recordDetail,
    List<TransItemModel>? prdDetail,
  }) {
    return TransDetail(
      recordDetail: recordDetail ?? this.recordDetail,
      prdDetail: prdDetail ?? this.prdDetail,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'recordDetail': recordDetail.toMap(),
      'prdDetail': prdDetail.map((x) => x.toMap()).toList(),
    };
  }

  factory TransDetail.fromMap(Map<String, dynamic> map) {
    return TransDetail(
      recordDetail: TransactionRecordModel.fromMap(
          map['recordDetail'] as Map<String, dynamic>),
      prdDetail: List<TransItemModel>.from(
        (map['prdDetail']).map<TransItemModel>(
          (x) => TransItemModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory TransDetail.fromJson(String source) =>
      TransDetail.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'TransDetail(recordDetail: $recordDetail, prdDetail: $prdDetail)';

  @override
  bool operator ==(covariant TransDetail other) {
    if (identical(this, other)) return true;

    return other.recordDetail == recordDetail &&
        listEquals(other.prdDetail, prdDetail);
  }

  @override
  int get hashCode => recordDetail.hashCode ^ prdDetail.hashCode;
}

class TransItemModel {
  int id;
  int prdQty;
  double prdPerPrice;
  double totalPrice;
  int transactionAssociated;
  String prdAssociated;
  TransItemModel({
    required this.id,
    required this.prdQty,
    required this.prdPerPrice,
    required this.totalPrice,
    required this.transactionAssociated,
    required this.prdAssociated,
  });

  TransItemModel copyWith({
    int? id,
    int? prdQty,
    double? prdPerPrice,
    double? totalPrice,
    int? transactionAssociated,
    String? prdAssociated,
  }) {
    return TransItemModel(
      id: id ?? this.id,
      prdQty: prdQty ?? this.prdQty,
      prdPerPrice: prdPerPrice ?? this.prdPerPrice,
      totalPrice: totalPrice ?? this.totalPrice,
      transactionAssociated:
          transactionAssociated ?? this.transactionAssociated,
      prdAssociated: prdAssociated ?? this.prdAssociated,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'prdQty': prdQty,
      'prdPerPrice': prdPerPrice,
      'totalPrice': totalPrice,
      'transactionAssociated': transactionAssociated,
      'prdAssociated': prdAssociated,
    };
  }

  factory TransItemModel.fromMap(Map<String, dynamic> map) {
    return TransItemModel(
      id: map['id'] as int,
      prdQty: map['prdQty'] as int,
      prdPerPrice: map['prdPerPrice'] as double,
      totalPrice: map['totalPrice'] as double,
      transactionAssociated: map['transactionAssociated'] as int,
      prdAssociated: map['prdAssociated'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransItemModel.fromJson(String source) =>
      TransItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TransItemModel(id: $id, prdQty: $prdQty, prdPerPrice: $prdPerPrice, totalPrice: $totalPrice, transactionAssociated: $transactionAssociated, prdAssociated: $prdAssociated)';
  }

  @override
  bool operator ==(covariant TransItemModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.prdQty == prdQty &&
        other.prdPerPrice == prdPerPrice &&
        other.totalPrice == totalPrice &&
        other.transactionAssociated == transactionAssociated &&
        other.prdAssociated == prdAssociated;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        prdQty.hashCode ^
        prdPerPrice.hashCode ^
        totalPrice.hashCode ^
        transactionAssociated.hashCode ^
        prdAssociated.hashCode;
  }
}
