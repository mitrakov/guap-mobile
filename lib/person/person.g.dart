// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonResponse _$PersonResponseFromJson(Map<String, dynamic> json) {
  return PersonResponse(
    json['code'] as int,
    (json['msg'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$PersonResponseToJson(PersonResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.persons,
    };
