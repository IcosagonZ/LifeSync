import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class TimelineData
{
  IconData item_icon;
  String item_title;
  String item_subtitle;
  DateTime item_datetime;

  TimelineData(this.item_icon, this.item_title, this.item_subtitle, this.item_datetime);
}

// Dummy data
List<TimelineData> data_timeline_list = [
  TimelineData(Symbols.ecg_heart, "Heartrate", "93 bpm", DateTime(2026, 5, 12, 12, 54)),
  TimelineData(Symbols.directions_run, "Running", "2km, 49min, 432 cal", DateTime(2026, 5, 11, 8, 54)),
  TimelineData(Symbols.weight, "Weight", "60 kg", DateTime(2026, 5, 11, 8, 44)),
  TimelineData(Symbols.directions_bike, "Cycling", "2.5km, 26min, 332 cal", DateTime(2026, 5, 11, 7, 4)),
  TimelineData(Symbols.weight, "Weight", "62 kg", DateTime(2026, 5, 11, 7, 1)),
  TimelineData(Symbols.sports_soccer, "Football", "95min, 724 cal", DateTime(2026, 5, 10, 4, 54)),
  TimelineData(Symbols.blood_pressure, "Blood pressure", "113/74", DateTime(2026, 5, 10, 4, 34)),
  TimelineData(Symbols.height, "Height", "170 cm", DateTime(2026, 5, 10, 4, 14)),
];

// Data display for main timeline
List<TimelineData> get_timeline_data()
{
  print("Timeline data requested");
  return data_timeline_list;
}

// Data display for body measurements page
List<TimelineData> get_bodymeasurements_data()
{
  print("Body measurements data requested");
  List<TimelineData> data_bodymeasurements_list = [];

  List columns = ["Weight", "Height"];

  for(var data in data_timeline_list)
  {
    if(columns.contains(data.item_title))
    {
      data_bodymeasurements_list.add(data);
    }
  }

  return data_bodymeasurements_list;
}
