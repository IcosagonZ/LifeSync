// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeData _$TimeDataFromJson(Map<String, dynamic> json) => TimeData(
  json['event'] as String,
  (json['duration'] as num).toInt(),
  DateTime.parse(json['entry_date'] as String),
  json['entry_note'] as String,
);

Map<String, dynamic> _$TimeDataToJson(TimeData instance) => <String, dynamic>{
  'event': instance.event,
  'duration': instance.duration,
  'entry_date': instance.entry_date.toIso8601String(),
  'entry_note': instance.entry_note,
};
