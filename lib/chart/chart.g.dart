// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PieChartRequest _$PieChartRequestFromJson(Map<String, dynamic> json) {
  return PieChartRequest(
    json['month'] as int,
    json['year'] as int,
  );
}

Map<String, dynamic> _$PieChartRequestToJson(PieChartRequest instance) =>
    <String, dynamic>{
      'month': instance.month,
      'year': instance.year,
    };

TimeChartRequest _$TimeChartRequestFromJson(Map<String, dynamic> json) {
  return TimeChartRequest(
    json['step'] as String,
    json['from'] as String,
    (json['categories'] as List<dynamic>).map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$TimeChartRequestToJson(TimeChartRequest instance) =>
    <String, dynamic>{
      'step': instance.step,
      'from': instance.from,
      'categories': instance.categories,
    };

UriResponse _$UriResponseFromJson(Map<String, dynamic> json) {
  return UriResponse(
    json['code'] as int,
    json['url'] as String,
  );
}

Map<String, dynamic> _$UriResponseToJson(UriResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'url': instance.url,
    };
