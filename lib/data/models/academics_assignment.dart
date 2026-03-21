import 'package:json_annotation/json_annotation.dart';

part 'academics_assignment.g.dart';

@JsonSerializable()
class AcademicsAssignmentData
{
  int id;
  String subject;
  String type;
  String topic;
  int submitted;
  DateTime due_date;
  DateTime submission_date;
  DateTime entry_date;
  String entry_note;

  AcademicsAssignmentData(this.id, this.subject, this.type, this.topic, this.submitted, this.due_date, this.submission_date, this.entry_date, this.entry_note);

  factory AcademicsAssignmentData.fromJson(Map<String, dynamic> json) => _$AcademicsAssignmentDataFromJson(json);
  Map<String, dynamic> toJson() => _$AcademicsAssignmentDataToJson(this);
}
