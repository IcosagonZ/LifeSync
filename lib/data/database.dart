import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';
//import 'package:material_symbols_icons/material_symbols_icons.dart';

import 'iconmapper.dart';

List<String> database_sql_commands = ['create table if not exists academics_absent (reason text, absent_date text, entry_date text, entry_note text);', 'create table if not exists academics_assignment (subject text, type text, topic text, submitted integer, due_date text, submission_date text, entry_date text, entry_note text);', 'create table if not exists academics_exam (subject text, type text, exam_date text, duration integer, entry_date text, entry_note text);', 'create table if not exists academics_mark (subject text, type text, marks real, marks_total real, entry_date text, entry_note text);', 'create table if not exists activity (name text, duration integer, distance integer, calories real, entry_date text, entry_note text);', 'create table if not exists body_measurement (type text, value real, unit text, entry_date text, entry_note text);', 'create table if not exists mind_mood (name text, intensity text, resolved integer, end_date text, entry_date text, entry_note text);', 'create table if not exists note (title text, content text, tags text, entry_date text);', 'create table if not exists nutrition (name text, form text, type text, qty real, calories real, mass real, carbs real, protein real, fats real, entry_date text, entry_note text);', 'create table if not exists symptom (name text, intensity integer, resolved integer, end_date text, entry_date text, entry_note text);', 'create table if not exists time (event text, duration integer, entry_date text, entry_note text);', 'create table if not exists vitals (type text, value text, unit text, entry_date text, entry_note text);', 'create table if not exists workout (name text, type text, duration integer, calories real, reps integer, weight real, entry_date text, entry_note text);'];

Future<String> database_path() async
{
  var database_storage_path = await getDatabasesPath();
  String database_data_path =  join(database_storage_path, "lifesync.db");

  return database_data_path;
}

Future<Database> database_open() async
{
  Database database_db = await openDatabase(
    await database_path(),
    version: 1,
    onCreate: (Database db, int version) async
    {
      for(var sql_command in database_sql_commands)
      {
        await db.execute(sql_command);
      }
    },
    onOpen: (Database db) async
    {
      for(var sql_command in database_sql_commands)
      {
        await db.execute(sql_command);
      }
    },
  );
  return database_db;
}

Future<void> database_delete() async
{
  await deleteDatabase(await database_path());
}

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

// Academics
// Academics Absent
class AcademicsAbsentData
{
  String reason;
  DateTime absent_date;
  DateTime entry_date;
  String entry_note;

  AcademicsAbsentData(this.reason, this.absent_date, this.entry_date, this.entry_note);
}

Future<List<AcademicsAbsentData>> database_get_academics_absent() async
{
  Database database_db = await database_open();

  final List<Map<String, dynamic>> data_academics_absent_map = await database_db.query('academics_absent', columns: ['reason', 'absent_date', 'entry_date', 'entry_note']);

  List<AcademicsAbsentData> data_academics_absent_list = [];

  for(var data in data_academics_absent_map)
  {
    data_academics_absent_list.add(
      AcademicsAbsentData(
        data["reason"],
        DateTime.parse(data["absent_date"]),
        DateTime.parse(data["entry_date"]),
        data["entry_note"]
      )
    );
  }

  return data_academics_absent_list;
}

Future<int> database_insert_academics_absent(
  String reason,
  String absent_date,
  String entry_date,
  String entry_note,
) async
{
  Database database_db = await database_open();

  int row_index = await database_db.insert(
    "academics_absent",
    {
      'reason':reason,
      'absent_date':absent_date,
      'entry_date':entry_date,
      'entry_note':entry_note,
    }
  );
  print("Row index: ${row_index}");
  return row_index;
}

// Academics Assignment
class AcademicsAssignmentData
{
  String subject;
  String type;
  String topic;
  int submitted;
  DateTime due_date;
  DateTime submission_date;
  DateTime entry_date;
  String entry_note;

  AcademicsAssignmentData(this.subject, this.type, this.topic, this.submitted, this.due_date, this.submission_date, this.entry_date, this.entry_note);
}


Future<List<AcademicsAssignmentData>> database_get_academics_assignment() async
{
  Database database_db = await database_open();

  final List<Map<String, dynamic>> data_academics_assignment_map = await database_db.query('academics_assignment', columns: ['subject', 'type', 'topic', 'submitted', 'due_date', 'submission_date', 'entry_date', 'entry_note']);

  List<AcademicsAssignmentData> data_academics_assignment_list = [];

  for(var data in data_academics_assignment_map)
  {
    data_academics_assignment_list.add(
      AcademicsAssignmentData(
        data["subject"],
        data["type"],
        data["topic"],
        data["submitted"],
        DateTime.parse(data["due_date"]),
        DateTime.parse(data["submission_date"]),
        DateTime.parse(data["entry_date"]),
        data["entry_note"],
      )
    );
  }

  return data_academics_assignment_list;
}

Future<int> database_insert_academics_assignment(
  String subject,
  String type,
  String topic,
  int submitted,
  String due_date,
  String submission_date,
  String entry_date,
  String entry_note,
) async
{
  Database database_db = await database_open();

  int row_index = await database_db.insert(
    "academics_assignment",
    {
      'subject':subject,
      'type':type,
      'topic':topic,
      'submitted':submitted,
      'due_date':due_date,
      'submission_date':submission_date,
      'entry_date':entry_date,
      'entry_note':entry_note,
    }
  );
  print("Row index: ${row_index}");
  return row_index;
}


// Academics Exam
class AcademicsExamData
{
  String subject;
  String exam_type;
  DateTime exam_date;
  int duration;
  DateTime entry_date;
  String entry_note;

  AcademicsExamData(this.subject, this.exam_type, this.exam_date, this.duration, this.entry_date, this.entry_note);
}

Future<List<AcademicsExamData>> database_get_academics_exam() async
{
  Database database_db = await database_open();

  final List<Map<String, dynamic>> data_academics_exam_map = await database_db.query('academics_exam', columns: ['subject', 'type', 'exam_date', 'duration', 'entry_date', 'entry_note']);

  List<AcademicsExamData> data_academics_exam_list = [];

  for(var data in data_academics_exam_map)
  {
    data_academics_exam_list.add(
      AcademicsExamData(
        data["subject"],
        data["type"],
        DateTime.parse(data["exam_date"]),
        data["duration"],
        DateTime.parse(data["entry_date"]),
        data["entry_note"]
      )
    );
  }

  return data_academics_exam_list;
}

Future<int> database_insert_academics_exam(
  String subject,
  String type,
  String exam_date,
  int duration,
  String entry_date,
  String entry_note,
) async
{
  Database database_db = await database_open();

  int row_index = await database_db.insert(
    "academics_exam",
    {
      'subject':subject,
      'type':type,
      'exam_date':exam_date,
      'duration':duration,
      'entry_date':entry_date,
      'entry_note':entry_note,
    }
  );
  print("Row index: ${row_index}");
  return row_index;
}

// Academics marks
class AcademicsMarkData
{
  String subject;
  String type;
  double marks;
  double marks_total;
  DateTime entry_date;
  String entry_note;

  AcademicsMarkData(this.subject, this.type, this.marks, this.marks_total, this.entry_date, this.entry_note);
}

Future<List<AcademicsMarkData>> database_get_academics_mark() async
{
  Database database_db = await database_open();

  final List<Map<String, dynamic>> data_academics_mark_map = await database_db.query('academics_mark', columns: ['subject', 'type', 'marks', 'marks_total', 'entry_date', 'entry_note']);

  List<AcademicsMarkData> data_academics_mark_list = [];

  for(var data in data_academics_mark_map)
  {
    data_academics_mark_list.add(
      AcademicsMarkData(
        data["subject"],
        data["type"],
        data["marks"],
        data["marks_total"],
        DateTime.parse(data["entry_date"]),
        data["entry_note"]
      )
    );
  }

  return data_academics_mark_list;
}

Future<int> database_insert_academics_mark(
  String subject,
  String type,
  double marks,
  double marks_total,
  String entry_date,
  String entry_note,
) async
{
  Database database_db = await database_open();

  int row_index = await database_db.insert(
    "academics_mark",
    {
      'subject':subject,
      'type':type,
      'marks':marks,
      'marks_total':marks_total,
      'entry_date':entry_date,
      'entry_note':entry_note,
    }
  );
  print("Row index: ${row_index}");
  return row_index;
}

// Activity
class ActivityData{
  String name;
  int duration;
  int distance;
  double calories;
  DateTime entry_date;
  String entry_note;

  ActivityData(this.name, this.duration, this.distance, this.calories, this.entry_date, this.entry_note);
}

Future<List<ActivityData>> database_get_activity() async
{
  Database database_db = await database_open();

  final List<Map<String, dynamic>> data_activity_map = await database_db.query('activity', columns: ['name', 'duration', 'distance', 'calories', 'entry_date', 'entry_note']);

  List<ActivityData> data_activity_list = [];

  for(var data in data_activity_map)
  {
    data_activity_list.add(
      ActivityData(
        data["name"],
        data["duration"],
        data["distance"],
        data["calories"],
        DateTime.parse(data["entry_date"]),
        data["entry_note"]
      )
    );
  }

  return data_activity_list;
}

Future<int> database_insert_activity(
  String name,
  int duration,
  int distance,
  double calories,
  String entry_date,
  String entry_note,
) async
{
  Database database_db = await database_open();

  int row_index = await database_db.insert(
    "activity",
    {
      'name':name,
      'duration':duration,
      'distance':distance,
      'calories':calories,
      'entry_date':entry_date,
      'entry_note':entry_note,
    }
  );
  print("Row index: ${row_index}");
  return row_index;
}

// Body measurements
class BodyMeasurementData{
  String measurement_type;
  double value;
  String unit;
  DateTime entry_date;
  String entry_note;

  BodyMeasurementData(this.measurement_type, this.value, this.unit, this.entry_date, this.entry_note);
}

// Data display for body measurements page
Future<List<BodyMeasurementData>> database_get_bodymeasurement() async
{
  print("Body measurements data requested");

  Database database_db = await database_open();

  final List<Map<String, dynamic>> data_bodymeasurements_map = await database_db.query('body_measurement', columns: ['type', 'value', 'unit', 'entry_date', 'entry_note']);

  List<BodyMeasurementData> data_bodymeasurements_list = [];

  for(var data in data_bodymeasurements_map)
  {
    data_bodymeasurements_list.add(
      BodyMeasurementData(
        data["type"],
        data["value"] as double,
        data["unit"],
        DateTime.parse(data["entry_date"]),
        data["entry_note"]
      )
    );
  }

  print("Found ${data_bodymeasurements_list.length} entries");

  return data_bodymeasurements_list;
}

Future<int> database_insert_bodymeasurements(
  String measurement_type,
  String value,
  String unit,
  String entry_date,
  String entry_note
) async
{
  Database database_db = await database_open();

  int row_index = await database_db.insert(
    "body_measurement",
    {
      'type':measurement_type,
      'value':value,
      'unit':unit,
      'entry_date':entry_date,
      'entry_note':entry_note,
    }
  );
  print("Row index: ${row_index}");
  return row_index;
}

// Mind
// Mood
class MindMoodData
{
  String name;
  String intensity;
  bool resolved;
  DateTime? end_date;
  DateTime entry_date;
  String entry_note;

  MindMoodData(this.name, this.intensity, this.resolved, this.end_date, this.entry_date, this.entry_note);
}

Future<List<MindMoodData>> database_get_mind_mood() async
{
  Database database_db = await database_open();

  final List<Map<String, dynamic>> data_mind_mood_map = await database_db.query('mind_mood', columns: ['name', 'intensity', 'resolved', 'end_date', 'entry_date', 'entry_note']);

  List<MindMoodData> data_mind_mood_list = [];

  for(var data in data_mind_mood_map)
  {
    // int to bool
    bool _resolved = false;
    if(data["resolved"]==1)
    {
      _resolved = true;
    }
    else
    {
      _resolved = false;
    }

    data_mind_mood_list.add(
      MindMoodData(
        data["name"],
        data["intensity"],
        _resolved,
        DateTime.tryParse(data["end_date"]),
        DateTime.parse(data["entry_date"]),
        data["entry_note"],
      )
    );
  }

  return data_mind_mood_list;
}

Future<int> database_insert_mind_mood(
  String name,
  String intensity,
  bool resolved,
  String end_date,
  String entry_date,
  String entry_note,
) async
{
  Database database_db = await database_open();

  // bool to int
  int _resolved = 0;
  if(resolved==true)
  {
    _resolved = 1;
  }
  else
  {
    _resolved = 0;
  }

  int row_index = await database_db.insert(
    "mind_mood",
    {
      'name':name,
      'intensity':intensity,
      'resolved':_resolved,
      'end_date': end_date,
      'entry_date':entry_date,
      'entry_note':entry_note,
    }
  );
  print("Row index: ${row_index}");
  return row_index;
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
