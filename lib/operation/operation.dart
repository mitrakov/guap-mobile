import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
part 'operation.g.dart';

@JsonSerializable()
class Operation {
  final int id;
  final String item;
  final String category;
  final int summa;
  final String time;
  final String person;

  Operation(this.id, this.item, this.category, this.summa, this.time, this.person);

  factory Operation.fromJson(Map<String, dynamic> json) => _$OperationFromJson(json);

  Map<String, dynamic> toJson() => _$OperationToJson(this);

  String get itemUtf8 => item != null ? utf8.decode(item.runes.toList()) : '';

  String get categoryUtf8 => category != null ? utf8.decode(category.runes.toList()) : '';

  String get timeUtf8 => time != null ? utf8.decode(time.runes.toList()) : '';

  String get personUtf8 => person != null ? utf8.decode(person.runes.toList()) : '';
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

@JsonSerializable()
class AddOperationRequest {
  final String itemName;
  final String personName;
  final int summa;
  final String date;

  AddOperationRequest(this.itemName, this.personName, this.summa, this.date);

  factory AddOperationRequest.fromJson(Map<String, dynamic> json) => _$AddOperationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddOperationRequestToJson(this);
}
