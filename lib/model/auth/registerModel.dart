// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:home_inventory/model/auth/authModel.dart';

class registerModel {
  authModel user;
  String token;
  registerModel({
    required this.user,
    required this.token,
  });

  registerModel copyWith({
    authModel? user,
    String? token,
  }) {
    return registerModel(
      user: user ?? this.user,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user.toMap(),
      'token': token,
    };
  }

  factory registerModel.fromMap(Map<String, dynamic> map) {
    return registerModel(
      user: authModel.fromMap(map['user'] as Map<String,dynamic>),
      token: map['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory registerModel.fromJson(String source) => registerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'registerModel(user: $user, token: $token)';

  @override
  bool operator ==(covariant registerModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.user == user &&
      other.token == token;
  }

  @override
  int get hashCode => user.hashCode ^ token.hashCode;
}
