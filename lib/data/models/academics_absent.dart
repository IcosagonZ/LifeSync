import 'package:json_annotation/json_annotation.dart';

part 'academics_absent.g.dart';

@JsonSerializable()
class AcademicsAbsentData
{
  String reason;
  DateTime absent_date;
  DateTime entry_date;
  String entry_note;

  AcademicsAbsentData(this.reason, this.absent_date, this.entry_date, this.entry_note);

  factory AcademicsAbsentData.fromJson(Map<String, dynamic> json) => _$AcademicsAbsentDataFromJson(json);
  Map<String, dynamic> toJson() => _$AcademicsAbsentDataToJson(this);
}
