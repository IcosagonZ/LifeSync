import 'package:json_annotation/json_annotation.dart';

part 'academics_exam.g.dart';

@JsonSerializable()
class AcademicsExamData
{
  String subject;
  String exam_type;
  DateTime exam_date;
  int duration;
  DateTime entry_date;
  String entry_note;

  AcademicsExamData(this.subject, this.exam_type, this.exam_date, this.duration, this.entry_date, this.entry_note);

  factory AcademicsExamData.fromJson(Map<String, dynamic> json) => _$AcademicsExamDataFromJson(json);
  Map<String, dynamic> toJson() => _$AcademicsExamDataToJson(this);
}
