import 'package:json_annotation/json_annotation.dart';

part 'mind_mood.g.dart';

@JsonSerializable()
class MindMoodData
{
  String name;
  String intensity;
  bool resolved;
  DateTime? end_date;
  DateTime entry_date;
  String entry_note;

  MindMoodData(this.name, this.intensity, this.resolved, this.end_date, this.entry_date, this.entry_note);

  factory MindMoodData.fromJson(Map<String, dynamic> json) => _$MindMoodDataFromJson(json);
  Map<String, dynamic> toJson() => _$MindMoodDataToJson(this);
}
