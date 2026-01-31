// Program to map icons to each datatype or item
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

final Map<String, IconData> bodymeasurements_mapping = {
  "Weight":Symbols.weight,
  "Height":Symbols.height,
};

final Map<String, IconData> vitals_mapping = {
  "Heartrate":Symbols.ecg_heart,
  "Blood Pressure":Symbols.blood_pressure,
  "Body Temperature":Symbols.thermometer,
  "Blood Oxygen":Symbols.spo2,
  "Blood Sugar":Symbols.glucose,
};

final Map<String, IconData> activity_mapping = {
  "Badminton":Symbols.badminton,
  "Baseball":Symbols.sports_baseball,
  "Basketball":Symbols.sports_basketball,
  "Cricket":Symbols.sports_cricket,
  "Cycling":Symbols.directions_bike,
  "Downhill Skiing":Symbols.downhill_skiing,
  "Electric Bike":Symbols.electric_bike,
  "Football":Symbols.sports_soccer,
  "Golf":Symbols.golf_course,
  "Handball":Symbols.sports_handball,
  "Hiking":Symbols.hiking,
  "Hockey":Symbols.sports_hockey,
  "Ice Skating":Symbols.ice_skating,
  "Kabbadi":Symbols.sports_kabaddi,
  "Kayaking":Symbols.kayaking,
  "Kite Surfing":Symbols.kitesurfing,
  "Martial Arts":Symbols.sports_martial_arts,
  "Mixed Martial Arts":Symbols.sports_mma,
  "Motorsports":Symbols.sports_motorsports,
  "Pickleball":Symbols.pickleball,
  "Pool":Symbols.pool,
  "Roller Skating":Symbols.roller_skating,
  "Rugby":Symbols.sports_rugby,
  "Running":Symbols.directions_run,
  "Sailing":Symbols.sailing,
  "Skateboarding":Symbols.skateboarding,
  "Sprint":Symbols.sprint,
  "Surfing":Symbols.surfing,
  "Volleyball":Symbols.sports_volleyball,
  "Custom":Symbols.sports
};

IconData iconmapper_geticon(String section, [String item = "None"])
{
  if(section=="Academics Exam")
  {
    return Symbols.quiz;
  }

  if(section=="Academics Assignment")
  {
    return Symbols.assignment;
  }

  if(section=="Academics Mark")
  {
    return Symbols.leaderboard;
  }

  if(section=="Academics Absent")
  {
    return Symbols.location_away;
  }

  if(section=="Activity")
  {
    if(activity_mapping.containsKey(item)){
      return activity_mapping[item] ?? Symbols.sports;
    }
    else
    {
      return Symbols.sports;
    }
  }

  if(section=="Body Measurements")
  {
    if(bodymeasurements_mapping.containsKey(item)){
      return bodymeasurements_mapping[item] ?? Symbols.user_attributes;
    }
    else
    {
      return Symbols.user_attributes;
    }
  }

  if(section=="Mind")
  {
    return Symbols.cognition_2;
  }

  if(section=="Nutrition")
  {
    return Symbols.fastfood;
  }

  if(section=="Sleep")
  {
    return Symbols.bedtime;
  }

  if(section=="Symptoms")
  {
    return Symbols.sick;
  }

  if(section=="Time")
  {
    return Symbols.schedule;
  }

  if(section=="Vitals")
  {
    if(vitals_mapping.containsKey(item)){
      return vitals_mapping[item] ?? Symbols.ecg_heart;
    }
    else
    {
      return Symbols.ecg_heart;
    }
  }

  if(section=="Workout")
  {
    return Symbols.exercise;
  }

  return Symbols.question_mark;
}
