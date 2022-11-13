// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';




class inventoryModel {
  int id;
  String invName;
  String invCreateDate;
  int user_associated;
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
    int? user_associated,
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
      user_associated: map['user_associated'] as int,
      sharedTo: List<int>.from((map['sharedTo'])),
    );
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
