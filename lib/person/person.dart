import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
part 'person.g.dart';

@JsonSerializable()
class PersonResponse {
  final int code;
  @JsonKey(name: "msg")
  final List<String> _persons;

  PersonResponse(this.code, this._persons);

  factory PersonResponse.fromJson(Map<String, dynamic> json) => _$PersonResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PersonResponseToJson(this);

  List<String> get persons => _persons.map((s) => utf8.decode(s.runes.toList())).toList();
}
