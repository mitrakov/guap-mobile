import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
part 'person.g.dart';

@JsonSerializable()
class PersonResponse {
  final int code;
  @JsonKey(name: "msg")
  final List<String> persons;

  PersonResponse(this.code, this.persons);

  factory PersonResponse.fromJson(Map<String, dynamic> json) => _$PersonResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PersonResponseToJson(this);

  List<String> get personsUtf8 => persons.map((s) => utf8.decode(s.runes.toList())).toList();
}

@JsonSerializable()
class ChangePersonRequest {
  @JsonKey(name: "name")
  final String oldName;
  final String newName;

  ChangePersonRequest(this.oldName, this.newName);

  factory ChangePersonRequest.fromJson(Map<String, dynamic> json) => _$ChangePersonRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ChangePersonRequestToJson(this);
}


@JsonSerializable()
class RemovePersonRequest {
  final String name;

  RemovePersonRequest(this.name);

  factory RemovePersonRequest.fromJson(Map<String, dynamic> json) => _$RemovePersonRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RemovePersonRequestToJson(this);
}
