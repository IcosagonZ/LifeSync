import 'package:json_annotation/json_annotation.dart';

part 'workout.g.dart';

@JsonSerializable()
class WorkoutData{
  String name;
  String type;
  int duration;
  double calories;
  int reps;
  double weight;
  DateTime entry_date;
  String entry_note;

  WorkoutData(this.name, this.type, this.duration, this.calories, this.reps, this.weight, this.entry_date, this.entry_note);

  factory WorkoutData.fromJson(Map<String, dynamic> json) => _$WorkoutDataFromJson(json);
  Map<String, dynamic> toJson() => _$WorkoutDataToJson(this);
}
