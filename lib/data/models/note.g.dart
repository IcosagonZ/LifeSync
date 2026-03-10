// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoteData _$NoteDataFromJson(Map<String, dynamic> json) => NoteData(
  json['title'] as String,
  json['content'] as String,
  json['tags'] as String,
  DateTime.parse(json['entry_date'] as String),
);

Map<String, dynamic> _$NoteDataToJson(NoteData instance) => <String, dynamic>{
  'title': instance.title,
  'content': instance.content,
  'tags': instance.tags,
  'entry_date': instance.entry_date.toIso8601String(),
};
