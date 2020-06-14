// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Operation _$OperationFromJson(Map<String, dynamic> json) {
  return Operation(
    json['id'] as int,
    json['item'] as String,
    json['category'] as String,
    json['summa'] as int,
    json['time'] as String,
    json['person'] as String,
  );
}

Map<String, dynamic> _$OperationToJson(Operation instance) => <String, dynamic>{
      'id': instance.id,
      'item': instance.item,
      'category': instance.category,
      'summa': instance.summa,
      'time': instance.time,
      'person': instance.person,
    };

OperationResponse _$OperationResponseFromJson(Map<String, dynamic> json) {
  return OperationResponse(
    json['code'] as int,
    json['operation'] == null
        ? null
        : Operation.fromJson(json['operation'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$OperationResponseToJson(OperationResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'operation': instance.operation,
    };

OperationListResponse _$OperationListResponseFromJson(
    Map<String, dynamic> json) {
  return OperationListResponse(
    json['code'] as int,
    (json['msg'] as List)?.map((e) => e as int)?.toList(),
  );
}

Map<String, dynamic> _$OperationListResponseToJson(
        OperationListResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.ids,
    };

AddOperationRequest _$AddOperationRequestFromJson(Map<String, dynamic> json) {
  return AddOperationRequest(
    json['itemName'] as String,
    json['personName'] as String,
    json['summa'] as int,
    json['date'] as String,
  );
}

Map<String, dynamic> _$AddOperationRequestToJson(
        AddOperationRequest instance) =>
    <String, dynamic>{
      'itemName': instance.itemName,
      'personName': instance.personName,
      'summa': instance.summa,
      'date': instance.date,
    };

AddOperationResponse _$AddOperationResponseFromJson(Map<String, dynamic> json) {
  return AddOperationResponse(
    json['code'] as int,
    json['msg'] as String,
  );
}

Map<String, dynamic> _$AddOperationResponseToJson(
        AddOperationResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
    };
