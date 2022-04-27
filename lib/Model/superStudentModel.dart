import 'package:splash_app/Model/adminModel.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:splash_app/Model/studentModel.dart';

part 'superStudentModel.g.dart';

@JsonSerializable()
class SuperStudentModel {
  List<StudentModel>? data;
  SuperStudentModel({this.data});
  factory SuperStudentModel.fromJson(Map<String, dynamic> json) =>
      _$SuperStudentModelFromJson(json);
  Map<String, dynamic> toJson() => _$SuperStudentModelToJson(this);
}