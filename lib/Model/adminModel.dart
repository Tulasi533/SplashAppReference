import 'package:json_annotation/json_annotation.dart';

part 'adminModel.g.dart';

@JsonSerializable()
class AdminModel {
  String? adminid;
  String? name;
  String? password;
  String? mobile;
  String? email;
  String? college;
  String? img;
  AdminModel({
    this.adminid,
    this.name,
    this.password,
    this.mobile,
    this.email,
    this.college,
    this.img
  });

  factory AdminModel.fromJson(Map<String, dynamic> json) => _$AdminModelFromJson(json);
  Map<String, dynamic> ToJson() => _$AdminModelToJson(this);

}