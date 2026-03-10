// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'academics_absent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AcademicsAbsentData _$AcademicsAbsentDataFromJson(Map<String, dynamic> json) =>
    AcademicsAbsentData(
      json['reason'] as String,
      DateTime.parse(json['absent_date'] as String),
      DateTime.parse(json['entry_date'] as String),
      json['entry_note'] as String,
    );

Map<String, dynamic> _$AcademicsAbsentDataToJson(
  AcademicsAbsentData instance,
) => <String, dynamic>{
  'reason': instance.reason,
  'absent_date': instance.absent_date.toIso8601String(),
  'entry_date': instance.entry_date.toIso8601String(),
  'entry_note': instance.entry_note,
};
