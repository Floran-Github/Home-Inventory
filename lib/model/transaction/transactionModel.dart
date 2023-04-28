// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TransactionRecordModel {
  int id;
  String transDate;
  double totalAmount;
  int totalItem;
  int user_associated;
  String marketAssocaited;
  String invAssociated;
  TransactionRecordModel({
    required this.id,
    required this.transDate,
    required this.totalAmount,
    required this.totalItem,
    required this.user_associated,
    required this.marketAssocaited,
    required this.invAssociated,
  });

  TransactionRecordModel copyWith({
    int? id,
    String? transDate,
    double? totalAmount,
    int? totalItem,
    int? user_associated,
    String? marketAssocaited,
    String? invAssociated,
  }) {
    return TransactionRecordModel(
      id: id ?? this.id,
      transDate: transDate ?? this.transDate,
      totalAmount: totalAmount ?? this.totalAmount,
      totalItem: totalItem ?? this.totalItem,
      user_associated: user_associated ?? this.user_associated,
      marketAssocaited: marketAssocaited ?? this.marketAssocaited,
      invAssociated: invAssociated ?? this.invAssociated,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'transDate': transDate,
      'totalAmount': totalAmount,
      'totalItem': totalItem,
      'user_associated': user_associated,
      'marketAssocaited': marketAssocaited,
      'invAssociated': invAssociated,
    };
  }

  factory TransactionRecordModel.fromMap(Map<String, dynamic> map) {
    return TransactionRecordModel(
      id: map['id'] as int,
      transDate: map['transDate'] as String,
      totalAmount: map['totalAmount'] as double,
      totalItem: map['totalItem'] as int,
      user_associated: map['user_associated'] as int,
      marketAssocaited: map['marketAssocaited'] as String,
      invAssociated: map['invAssociated'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionRecordModel.fromJson(String source) => TransactionRecordModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TransactionRecordModel(id: $id, transDate: $transDate, totalAmount: $totalAmount, totalItem: $totalItem, user_associated: $user_associated, marketAssocaited: $marketAssocaited, invAssociated: $invAssociated)';
  }

  @override
  bool operator ==(covariant TransactionRecordModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.transDate == transDate &&
      other.totalAmount == totalAmount &&
      other.totalItem == totalItem &&
      other.user_associated == user_associated &&
      other.marketAssocaited == marketAssocaited &&
      other.invAssociated == invAssociated;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      transDate.hashCode ^
      totalAmount.hashCode ^
      totalItem.hashCode ^
      user_associated.hashCode ^
      marketAssocaited.hashCode ^
      invAssociated.hashCode;
  }
}
