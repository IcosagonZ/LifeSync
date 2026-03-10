import 'package:json_annotation/json_annotation.dart';

part 'symptom.g.dart';

@JsonSerializable()
class SymptomData{
  String name;
  int intensity;
  int resolved;
  String end_date;
  DateTime entry_date;
  String entry_note;

  SymptomData(this.name, this.intensity, this.resolved, this.end_date, this.entry_date, this.entry_note);

  factory SymptomData.fromJson(Map<String, dynamic> json) => _$SymptomDataFromJson(json);
  Map<String, dynamic> toJson() => _$SymptomDataToJson(this);
}
