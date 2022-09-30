// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:home_inventory/model/auth/authModel.dart';

class loginModel {
  authModel user;
  String token;
  loginModel({
    required this.user,
    required this.token,
  });

  loginModel copyWith({
    authModel? user,
    String? token,
  }) {
    return loginModel(
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

  factory loginModel.fromMap(Map<String, dynamic> map) {
    return loginModel(
      user: authModel.fromMap(map['user'] as Map<String,dynamic>),
      token: map['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory loginModel.fromJson(String source) => loginModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'loginModel(user: $user, token: $token)';

  @override
  bool operator ==(covariant loginModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.user == user &&
      other.token == token;
  }

  @override
  int get hashCode => user.hashCode ^ token.hashCode;
}
