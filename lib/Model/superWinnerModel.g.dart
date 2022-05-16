// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'superWinnerModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuperWinnerModel _$SuperWinnerModelFromJson(Map<String, dynamic> json) =>
    SuperWinnerModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => WinnerModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SuperWinnerModelToJson(SuperWinnerModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
