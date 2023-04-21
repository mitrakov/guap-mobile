// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      json['label'] as String,
      (json['items'] as List<dynamic>)
          .map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'label': instance.label,
      'items': instance.items,
    };

CategoryResponse _$CategoryResponseFromJson(Map<String, dynamic> json) =>
    CategoryResponse(
      json['code'] as int,
      (json['msg'] as List<dynamic>)
          .map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoryResponseToJson(CategoryResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.categories,
    };

ChangeCategoryRequest _$ChangeCategoryRequestFromJson(
        Map<String, dynamic> json) =>
    ChangeCategoryRequest(
      json['name'] as String,
      json['newName'] as String,
      json['newParentName'] as String,
    );

Map<String, dynamic> _$ChangeCategoryRequestToJson(
        ChangeCategoryRequest instance) =>
    <String, dynamic>{
      'name': instance.oldName,
      'newName': instance.newName,
      'newParentName': instance.newParentNullable,
    };

RemoveCategoryRequest _$RemoveCategoryRequestFromJson(
        Map<String, dynamic> json) =>
    RemoveCategoryRequest(
      json['name'] as String,
    );

Map<String, dynamic> _$RemoveCategoryRequestToJson(
        RemoveCategoryRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
    };
