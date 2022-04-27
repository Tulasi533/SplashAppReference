// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'adminModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminModel _$AdminModelFromJson(Map<String, dynamic> json) => AdminModel(
      adminid: json['adminid'] as String?,
      name: json['name'] as String?,
      password: json['password'] as String?,
      mobile: json['mobile'] as String?,
      email: json['email'] as String?,
      college: json['college'] as String?,
      img: json['img'] as String?,
    );

Map<String, dynamic> _$AdminModelToJson(AdminModel instance) =>
    <String, dynamic>{
      'adminid': instance.adminid,
      'name': instance.name,
      'password': instance.password,
      'mobile': instance.mobile,
      'email': instance.email,
      'college': instance.college,
      'img': instance.img,
    };
