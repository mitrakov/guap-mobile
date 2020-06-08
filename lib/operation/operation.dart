import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
part 'operation.g.dart';

@JsonSerializable()
class Operation {
  final int id;
  final String _item;
  final String _category;
  final int summa;
  final String _time;
  final String _person;

  Operation(this.id, this._item, this._category, this.summa, this._time, this._person);

  factory Operation.fromJson(Map<String, dynamic> json) => _$OperationFromJson(json);

  Map<String, dynamic> toJson() => _$OperationToJson(this);

  String get item => _item != null ? utf8.decode(_item.runes.toList()) : '';

  String get category => _category != null ? utf8.decode(_category.runes.toList()) : '';

  String get time => _time != null ? utf8.decode(_time.runes.toList()) : '';

  String get person => _person != null ? utf8.decode(_person.runes.toList()) : '';
}

@JsonSerializable()
class OperationResponse {
  final int code;
  final Operation operation;

  OperationResponse(this.code, this.operation);

  factory OperationResponse.fromJson(Map<String, dynamic> json) => _$OperationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OperationResponseToJson(this);
}

@JsonSerializable()
class OperationListResponse {
  final int code;
  @JsonKey(name: "msg")
  final List<int> ids;

  OperationListResponse(this.code, this.ids);

  factory OperationListResponse.fromJson(Map<String, dynamic> json) => _$OperationListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OperationListResponseToJson(this);
}
