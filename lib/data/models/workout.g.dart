// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkoutData _$WorkoutDataFromJson(Map<String, dynamic> json) => WorkoutData(
  (json['id'] as num).toInt(),
  json['name'] as String,
  json['type'] as String,
  (json['duration'] as num).toInt(),
  (json['calories'] as num).toDouble(),
  (json['reps'] as num).toInt(),
  (json['weight'] as num).toDouble(),
  DateTime.parse(json['entry_date'] as String),
  json['entry_note'] as String,
);

Map<String, dynamic> _$WorkoutDataToJson(WorkoutData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'duration': instance.duration,
      'calories': instance.calories,
      'reps': instance.reps,
      'weight': instance.weight,
      'entry_date': instance.entry_date.toIso8601String(),
      'entry_note': instance.entry_note,
    };
