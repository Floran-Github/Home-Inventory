// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ReceipeModel {
  String food_item;
  String duration;
  ReceipeModel({
    required this.food_item,
    required this.duration,
  });

  ReceipeModel copyWith({
    String? food_item,
    String? duration,
  }) {
    return ReceipeModel(
      food_item: food_item ?? this.food_item,
      duration: duration ?? this.duration,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'food_item': food_item,
      'duration': duration,
    };
  }

  factory ReceipeModel.fromMap(Map<String, dynamic> map) {
    return ReceipeModel(
      food_item: map['food_item'] as String,
      duration: map['duration'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReceipeModel.fromJson(String source) => ReceipeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ReceipeModel(food_item: $food_item, duration: $duration)';

  @override
  bool operator ==(covariant ReceipeModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.food_item == food_item &&
      other.duration == duration;
  }

  @override
  int get hashCode => food_item.hashCode ^ duration.hashCode;
}
