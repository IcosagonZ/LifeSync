import 'package:json_annotation/json_annotation.dart';

part 'academics_mark.g.dart';

@JsonSerializable()
class AcademicsMarkData
{
  int id;
  String subject;
  String type;
  double marks;
  double marks_total;
  DateTime entry_date;
  String entry_note;

  AcademicsMarkData(this.id, this.subject, this.type, this.marks, this.marks_total, this.entry_date, this.entry_note);

  factory AcademicsMarkData.fromJson(Map<String, dynamic> json) => _$AcademicsMarkDataFromJson(json);
  Map<String, dynamic> toJson() => _$AcademicsMarkDataToJson(this);
}
