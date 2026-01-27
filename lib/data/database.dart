import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import 'iconmapper.dart';

class TimelineData
{
  IconData item_icon;
  String item_title;
  String item_subtitle;
  String item_datatype;
  DateTime item_datetime;

  TimelineData(this.item_icon, this.item_title, this.item_subtitle, this.item_datatype, this.item_datetime);
}

// Dummy data
List<TimelineData> data_timeline_list = [
  TimelineData(iconmapper_geticon("Vitals", "Heartrate"), "Heartrate", "93 bpm", "Vitals", DateTime(2026, 5, 12, 12, 54)),
  TimelineData(iconmapper_geticon("Symptoms"), "Headache", "Moderate, unresolved", "Symptoms", DateTime(2026, 5, 12, 12, 54)),
  TimelineData(iconmapper_geticon("Activity", "Running"), "Running", "2km, 49min, 432 cal", "Activity", DateTime(2026, 5, 11, 8, 54)),
  TimelineData(iconmapper_geticon("Workout"), "Pushup", "34 reps", "Workout", DateTime(2026, 5, 11, 7, 54)),
  TimelineData(iconmapper_geticon("Nutrition"), "Brownies", "2 pieces, 342 calories", "Nutrition", DateTime(2026, 5, 11, 7, 34)),
  TimelineData(iconmapper_geticon("Body Measurements", "Weight"), "Weight", "60 kg", "Body Measurements", DateTime(2026, 5, 11, 8, 44)),
  TimelineData(iconmapper_geticon("Activity", "Cycling"), "Cycling", "2.5km, 26min, 332 cal", "Activity", DateTime(2026, 5, 11, 7, 4)),
  TimelineData(iconmapper_geticon("Mind"), "Stressed", "Moderate, resolved", "Mind", DateTime(2026, 5, 11, 7, 4)),
  TimelineData(iconmapper_geticon("Nutrition"), "Peppermint Tea", "200ml, 32 cal", "Nutrition", DateTime(2026, 5, 11, 7, 0)),
  TimelineData(iconmapper_geticon("Body Measurements", "Weight"), "Weight", "62 kg", "Body Measurements", DateTime(2026, 5, 11, 7, 1)),
  TimelineData(iconmapper_geticon("Workout"), "Pushup", "54 reps", "Workout", DateTime(2026, 5, 11, 7, 1)),
  TimelineData(iconmapper_geticon("Mind"), "Burnout", "Moderate, unresolved", "Mind", DateTime(2026, 5, 11, 7, 1)),
  TimelineData(iconmapper_geticon("Activity", "Football"), "Football", "95min, 724 cal", "Activity", DateTime(2026, 5, 10, 4, 54)),
  TimelineData(iconmapper_geticon("Vitals", "Blood Pressure"), "Blood Pressure", "113/74", "Vitals", DateTime(2026, 5, 10, 4, 34)),
  TimelineData(iconmapper_geticon("Body Measurements", "Height"), "Height", "170 cm", "Body Measurements", DateTime(2026, 5, 10, 4, 14)),
  TimelineData(iconmapper_geticon("Sleep"), "Sleep", "7 hr 45 min", "Time", DateTime(2026, 7, 10, 4, 14)),
  TimelineData(iconmapper_geticon("Symptoms"), "Fever", "Light, resolved", "Symptoms", DateTime(2026, 7, 10, 4, 14)),
];

// Data display for main timeline
List<TimelineData> get_timeline_data()
{
  print("Timeline data requested");
  return data_timeline_list;
}

// Data display for activity page
List<TimelineData> get_activity_data()
{
  print("Activity data requested");
  List<TimelineData> data_activity_list = [];

  for(var data in data_timeline_list)
  {
    if(data.item_datatype=="Activity")
    {
      data_activity_list.add(data);
    }
  }

  return data_activity_list;
}

// Data display for workout page
List<TimelineData> get_workout_data()
{
  print("Workout data requested");
  List<TimelineData> data_workout_list = [];

  for(var data in data_timeline_list)
  {
    if(data.item_datatype=="Workout")
    {
      data_workout_list.add(data);
    }
  }

  return data_workout_list;
}

// Data display for nutrition page
List<TimelineData> get_nutrition_data()
{
  print("Nutrition data requested");
  List<TimelineData> data_nutrition_list = [];

  for(var data in data_timeline_list)
  {
    if(data.item_datatype=="Nutrition")
    {
      data_nutrition_list.add(data);
    }
  }

  return data_nutrition_list;
}

// Data display for body measurements page
List<TimelineData> get_bodymeasurements_data()
{
  print("Body measurements data requested");
  List<TimelineData> data_bodymeasurements_list = [];

  for(var data in data_timeline_list)
  {
    if(data.item_datatype=="Body Measurements")
    {
      data_bodymeasurements_list.add(data);
    }
  }

  return data_bodymeasurements_list;
}

// Data display for symptoms page
List<TimelineData> get_symptoms_data()
{
  print("Symptoms data requested");
  List<TimelineData> data_symptoms_list = [];

  for(var data in data_timeline_list)
  {
    if(data.item_datatype=="Symptoms")
    {
      data_symptoms_list.add(data);
    }
  }

  return data_symptoms_list;
}

// Data display for symptoms page
List<TimelineData> get_mind_data()
{
  print("Mind data requested");
  List<TimelineData> data_mind_list = [];

  for(var data in data_timeline_list)
  {
    if(data.item_datatype=="Mind")
    {
      data_mind_list.add(data);
    }
  }

  return data_mind_list;
}

// Sleep data
List<TimelineData> get_sleep_data()
{
  print("Sleep data requested");
  List<TimelineData> data_sleep_list = [];

  List columns = ["Sleep"];

  for(var data in data_timeline_list)
  {
    if(columns.contains(data.item_title))
    {
      data_sleep_list.add(data);
    }
  }

  return data_sleep_list;
}
