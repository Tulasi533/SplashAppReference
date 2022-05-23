// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approvalModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApprovalModel _$ApprovalModelFromJson(Map<String, dynamic> json) =>
    ApprovalModel(
      id: json['_id'] as String?,
      regno: json['regno'] as String?,
      status: json['status'] as String?,
      eventid: json['eventid'] as String?,
      eventname: json['eventname'] as String?,
      facultyid: json['facultyid'] as String?,
    );

Map<String, dynamic> _$ApprovalModelToJson(ApprovalModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'regno': instance.regno,
      'status': instance.status,
      'eventid': instance.eventid,
      'eventname': instance.eventname,
      'facultyid': instance.facultyid,
    };
