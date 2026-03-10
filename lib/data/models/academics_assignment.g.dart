// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'academics_assignment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AcademicsAssignmentData _$AcademicsAssignmentDataFromJson(
  Map<String, dynamic> json,
) => AcademicsAssignmentData(
  json['subject'] as String,
  json['type'] as String,
  json['topic'] as String,
  (json['submitted'] as num).toInt(),
  DateTime.parse(json['due_date'] as String),
  DateTime.parse(json['submission_date'] as String),
  DateTime.parse(json['entry_date'] as String),
  json['entry_note'] as String,
);

Map<String, dynamic> _$AcademicsAssignmentDataToJson(
  AcademicsAssignmentData instance,
) => <String, dynamic>{
  'subject': instance.subject,
  'type': instance.type,
  'topic': instance.topic,
  'submitted': instance.submitted,
  'due_date': instance.due_date.toIso8601String(),
  'submission_date': instance.submission_date.toIso8601String(),
  'entry_date': instance.entry_date.toIso8601String(),
  'entry_note': instance.entry_note,
};
