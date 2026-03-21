// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vitals.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VitalsData _$VitalsDataFromJson(Map<String, dynamic> json) => VitalsData(
  (json['id'] as num).toInt(),
  json['type'] as String,
  json['value'] as String,
  json['unit'] as String,
  DateTime.parse(json['entry_date'] as String),
  json['entry_note'] as String,
);

Map<String, dynamic> _$VitalsDataToJson(VitalsData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'value': instance.value,
      'unit': instance.unit,
      'entry_date': instance.entry_date.toIso8601String(),
      'entry_note': instance.entry_note,
    };
