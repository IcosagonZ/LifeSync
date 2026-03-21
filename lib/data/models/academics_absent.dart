import 'package:json_annotation/json_annotation.dart';

part 'academics_absent.g.dart';

@JsonSerializable()
class AcademicsAbsentData
{
  int id;
  String reason;
  DateTime absent_date;
  DateTime entry_date;
  String entry_note;

  AcademicsAbsentData(this.id, this.reason, this.absent_date, this.entry_date, this.entry_note);

  factory AcademicsAbsentData.fromJson(Map<String, dynamic> json) => _$AcademicsAbsentDataFromJson(json);
  Map<String, dynamic> toJson() => _$AcademicsAbsentDataToJson(this);
}
