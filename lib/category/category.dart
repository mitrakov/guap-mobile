import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
part 'category.g.dart';

@JsonSerializable()
class Category {
  final String label;
  final List<Category> items;

  Category(this.label, this.items);

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);

  String get labelUtf8 => label != null ? utf8.decode(label.runes.toList()) : '';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Category && runtimeType == other.runtimeType && label == other.label && listEquals(items, other.items);

  @override
  int get hashCode => label.hashCode ^ items.hashCode;
}

@JsonSerializable()
class CategoryResponse {
  final int code;
  @JsonKey(name: "msg")
  final List<Category> categories;

  CategoryResponse(this.code, this.categories);

  factory CategoryResponse.fromJson(Map<String, dynamic> json) => _$CategoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryResponseToJson(this);
}
