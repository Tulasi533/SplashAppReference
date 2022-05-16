import 'package:json_annotation/json_annotation.dart';

part 'winnerModel.g.dart';

@JsonSerializable()
class WinnerModel {
  String? userid;
  String? place;
  String? eventid;
  WinnerModel({
    this.userid,
    this.place,
    this.eventid
  });

  factory WinnerModel.fromJson(Map<String, dynamic> json) => _$WinnerModelFromJson(json);
  Map<String, dynamic> ToJson() => _$WinnerModelToJson(this);

}
