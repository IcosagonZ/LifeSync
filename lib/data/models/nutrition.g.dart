// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nutrition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NutritionData _$NutritionDataFromJson(Map<String, dynamic> json) =>
    NutritionData(
      json['name'] as String,
      json['form'] as String,
      json['type'] as String,
      (json['qty'] as num).toDouble(),
      (json['calories'] as num).toDouble(),
      (json['mass'] as num).toDouble(),
      (json['carbs'] as num).toDouble(),
      (json['protein'] as num).toDouble(),
      (json['fats'] as num).toDouble(),
      DateTime.parse(json['entry_date'] as String),
      json['entry_note'] as String,
    );

Map<String, dynamic> _$NutritionDataToJson(NutritionData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'form': instance.form,
      'type': instance.type,
      'qty': instance.qty,
      'calories': instance.calories,
      'mass': instance.mass,
      'carbs': instance.carbs,
      'protein': instance.protein,
      'fats': instance.fats,
      'entry_date': instance.entry_date.toIso8601String(),
      'entry_note': instance.entry_note,
    };
