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
