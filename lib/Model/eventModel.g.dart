// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eventModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventModel _$EventModelFromJson(Map<String, dynamic> json) => EventModel(
      name: json['name'] as String?,
      id: json['_id'] as String?,
      facultyid: json['facultyid'] as String?,
      eligibility: json['eligibility'] as String?,
      regstartdate: json['regstartdate'] as String?,
      regenddate: json['regenddate'] as String?,
      eventstartdate: json['eventstartdate'] as String?,
      eventenddate: json['eventenddate'] as String?,
      venue: json['venue'] as String?,
      discription: json['discription'] as String?,
      scope: json['scope'] as String?,
      winnercriteria: json['winnercriteria'] as String?,
      organizer: json['organizer'] as String?,
    );

Map<String, dynamic> _$EventModelToJson(EventModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      '_id': instance.id,
      'facultyid': instance.facultyid,
      'eligibility': instance.eligibility,
      'regstartdate': instance.regstartdate,
      'regenddate': instance.regenddate,
      'eventstartdate': instance.eventstartdate,
      'eventenddate': instance.eventenddate,
      'venue': instance.venue,
      'discription': instance.discription,
      'scope': instance.scope,
      'organizer': instance.organizer,
      'winnercriteria': instance.winnercriteria,
    };
