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
