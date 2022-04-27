// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'superStudentModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuperStudentModel _$SuperStudentModelFromJson(Map<String, dynamic> json) =>
    SuperStudentModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => StudentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SuperStudentModelToJson(SuperStudentModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
