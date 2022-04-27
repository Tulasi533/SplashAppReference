import 'package:splash_app/Model/adminModel.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:splash_app/Model/facultyModel.dart';

part 'superFacultyModel.g.dart';

@JsonSerializable()
class SuperFacultyModel {
  List<FacultyModel>? data;
  SuperFacultyModel({this.data});
  factory SuperFacultyModel.fromJson(Map<String, dynamic> json) =>
      _$SuperFacultyModelFromJson(json);
  Map<String, dynamic> toJson() => _$SuperFacultyModelToJson(this);
}