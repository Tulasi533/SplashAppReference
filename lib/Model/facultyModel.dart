
import 'package:json_annotation/json_annotation.dart';

part 'facultyModel.g.dart';

@JsonSerializable()
class FacultyModel {
  String? facultyid;
  String? name;
  String? preferredname;
  String? password;
  String? mobile;
  String? email;
  String? department;
  String? college;
  String? position;
  String? qualification;
  List<String>? myevents;
  List<String>? myparticipations;
  List<String>? myachievements;
  String? img;
  FacultyModel({
    this.facultyid,
    this.name,
    this.preferredname,
    this.password,
    this.mobile,
    this.email,
    this.department,
    this.college,
    this.position,
    this.qualification,
    this.myevents,
    this.myparticipations,
    this.myachievements,
    this.img
  });

  factory FacultyModel.fromJson(Map<String, dynamic> json) => _$FacultyModelFromJson(json);
  Map<String, dynamic> ToJson() => _$FacultyModelToJson(this);

}