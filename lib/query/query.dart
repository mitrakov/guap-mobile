import 'package:json_annotation/json_annotation.dart';
part 'query.g.dart';

@JsonSerializable()
class QueryAggregateResponse {
  final int code;
  @JsonKey(name: "msg")
  final double value;

  QueryAggregateResponse(this.code, this.value);

  factory QueryAggregateResponse.fromJson(Map<String, dynamic> json) => _$QueryAggregateResponseFromJson(json);

  Map<String, dynamic> toJson() => _$QueryAggregateResponseToJson(this);
}
