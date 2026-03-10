import 'package:json_annotation/json_annotation.dart';

part 'activity.g.dart';

@JsonSerializable()
class ActivityData{
  String name;
  int duration;
  int distance;
  double calories;
  DateTime entry_date;
  String entry_note;

  ActivityData(this.name, this.duration, this.distance, this.calories, this.entry_date, this.entry_note);

  factory ActivityData.fromJson(Map<String, dynamic> json) => _$ActivityDataFromJson(json);
  Map<String, dynamic> toJson() => _$ActivityDataToJson(this);
}
