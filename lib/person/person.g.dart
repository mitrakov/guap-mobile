// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonResponse _$PersonResponseFromJson(Map<String, dynamic> json) =>
    PersonResponse(
      json['code'] as int,
      (json['msg'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$PersonResponseToJson(PersonResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.persons,
    };

AddPersonRequest _$AddPersonRequestFromJson(Map<String, dynamic> json) =>
    AddPersonRequest(
      json['name'] as String,
    );

Map<String, dynamic> _$AddPersonRequestToJson(AddPersonRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
    };

ChangePersonRequest _$ChangePersonRequestFromJson(Map<String, dynamic> json) =>
    ChangePersonRequest(
      json['name'] as String,
      json['newName'] as String,
    );

Map<String, dynamic> _$ChangePersonRequestToJson(
        ChangePersonRequest instance) =>
    <String, dynamic>{
      'name': instance.oldName,
      'newName': instance.newName,
    };

RemovePersonRequest _$RemovePersonRequestFromJson(Map<String, dynamic> json) =>
    RemovePersonRequest(
      json['name'] as String,
    );

Map<String, dynamic> _$RemovePersonRequestToJson(
        RemovePersonRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
    };
