// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemResponse _$ItemResponseFromJson(Map<String, dynamic> json) {
  return ItemResponse(
    json['code'] as int,
    (json['msg'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$ItemResponseToJson(ItemResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.items,
    };

AddItemRequest _$AddItemRequestFromJson(Map<String, dynamic> json) {
  return AddItemRequest(
    json['name'] as String,
    json['category'] as String,
  );
}

Map<String, dynamic> _$AddItemRequestToJson(AddItemRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'category': instance.category,
    };

ChangeItemRequest _$ChangeItemRequestFromJson(Map<String, dynamic> json) {
  return ChangeItemRequest(
    json['name'] as String,
    json['newName'] as String,
    json['newCategoryName'] as String,
  );
}

Map<String, dynamic> _$ChangeItemRequestToJson(ChangeItemRequest instance) =>
    <String, dynamic>{
      'name': instance.oldName,
      'newName': instance.newName,
      'newCategoryName': instance.newCategoryName,
    };

RemoveItemRequest _$RemoveItemRequestFromJson(Map<String, dynamic> json) {
  return RemoveItemRequest(
    json['name'] as String,
  );
}

Map<String, dynamic> _$RemoveItemRequestToJson(RemoveItemRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
    };
