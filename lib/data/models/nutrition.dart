import 'package:json_annotation/json_annotation.dart';

part 'nutrition.g.dart';

@JsonSerializable()
class NutritionData
{
  int id;
  String name;
  String form;
  String type;
  double qty;
  double calories;
  double mass;
  double carbs;
  double protein;
  double fats;
  DateTime entry_date;
  String entry_note;

  NutritionData(this.id, this.name, this.form, this.type, this.qty, this.calories, this.mass, this.carbs, this.protein, this.fats, this.entry_date, this.entry_note);

  factory NutritionData.fromJson(Map<String, dynamic> json) => _$NutritionDataFromJson(json);
  Map<String, dynamic> toJson() => _$NutritionDataToJson(this);
}
