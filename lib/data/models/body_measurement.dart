import 'package:json_annotation/json_annotation.dart';

part 'body_measurement.g.dart';

@JsonSerializable()
class BodyMeasurementData
{
  int id;
  String measurement_type;
  double value;
  String unit;
  DateTime entry_date;
  String entry_note;

  BodyMeasurementData(this.id, this.measurement_type, this.value, this.unit, this.entry_date, this.entry_note);

  factory BodyMeasurementData.fromJson(Map<String, dynamic> json) => _$BodyMeasurementDataFromJson(json);
  Map<String, dynamic> toJson() => _$BodyMeasurementDataToJson(this);
}
