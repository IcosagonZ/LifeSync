// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'body_measurement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BodyMeasurementData _$BodyMeasurementDataFromJson(Map<String, dynamic> json) =>
    BodyMeasurementData(
      (json['id'] as num).toInt(),
      json['measurement_type'] as String,
      (json['value'] as num).toDouble(),
      json['unit'] as String,
      DateTime.parse(json['entry_date'] as String),
      json['entry_note'] as String,
    );

Map<String, dynamic> _$BodyMeasurementDataToJson(
  BodyMeasurementData instance,
) => <String, dynamic>{
  'id': instance.id,
  'measurement_type': instance.measurement_type,
  'value': instance.value,
  'unit': instance.unit,
  'entry_date': instance.entry_date.toIso8601String(),
  'entry_note': instance.entry_note,
};
