// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'superApprovalModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuperApprovalModel _$SuperApprovalModelFromJson(Map<String, dynamic> json) =>
    SuperApprovalModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ApprovalModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SuperApprovalModelToJson(SuperApprovalModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
