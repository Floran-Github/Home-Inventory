// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:home_inventory/model/inventory/productModel.dart';

class InventoryDetailModel {
  inventoryModel invdetail;
  List<ProductModel> prdList;
  InventoryDetailModel({
    required this.invdetail,
    required this.prdList,
  });

  InventoryDetailModel copyWith({
    inventoryModel? invdetail,
    List<ProductModel>? prdList,
  }) {
    return InventoryDetailModel(
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

  factory InventoryDetailModel.fromMap(Map<String, dynamic> map) {
    return InventoryDetailModel(
      invdetail:
          inventoryModel.fromMap(map['invdetail'] as Map<String, dynamic>),
      prdList: List<ProductModel>.from(
        (map['prdList']).map<ProductModel>(
          (x) => ProductModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory InventoryDetailModel.fromJson(String source) =>
      InventoryDetailModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'InventoryDetailModel(invdetail: $invdetail, prdList: $prdList)';

  @override
  bool operator ==(covariant InventoryDetailModel other) {
    if (identical(this, other)) return true;

    return other.invdetail == invdetail && listEquals(other.prdList, prdList);
  }

  @override
  int get hashCode => invdetail.hashCode ^ prdList.hashCode;
}

class inventoryModel {
  int id;
  String invName;
  String invCreateDate;
  String user_associated;
  List<int> sharedTo;
  inventoryModel({
    required this.id,
    required this.invName,
    required this.invCreateDate,
    required this.user_associated,
    required this.sharedTo,
  });

  inventoryModel copyWith({
    int? id,
    String? invName,
    String? invCreateDate,
    String? user_associated,
    List<int>? sharedTo,
  }) {
    return inventoryModel(
      id: id ?? this.id,
      invName: invName ?? this.invName,
      invCreateDate: invCreateDate ?? this.invCreateDate,
      user_associated: user_associated ?? this.user_associated,
      sharedTo: sharedTo ?? this.sharedTo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'invName': invName,
      'invCreateDate': invCreateDate,
      'user_associated': user_associated,
      'sharedTo': sharedTo,
    };
  }

  factory inventoryModel.fromMap(Map<String, dynamic> map) {
    return inventoryModel(
        id: map['id'] as int,
        invName: map['invName'] as String,
        invCreateDate: map['invCreateDate'] as String,
        user_associated: map['user_associated'] as String,
        sharedTo: List<int>.from(
          (map['sharedTo']),
        ));
  }

  String toJson() => json.encode(toMap());

  factory inventoryModel.fromJson(String source) =>
      inventoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'inventoryModel(id: $id, invName: $invName, invCreateDate: $invCreateDate, user_associated: $user_associated, sharedTo: $sharedTo)';
  }

  @override
  bool operator ==(covariant inventoryModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.invName == invName &&
        other.invCreateDate == invCreateDate &&
        other.user_associated == user_associated &&
        listEquals(other.sharedTo, sharedTo);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        invName.hashCode ^
        invCreateDate.hashCode ^
        user_associated.hashCode ^
        sharedTo.hashCode;
  }
}
