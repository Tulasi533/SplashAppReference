// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'superFacultyModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuperFacultyModel _$SuperFacultyModelFromJson(Map<String, dynamic> json) =>
    SuperFacultyModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => FacultyModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SuperFacultyModelToJson(SuperFacultyModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
