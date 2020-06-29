import 'package:json_annotation/json_annotation.dart';
part 'chart.g.dart';

@JsonSerializable()
class PieChartRequest {
  final int month;
  final int year;

  PieChartRequest(this.month, this.year);

  factory PieChartRequest.fromJson(Map<String, dynamic> json) => _$PieChartRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PieChartRequestToJson(this);
}

@JsonSerializable()
class TimeChartRequest {
  final String step;
  final String from;
  final List<String> categories;

  TimeChartRequest(this.step, this.from, this.categories);

  factory TimeChartRequest.fromJson(Map<String, dynamic> json) => _$TimeChartRequestFromJson(json);

  Map<String, dynamic> toJson() => _$TimeChartRequestToJson(this);
}

@JsonSerializable()
class UriResponse {
  final int code;
  final String url;

  UriResponse(this.code, this.url);

  factory UriResponse.fromJson(Map<String, dynamic> json) => _$UriResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UriResponseToJson(this);
}
