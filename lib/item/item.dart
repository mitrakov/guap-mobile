import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
part 'item.g.dart';

@JsonSerializable()
class ItemResponse {
  final int code;
  @JsonKey(name: "msg")
  final List<String> items;

  ItemResponse(this.code, this.items);

  factory ItemResponse.fromJson(Map<String, dynamic> json) => _$ItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ItemResponseToJson(this);

  List<String> get itemsUtf8 => items.map((s) => utf8.decode(s.runes.toList())).toList();
}

@JsonSerializable()
class AddItemRequest {
  final String name;
  final String category;

  AddItemRequest(this.name, this.category);

  factory AddItemRequest.fromJson(Map<String, dynamic> json) => _$AddItemRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddItemRequestToJson(this);
}

@JsonSerializable()
class ChangeItemRequest {
  @JsonKey(name: "name")
  final String oldName;
  final String newName;
  final String newCategoryName;

  ChangeItemRequest(this.oldName, this.newName, this.newCategoryName);

  factory ChangeItemRequest.fromJson(Map<String, dynamic> json) => _$ChangeItemRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ChangeItemRequestToJson(this);
}

@JsonSerializable()
class RemoveItemRequest {
  final String name;

  RemoveItemRequest(this.name);
  
  factory RemoveItemRequest.fromJson(Map<String, dynamic> json) => _$RemoveItemRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RemoveItemRequestToJson(this);
}
