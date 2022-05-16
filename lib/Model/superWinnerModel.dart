import 'package:json_annotation/json_annotation.dart';
import 'package:splash_app/Model/winnerModel.dart';

part 'superWinnerModel.g.dart';

@JsonSerializable()
class SuperWinnerModel {
  List<WinnerModel>? data;
  SuperWinnerModel({this.data});
  factory SuperWinnerModel.fromJson(Map<String, dynamic> json) =>
      _$SuperWinnerModelFromJson(json);
  Map<String, dynamic> toJson() => _$SuperWinnerModelToJson(this);
}