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
    (json['summa'] as num).toDouble(),
    json['time'] as String,
    json['person'] as String?,
    json['currency'] as String,
    (json['currencyRate'] as num?)?.toDouble(),
    json['comment'] as String?,
  );
}

Map<String, dynamic> _$OperationToJson(Operation instance) => <String, dynamic>{
      'id': instance.id,
      'item': instance.item,
      'category': instance.category,
      'summa': instance.summa,
      'time': instance.time,
      'person': instance.person,
      'currency': instance.currency,
      'currencyRate': instance.currencyRate,
      'comment': instance.comment,
    };

OperationResponse _$OperationResponseFromJson(Map<String, dynamic> json) {
  return OperationResponse(
    json['code'] as int,
    Operation.fromJson(json['operation'] as Map<String, dynamic>),
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
    (json['msg'] as List<dynamic>).map((e) => e as int).toList(),
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
    (json['summa'] as num).toDouble(),
    json['date'] as String,
    json['currency'] as String,
    (json['currencyRate'] as num).toDouble(),
    json['comment'] as String,
  );
}

Map<String, dynamic> _$AddOperationRequestToJson(
        AddOperationRequest instance) =>
    <String, dynamic>{
      'itemName': instance.itemName,
      'personName': instance.personName,
      'summa': instance.summa,
      'date': instance.date,
      'currency': instance.currency,
      'currencyRate': instance.currencyRate,
      'comment': instance.comment,
    };

ChangeOperationRequest _$ChangeOperationRequestFromJson(
    Map<String, dynamic> json) {
  return ChangeOperationRequest(
    json['id'] as int,
    json['itemName'] as String,
    json['personName'] as String,
    (json['summa'] as num).toDouble(),
    json['date'] as String,
    json['currency'] as String,
    (json['currencyRate'] as num).toDouble(),
    json['comment'] as String,
  );
}

Map<String, dynamic> _$ChangeOperationRequestToJson(
        ChangeOperationRequest instance) =>
    <String, dynamic>{
      'itemName': instance.itemName,
      'personName': instance.personName,
      'summa': instance.summa,
      'date': instance.date,
      'currency': instance.currency,
      'currencyRate': instance.currencyRate,
      'comment': instance.comment,
      'id': instance.id,
    };

RemoveOperationRequest _$RemoveOperationRequestFromJson(
    Map<String, dynamic> json) {
  return RemoveOperationRequest(
    json['id'] as int,
  );
}

Map<String, dynamic> _$RemoveOperationRequestToJson(
        RemoveOperationRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
    };
