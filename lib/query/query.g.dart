// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'query.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QueryAggregateResponse _$QueryAggregateResponseFromJson(
    Map<String, dynamic> json) {
  return QueryAggregateResponse(
    json['code'] as int,
    (json['msg'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$QueryAggregateResponseToJson(
        QueryAggregateResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.value,
    };
