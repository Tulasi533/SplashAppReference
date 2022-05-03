// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'facultyModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FacultyModel _$FacultyModelFromJson(Map<String, dynamic> json) => FacultyModel(
      facultyid: json['facultyid'] as String?,
      name: json['name'] as String?,
      preferredname: json['preferredname'] as String?,
      password: json['password'] as String?,
      mobile: json['mobile'] as String?,
      email: json['email'] as String?,
      department: json['department'] as String?,
      college: json['college'] as String?,
      position: json['position'] as String?,
      qualification: json['qualification'] as String?,
      myevents: (json['myevents'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      myparticipations: (json['myparticipations'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      myachievements: (json['myachievements'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      mystudents: (json['mystudents'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      img: json['img'] as String?,
    );

Map<String, dynamic> _$FacultyModelToJson(FacultyModel instance) =>
    <String, dynamic>{
      'facultyid': instance.facultyid,
      'name': instance.name,
      'preferredname': instance.preferredname,
      'password': instance.password,
      'mobile': instance.mobile,
      'email': instance.email,
      'department': instance.department,
      'college': instance.college,
      'position': instance.position,
      'qualification': instance.qualification,
      'myevents': instance.myevents,
      'myparticipations': instance.myparticipations,
      'myachievements': instance.myachievements,
      'mystudents': instance.mystudents,
      'img': instance.img,
    };
