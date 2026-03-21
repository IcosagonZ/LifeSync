// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mind_mood.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MindMoodData _$MindMoodDataFromJson(Map<String, dynamic> json) => MindMoodData(
  (json['id'] as num).toInt(),
  json['name'] as String,
  json['intensity'] as String,
  json['resolved'] as bool,
  json['end_date'] == null ? null : DateTime.parse(json['end_date'] as String),
  DateTime.parse(json['entry_date'] as String),
  json['entry_note'] as String,
);

Map<String, dynamic> _$MindMoodDataToJson(MindMoodData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'intensity': instance.intensity,
      'resolved': instance.resolved,
      'end_date': instance.end_date?.toIso8601String(),
      'entry_date': instance.entry_date.toIso8601String(),
      'entry_note': instance.entry_note,
    };
