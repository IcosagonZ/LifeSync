// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'academics_mark.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AcademicsMarkData _$AcademicsMarkDataFromJson(Map<String, dynamic> json) =>
    AcademicsMarkData(
      json['subject'] as String,
      json['type'] as String,
      (json['marks'] as num).toDouble(),
      (json['marks_total'] as num).toDouble(),
      DateTime.parse(json['entry_date'] as String),
      json['entry_note'] as String,
    );

Map<String, dynamic> _$AcademicsMarkDataToJson(AcademicsMarkData instance) =>
    <String, dynamic>{
      'subject': instance.subject,
      'type': instance.type,
      'marks': instance.marks,
      'marks_total': instance.marks_total,
      'entry_date': instance.entry_date.toIso8601String(),
      'entry_note': instance.entry_note,
    };
