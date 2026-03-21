// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'academics_exam.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AcademicsExamData _$AcademicsExamDataFromJson(Map<String, dynamic> json) =>
    AcademicsExamData(
      (json['id'] as num).toInt(),
      json['subject'] as String,
      json['exam_type'] as String,
      DateTime.parse(json['exam_date'] as String),
      (json['duration'] as num).toInt(),
      DateTime.parse(json['entry_date'] as String),
      json['entry_note'] as String,
    );

Map<String, dynamic> _$AcademicsExamDataToJson(AcademicsExamData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'subject': instance.subject,
      'exam_type': instance.exam_type,
      'exam_date': instance.exam_date.toIso8601String(),
      'duration': instance.duration,
      'entry_date': instance.entry_date.toIso8601String(),
      'entry_note': instance.entry_note,
    };
