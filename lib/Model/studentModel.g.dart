// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'studentModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentModel _$StudentModelFromJson(Map<String, dynamic> json) => StudentModel(
      regno: json['regno'] as String?,
      name: json['name'] as String?,
      preferredname: json['preferredname'] as String?,
      password: json['password'] as String?,
      mobile: json['mobile'] as String?,
      email: json['email'] as String?,
      about: json['about'] as String?,
      branch: json['branch'] as String?,
      college: json['college'] as String?,
      academicstart: json['academicstart'] as String?,
      academicend: json['academicend'] as String?,
      facultyid: json['facultyid'] as String?,
      img: json['img'] as String?,
    );

Map<String, dynamic> _$StudentModelToJson(StudentModel instance) =>
    <String, dynamic>{
      'regno': instance.regno,
      'name': instance.name,
      'preferredname': instance.preferredname,
      'password': instance.password,
      'mobile': instance.mobile,
      'email': instance.email,
      'about': instance.about,
      'branch': instance.branch,
      'college': instance.college,
      'academicstart': instance.academicstart,
      'academicend': instance.academicend,
      'facultyid': instance.facultyid,
      'img': instance.img,
    };
