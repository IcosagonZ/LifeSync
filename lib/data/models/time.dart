import 'package:json_annotation/json_annotation.dart';

part 'time.g.dart';

@JsonSerializable()
class TimeData
{
  int id;
  String event;
  int duration;
  DateTime entry_date;
  String entry_note;

  TimeData(this.id, this.event, this.duration, this.entry_date, this.entry_note);

  factory TimeData.fromJson(Map<String, dynamic> json) => _$TimeDataFromJson(json);
  Map<String, dynamic> toJson() => _$TimeDataToJson(this);
}
