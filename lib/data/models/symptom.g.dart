// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'symptom.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SymptomData _$SymptomDataFromJson(Map<String, dynamic> json) => SymptomData(
  (json['id'] as num).toInt(),
  json['name'] as String,
  (json['intensity'] as num).toInt(),
  (json['resolved'] as num).toInt(),
  json['end_date'] as String,
  DateTime.parse(json['entry_date'] as String),
  json['entry_note'] as String,
);

Map<String, dynamic> _$SymptomDataToJson(SymptomData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'intensity': instance.intensity,
      'resolved': instance.resolved,
      'end_date': instance.end_date,
      'entry_date': instance.entry_date.toIso8601String(),
      'entry_note': instance.entry_note,
    };
