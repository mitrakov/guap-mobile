import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
part 'item.g.dart';

@JsonSerializable()
class ItemResponse {
  final int code;
  @JsonKey(name: "msg")
  final List<String> _items;

  ItemResponse(this.code, this._items);

  factory ItemResponse.fromJson(Map<String, dynamic> json) => _$ItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ItemResponseToJson(this);

  List<String> get items => _items.map((s) => utf8.decode(s.runes.toList())).toList();
}
