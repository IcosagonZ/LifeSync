import 'package:json_annotation/json_annotation.dart';

part 'note.g.dart';

@JsonSerializable()
class NoteData
{
  int id;
  String title;
  String content;
  String tags;
  DateTime entry_date;

  NoteData(this.id, this.title, this.content, this.tags, this.entry_date);

  factory NoteData.fromJson(Map<String, dynamic> json) => _$NoteDataFromJson(json);
  Map<String, dynamic> toJson() => _$NoteDataToJson(this);
}
