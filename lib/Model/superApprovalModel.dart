import 'package:json_annotation/json_annotation.dart';
import 'package:splash_app/Model/approvalModel.dart';

part 'superApprovalModel.g.dart';

@JsonSerializable()
class SuperApprovalModel {
  List<ApprovalModel>? data;
  SuperApprovalModel({this.data});
  factory SuperApprovalModel.fromJson(Map<String, dynamic> json) =>
      _$SuperApprovalModelFromJson(json);
  Map<String, dynamic> toJson() => _$SuperApprovalModelToJson(this);
}