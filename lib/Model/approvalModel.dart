import 'package:json_annotation/json_annotation.dart';

part 'approvalModel.g.dart';

@JsonSerializable()
class ApprovalModel {
  @JsonKey(name: "_id")
  String? id;
  String? regno;
  String? status;
  String? eventid;
  String? eventname;
  String? facultyid;
  ApprovalModel({
    this.id,
    this.regno,
    this.status,
    this.eventid,
    this.eventname,
    this.facultyid
  });

  factory ApprovalModel.fromJson(Map<String, dynamic> json) => _$ApprovalModelFromJson(json);
  Map<String, dynamic> ToJson() => _$ApprovalModelToJson(this);

}
