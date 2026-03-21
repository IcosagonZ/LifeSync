// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityData _$ActivityDataFromJson(Map<String, dynamic> json) => ActivityData(
  (json['id'] as num).toInt(),
  json['name'] as String,
  (json['duration'] as num).toInt(),
  (json['distance'] as num).toInt(),
  (json['calories'] as num).toDouble(),
  DateTime.parse(json['entry_date'] as String),
  json['entry_note'] as String,
);

Map<String, dynamic> _$ActivityDataToJson(ActivityData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'duration': instance.duration,
      'distance': instance.distance,
      'calories': instance.calories,
      'entry_date': instance.entry_date.toIso8601String(),
      'entry_note': instance.entry_note,
    };
