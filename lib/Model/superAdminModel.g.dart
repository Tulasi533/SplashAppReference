// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'superAdminModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuperAdminModel _$SuperAdminModelFromJson(Map<String, dynamic> json) =>
    SuperAdminModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => AdminModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SuperAdminModelToJson(SuperAdminModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
