import 'dart:convert';
import 'package:optional/optional.dart';
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

class CategoryItem {
  final Category category;
  final Optional<Category> parentOpt;
  final int level;

  CategoryItem(this.category, this.parentOpt, this.level);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is CategoryItem &&
              runtimeType == other.runtimeType && category == other.category && parentOpt == other.parentOpt && level == other.level;

  @override
  int get hashCode => category.hashCode ^ parentOpt.hashCode ^ level.hashCode;
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

@JsonSerializable()
class ChangeCategoryRequest {
  @JsonKey(name: "name")
  final String oldName;
  final String newName;
  @JsonKey(name: "newParentName")
  final String newParentNullable;

  ChangeCategoryRequest(this.oldName, this.newName, this.newParentNullable);

  factory ChangeCategoryRequest.fromJson(Map<String, dynamic> json) => _$ChangeCategoryRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ChangeCategoryRequestToJson(this);
}

@JsonSerializable()
class RemoveCategoryRequest {
  final String name;

  RemoveCategoryRequest(this.name);

  factory RemoveCategoryRequest.fromJson(Map<String, dynamic> json) => _$RemoveCategoryRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RemoveCategoryRequestToJson(this);
}
