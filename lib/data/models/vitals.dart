import 'package:json_annotation/json_annotation.dart';

part 'vitals.g.dart';

@JsonSerializable()
class VitalsData{
  String type;
  String value;
  String unit;
  DateTime entry_date;
  String entry_note;

  VitalsData(this.type, this.value, this.unit, this.entry_date, this.entry_note);

  factory VitalsData.fromJson(Map<String, dynamic> json) => _$VitalsDataFromJson(json);
  Map<String, dynamic> toJson() => _$VitalsDataToJson(this);
}
