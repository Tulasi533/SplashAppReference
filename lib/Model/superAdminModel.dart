import 'package:splash_app/Model/adminModel.dart';
import 'package:splash_app/Model/eventModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'superAdminModel.g.dart';

@JsonSerializable()
class SuperAdminModel {
  List<AdminModel>? data;
  SuperAdminModel({this.data});
  factory SuperAdminModel.fromJson(Map<String, dynamic> json) =>
      _$SuperAdminModelFromJson(json);
  Map<String, dynamic> toJson() => _$SuperAdminModelToJson(this);
}