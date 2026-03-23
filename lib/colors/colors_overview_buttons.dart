import 'package:flutter/material.dart';

class ColorsOverviewButtons extends ThemeExtension<ColorsOverviewButtons>
{
  final Color time;
  final Color sleep;
  final Color academics;
  final Color workout;
  final Color activity;
  final Color nutrition;
  final Color mind;
  final Color symptoms;
  final Color vitals;
  final Color body;

  const ColorsOverviewButtons({
    required this.time,
    required this.sleep,
    required this.academics,
    required this.workout,
    required this.activity,
    required this.nutrition,
    required this.mind,
    required this.symptoms,
    required this.vitals,
    required this.body,
  });

  @override
  ThemeExtension<ColorsOverviewButtons> copyWith() => this;

  @override
  ThemeExtension<ColorsOverviewButtons> lerp(ThemeExtension<ColorsOverviewButtons>? other,  double t)
  {
    if(other is! ColorsOverviewButtons) return this;
    return ColorsOverviewButtons(
      time: Color.lerp(time, other.time, t)!,
      sleep: Color.lerp(sleep, other.sleep, t)!,
      academics: Color.lerp(academics, other.academics, t)!,
      workout: Color.lerp(workout, other.workout, t)!,
      activity: Color.lerp(activity, other.activity, t)!,
      nutrition: Color.lerp(nutrition, other.nutrition, t)!,
      mind: Color.lerp(mind, other.mind, t)!,
      symptoms: Color.lerp(symptoms, other.symptoms, t)!,
      vitals: Color.lerp(vitals, other.vitals, t)!,
      body: Color.lerp(body, other.body, t)!,
    );
  }
}
