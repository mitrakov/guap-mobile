import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
part 'category.g.dart';

@JsonSerializable()
class Category {
  final String _label;
  final List<Category> items;

  Category(this._label, this.items);

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);

  String get label => _label != null ? utf8.decode(_label.runes.toList()) : '';
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
