import 'dart:convert';

class ProductModel {
  int id;
  int prdQty;
  int product_weight_per_quantity;
  int totalquantity;
  int invAssociated;
  PrdouctDetailModel prodAssociated;
  ProductModel({
    required this.id,
    required this.prdQty,
    required this.product_weight_per_quantity,
    required this.totalquantity,
    required this.invAssociated,
    required this.prodAssociated,
  });

  ProductModel copyWith({
    int? id,
    int? prdQty,
    int? product_weight_per_quantity,
    int? totalquantity,
    int? invAssociated,
    PrdouctDetailModel? prodAssociated,
  }) {
    return ProductModel(
      id: id ?? this.id,
      prdQty: prdQty ?? this.prdQty,
      product_weight_per_quantity:
          product_weight_per_quantity ?? this.product_weight_per_quantity,
      totalquantity: totalquantity ?? this.totalquantity,
      invAssociated: invAssociated ?? this.invAssociated,
      prodAssociated: prodAssociated ?? this.prodAssociated,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'prdQty': prdQty,
      'product_weight_per_quantity': product_weight_per_quantity,
      'totalquantity': totalquantity,
      'invAssociated': invAssociated,
      'prodAssociated': prodAssociated.toMap(),
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id']?.toInt() ?? 0,
      prdQty: map['prdQty']?.toInt() ?? 0,
      product_weight_per_quantity:
          map['product_weight_per_quantity']?.toInt() ?? 0,
      totalquantity: map['totalquantity']?.toInt() ?? 0,
      invAssociated: map['invAssociated']?.toInt() ?? 0,
      prodAssociated: PrdouctDetailModel.fromMap(map['prodAssociated']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductModel(id: $id, prdQty: $prdQty, product_weight_per_quantity: $product_weight_per_quantity, totalquantity: $totalquantity, invAssociated: $invAssociated, prodAssociated: $prodAssociated)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductModel &&
        other.id == id &&
        other.prdQty == prdQty &&
        other.product_weight_per_quantity == product_weight_per_quantity &&
        other.totalquantity == totalquantity &&
        other.invAssociated == invAssociated &&
        other.prodAssociated == prodAssociated;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        prdQty.hashCode ^
        product_weight_per_quantity.hashCode ^
        totalquantity.hashCode ^
        invAssociated.hashCode ^
        prodAssociated.hashCode;
  }
}

class PrdouctDetailModel {
  int id;
  String prdName;
  bool freezerPrd;
  bool readyToEat;
  String product_type;
  String product_weight_category;
  PrdouctDetailModel({
    required this.id,
    required this.prdName,
    required this.freezerPrd,
    required this.readyToEat,
    required this.product_type,
    required this.product_weight_category,
  });

  PrdouctDetailModel copyWith({
    int? id,
    String? prdName,
    bool? freezerPrd,
    bool? readyToEat,
    String? product_type,
    String? product_weight_category,
  }) {
    return PrdouctDetailModel(
      id: id ?? this.id,
      prdName: prdName ?? this.prdName,
      freezerPrd: freezerPrd ?? this.freezerPrd,
      readyToEat: readyToEat ?? this.readyToEat,
      product_type: product_type ?? this.product_type,
      product_weight_category:
          product_weight_category ?? this.product_weight_category,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'prdName': prdName,
      'freezerPrd': freezerPrd,
      'readyToEat': readyToEat,
      'product_type': product_type,
      'product_weight_category': product_weight_category,
    };
  }

  factory PrdouctDetailModel.fromMap(Map<String, dynamic> map) {
    return PrdouctDetailModel(
      id: map['id']?.toInt() ?? 0,
      prdName: map['prdName'] ?? '',
      freezerPrd: map['freezerPrd'] ?? false,
      readyToEat: map['readyToEat'] ?? false,
      product_type: map['product_type'] ?? '',
      product_weight_category: map['product_weight_category'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory PrdouctDetailModel.fromJson(String source) =>
      PrdouctDetailModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PrdouctDetailModel(id: $id, prdName: $prdName, freezerPrd: $freezerPrd, readyToEat: $readyToEat, product_type: $product_type, product_weight_category: $product_weight_category)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PrdouctDetailModel &&
        other.id == id &&
        other.prdName == prdName &&
        other.freezerPrd == freezerPrd &&
        other.readyToEat == readyToEat &&
        other.product_type == product_type &&
        other.product_weight_category == product_weight_category;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        prdName.hashCode ^
        freezerPrd.hashCode ^
        readyToEat.hashCode ^
        product_type.hashCode ^
        product_weight_category.hashCode;
  }
}
