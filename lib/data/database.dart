import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

//import 'package:material_symbols_icons/material_symbols_icons.dart';

import 'iconmapper.dart';

// Model files (data class)
import 'models/academics_absent.dart';
import 'models/academics_assignment.dart';
import 'models/academics_exam.dart';
import 'models/academics_mark.dart';
import 'models/activity.dart';
import 'models/body_measurement.dart';
import 'models/mind_mood.dart';
import 'models/note.dart';
import 'models/nutrition.dart';
import 'models/symptom.dart';
import 'models/time.dart';
import 'models/vitals.dart';
import 'models/workout.dart';

// Generated code for JSON annotation/serialization
//part 'academics_absent.g.dart';

// SQL code
List<String> database_sql_commands = ['create table if not exists academics_absent (id integer primary key, reason text, absent_date text, entry_date text, entry_note text);', 'create table if not exists academics_assignment (id integer primary key, subject text, type text, topic text, submitted integer, due_date text, submission_date text, entry_date text, entry_note text);', 'create table if not exists academics_exam (id integer primary key, subject text, type text, exam_date text, duration integer, entry_date text, entry_note text);', 'create table if not exists academics_mark (id integer primary key, subject text, type text, marks real, marks_total real, entry_date text, entry_note text);', 'create table if not exists activity (id integer primary key, name text, duration integer, distance integer, calories real, entry_date text, entry_note text);', 'create table if not exists body_measurement (id integer primary key, type text, value real, unit text, entry_date text, entry_note text);', 'create table if not exists mind_mood (id integer primary key, name text, intensity text, resolved integer, end_date text, entry_date text, entry_note text);', 'create table if not exists note (id integer primary key, title text, content text, tags text, entry_date text);', 'create table if not exists nutrition (id integer primary key, name text, form text, type text, qty real, calories real, mass real, carbs real, protein real, fats real, entry_date text, entry_note text);', 'create table if not exists symptom (id integer primary key, name text, intensity integer, resolved integer, end_date text, entry_date text, entry_note text);', 'create table if not exists time (id integer primary key, event text, duration integer, entry_date text, entry_note text);', 'create table if not exists vitals (id integer primary key, type text, value text, unit text, entry_date text, entry_note text);', 'create table if not exists workout (id integer primary key, name text, type text, duration integer, calories real, reps integer, weight real, entry_date text, entry_note text);'];

// title, subtitle, datatype, datetime
String database_sql_timeline = '''
select id, name as title, duration || ' mins' as subtitle, 'activity' as datatype, entry_date as date_time from activity
union all
select id, type as title, value || ' ' || unit as subtitle, 'body_measurement' as datatype, entry_date as date_time from body_measurement
union all
select id, name as title, ' ' as subtitle, 'mind_mood' as datatype, entry_date as date_time from mind_mood
union all
select id, name as title, calories || ' cal' as subtitle, 'nutrition' as datatype, entry_date as date_time from nutrition
union all
select id, name as title, ' ' as subtitle, 'symptom' as datatype, entry_date as date_time from symptom
union all
select id, event as title, duration || ' mins' as subtitle, 'time' as datatype, entry_date as date_time from time
union all
select id, type as title, value || ' ' || unit as subtitle, 'vitals' as datatype, entry_date as date_time from vitals
union all
select id, name as title, duration || ' mins' as subtitle, 'workout' as datatype, entry_date as date_time from workout
/*
select id, "Absent" as title, reason as subtitle, "academics_absent" as datatype, absent_date as date_time from academics_absent
union all
select id, "Assignment" as title, subject as subtitle, "academics_assignment" as datatype, submission_date as date_time from academics_assignment
union all
*/
order by entry_date desc;
''';

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

Future<List<Map<String, dynamic>>> database_read(String query) async
{
  var database_storage_path = await getDatabasesPath();
  String database_data_path =  join(database_storage_path, "lifesync.db");

  Database database_db = await openDatabase
  (
    database_data_path,
    version: 1,
    onCreate: (Database db, int version) async
    {
      for (var database_sql_command in database_sql_commands)
      {
        await db.execute(database_sql_command);
      }
    },
    onOpen: (Database db) async
    {
      for (var database_sql_command in database_sql_commands)
      {
        await db.execute(database_sql_command);
      }
    }
  );

  final List<Map<String, dynamic>> database_result = await database_db.rawQuery(query);

  await database_db.close();

  return database_result;
}

Future<void> database_delete() async
{
  await deleteDatabase(await database_path());
  print("Deleted database");
}

class TimelineData
{
  int id;

  IconData icon;
  String title;
  String subtitle;
  String datatype;
  DateTime date_time;

  TimelineData(this.id, this.icon, this.title, this.subtitle, this.datatype, this.date_time);
}

List<TimelineData> data_timeline = [];

Future<List<TimelineData>> database_timeline_retrive() async
{
  data_timeline = [];

  final List<Map<String, dynamic>> database_result = await database_read(database_sql_timeline);

  for (var row in database_result)
  {
    int id = row["id"] as int;
    String heading = row["title"] as String;
    String subtitle = row["subtitle"] as String;
    String type = row["datatype"] as String;
    String entry_date = row["date_time"] as String;

    data_timeline.add(TimelineData
    (
      id,
      iconmapper_geticon(type),
      heading,
      subtitle,
      type,
      DateTime.parse(entry_date)
    ));
  }

  return data_timeline;
}

// Academics
// Academics Absent
Future<List<AcademicsAbsentData>> database_get_academics_absent() async
{
  Database database_db = await database_open();

  final List<Map<String, dynamic>> data_academics_absent_map = await database_db.query(
    'academics_absent',
    columns: ['id', 'reason', 'absent_date', 'entry_date', 'entry_note']
  );

  List<AcademicsAbsentData> data_academics_absent_list = [];

  for(var data in data_academics_absent_map)
  {
    data_academics_absent_list.add(
      AcademicsAbsentData(
        data["id"],
        data["reason"],
        DateTime.parse(data["absent_date"]),
        DateTime.parse(data["entry_date"]),
        data["entry_note"]
      )
    );
  }

  return data_academics_absent_list;
}

Future<List<AcademicsAbsentData>> database_get_academics_absent_from_id(int id) async
{
  Database database_db = await database_open();

  final List<Map<String, dynamic>> data_academics_absent_map = await database_db.query(
    'academics_absent',
    columns: ['id', 'reason', 'absent_date', 'entry_date', 'entry_note'],
    where: 'id = ?',
    whereArgs: [id],
  );

  List<AcademicsAbsentData> data_academics_absent_list = [];

  for(var data in data_academics_absent_map)
  {
    data_academics_absent_list.add(
      AcademicsAbsentData(
        data["id"],
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
  [int id=-1]
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
      if(id!=-1) "id": id,
    },
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
  print("Row index: ${row_index}");
  return row_index;
}

// Academics Assignment
Future<List<AcademicsAssignmentData>> database_get_academics_assignment() async
{
  Database database_db = await database_open();

  final List<Map<String, dynamic>> data_academics_assignment_map = await database_db.query(
    'academics_assignment',
    columns: ['id', 'subject', 'type', 'topic', 'submitted', 'due_date', 'submission_date', 'entry_date', 'entry_note']
  );

  List<AcademicsAssignmentData> data_academics_assignment_list = [];

  for(var data in data_academics_assignment_map)
  {
    data_academics_assignment_list.add(
      AcademicsAssignmentData(
        data["id"],
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


Future<List<AcademicsAssignmentData>> database_get_academics_assignment_from_id(int id) async
{
  Database database_db = await database_open();

  final List<Map<String, dynamic>> data_academics_assignment_map = await database_db.query(
    'academics_assignment',
    columns: ['id', 'subject', 'type', 'topic', 'submitted', 'due_date', 'submission_date', 'entry_date', 'entry_note'],
    where: 'id = ?',
    whereArgs: [id],
  );

  List<AcademicsAssignmentData> data_academics_assignment_list = [];

  for(var data in data_academics_assignment_map)
  {
    data_academics_assignment_list.add(
      AcademicsAssignmentData(
        data["id"],
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
  [int id=-1]
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
      if(id!=-1) "id": id,
    },
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
  print("Row index: ${row_index}");
  return row_index;
}


// Academics Exam
Future<List<AcademicsExamData>> database_get_academics_exam() async
{
  Database database_db = await database_open();

  final List<Map<String, dynamic>> data_academics_exam_map = await database_db.query(
    'academics_exam',
    columns: ['id', 'subject', 'type', 'exam_date', 'duration', 'entry_date', 'entry_note']
  );

  List<AcademicsExamData> data_academics_exam_list = [];

  for(var data in data_academics_exam_map)
  {
    data_academics_exam_list.add(
      AcademicsExamData(
        data["id"],
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


Future<List<AcademicsExamData>> database_get_academics_exam_from_id(int id)
async
{
  Database database_db = await database_open();

  final List<Map<String, dynamic>> data_academics_exam_map = await database_db.query(
    'academics_exam',
    columns: ['id', 'subject', 'type', 'exam_date', 'duration', 'entry_date', 'entry_note'],
    where: 'id = ?',
    whereArgs: [id],
  );

  List<AcademicsExamData> data_academics_exam_list = [];

  for(var data in data_academics_exam_map)
  {
    data_academics_exam_list.add(
      AcademicsExamData(
        data["id"],
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
  [int id=-1]
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
      if(id!=-1) "id": id,
    },
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
  print("Row index: ${row_index}");
  return row_index;
}

// Academics marks
Future<List<AcademicsMarkData>> database_get_academics_mark() async
{
  Database database_db = await database_open();

  final List<Map<String, dynamic>> data_academics_mark_map = await database_db.query(
    'academics_mark',
    columns: ['id', 'subject', 'type', 'marks', 'marks_total', 'entry_date', 'entry_note']
  );

  List<AcademicsMarkData> data_academics_mark_list = [];

  for(var data in data_academics_mark_map)
  {
    data_academics_mark_list.add(
      AcademicsMarkData(
        data["id"],
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


Future<List<AcademicsMarkData>> database_get_academics_mark_from_id(int id)
async
{
  Database database_db = await database_open();

  final List<Map<String, dynamic>> data_academics_mark_map = await database_db.query(
    'academics_mark',
    columns: ['id', 'subject', 'type', 'marks', 'marks_total', 'entry_date', 'entry_note'],
    where: 'id = ?',
    whereArgs: [id],
  );

  List<AcademicsMarkData> data_academics_mark_list = [];

  for(var data in data_academics_mark_map)
  {
    data_academics_mark_list.add(
      AcademicsMarkData(
        data["id"],
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
  [int id=-1]
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
      if(id!=-1) "id": id,
    },
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
  print("Row index: ${row_index}");
  return row_index;
}

// Activity
Future<List<ActivityData>> database_get_activity() async
{
  Database database_db = await database_open();

  final List<Map<String, dynamic>> data_activity_map = await database_db.query(
    'activity',
    columns: ['id', 'name', 'duration', 'distance', 'calories', 'entry_date', 'entry_note']
  );

  List<ActivityData> data_activity_list = [];

  for(var data in data_activity_map)
  {
    data_activity_list.add(
      ActivityData(
        data["id"],
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


Future<List<ActivityData>> database_get_activity_from_id(int id)
async
{
  Database database_db = await database_open();

  final List<Map<String, dynamic>> data_activity_map = await database_db.query(
    'activity',
    columns: ['id', 'name', 'duration', 'distance', 'calories', 'entry_date', 'entry_note'],
    where: 'id = ?',
    whereArgs: [id],
  );

  List<ActivityData> data_activity_list = [];

  for(var data in data_activity_map)
  {
    data_activity_list.add(
      ActivityData(
        data["id"],
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

Future<List<ActivityData>> database_get_activity_for_date(DateTime target_date) async
{
  Database database_db = await database_open();
  String _target_date = DateFormat('yyyy-MM-dd').format(target_date);

  final List<Map<String, dynamic>> data_activity_map = await database_db.query(
    'activity',
    columns: ['id', 'name', 'duration', 'distance', 'calories', 'entry_date', 'entry_note'],
    where: 'date(entry_date) = ?',
    whereArgs: [_target_date],
  );

  List<ActivityData> data_activity_list = [];

  for(var data in data_activity_map)
  {
    data_activity_list.add(
      ActivityData(
        data["id"],
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
  [int id=-1]
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
      if(id!=-1) "id": id,
    },
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
  print("Row index: ${row_index}");
  return row_index;
}

// Body measurements

// Data display for body measurements page
Future<List<BodyMeasurementData>> database_get_bodymeasurement() async
{
  print("Body measurements data requested");

  Database database_db = await database_open();

  final List<Map<String, dynamic>> data_bodymeasurements_map = await database_db.query(
    'body_measurement',
    columns: ['id', 'type', 'value', 'unit', 'entry_date', 'entry_note']
  );

  List<BodyMeasurementData> data_bodymeasurements_list = [];

  for(var data in data_bodymeasurements_map)
  {
    data_bodymeasurements_list.add(
      BodyMeasurementData(
        data["id"],
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


Future<List<BodyMeasurementData>> database_get_bodymeasurement_from_id(int id) async
{
  print("Body measurements data requested");

  Database database_db = await database_open();

  final List<Map<String, dynamic>> data_bodymeasurements_map = await database_db.query(
    'body_measurement',
    columns: ['id', 'type', 'value', 'unit', 'entry_date', 'entry_note'],
    where: 'id = ?',
    whereArgs: [id],
  );

  List<BodyMeasurementData> data_bodymeasurements_list = [];

  for(var data in data_bodymeasurements_map)
  {
    data_bodymeasurements_list.add(
      BodyMeasurementData(
        data["id"],
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

// Data display for body measurements page
Future<List<BodyMeasurementData>> database_get_bodymeasurement_for_date(DateTime target_date) async
{
  print("Body measurements data requested");

  Database database_db = await database_open();
  String _target_date = DateFormat('yyyy-MM-dd').format(target_date);

  final List<Map<String, dynamic>> data_bodymeasurements_map = await database_db.query(
    'body_measurement',
    columns: ['id', 'type', 'value', 'unit', 'entry_date', 'entry_note'],
    where: 'date(entry_date) = ?',
    whereArgs: [_target_date],
  );

  List<BodyMeasurementData> data_bodymeasurements_list = [];

  for(var data in data_bodymeasurements_map)
  {
    data_bodymeasurements_list.add(
      BodyMeasurementData(
        data["id"],
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
  String entry_note,
  [int id=-1]
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
      if(id!=-1) "id": id,
    },
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
  print("Row index: ${row_index}");
  return row_index;
}

// Mind
// Mood

Future<List<MindMoodData>> database_get_mind_mood() async
{
  Database database_db = await database_open();

  final List<Map<String, dynamic>> data_mind_mood_map = await database_db.query(
    'mind_mood',
    columns: ['id', 'name', 'intensity', 'resolved', 'end_date', 'entry_date', 'entry_note'],
  );

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
        data["id"],
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

Future<List<MindMoodData>> database_get_mind_mood_from_id(int id)
async
{
  Database database_db = await database_open();

  final List<Map<String, dynamic>> data_mind_mood_map = await database_db.query(
    'mind_mood',
    columns: ['id', 'name', 'intensity', 'resolved', 'end_date', 'entry_date', 'entry_note'],
    where: 'id = ?',
    whereArgs: [id],
  );

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
        data["id"],
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

Future<List<MindMoodData>> database_get_mind_mood_for_date(DateTime target_date) async
{
  Database database_db = await database_open();
  String _target_date = DateFormat('yyyy-MM-dd').format(target_date);

  final List<Map<String, dynamic>> data_mind_mood_map = await database_db.query(
    'mind_mood',
    columns: ['id', 'name', 'intensity', 'resolved', 'end_date', 'entry_date', 'entry_note'],
    where: 'date(entry_date) = ?',
    whereArgs: [_target_date],
  );

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
        data["id"],
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
  [int id=-1]
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

  print("Replacing {$id}");

  int row_index = await database_db.insert(
    "mind_mood",
    {
      'name':name,
      'intensity':intensity,
      'resolved':_resolved,
      'end_date': end_date,
      'entry_date':entry_date,
      'entry_note':entry_note,
      if(id!=-1) "id": id,
    },
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
  print("Row index: ${row_index}");
  return row_index;
}

// Notes
Future<List<NoteData>> database_get_note() async
{
  Database database_db = await database_open();

  final List<Map<String, dynamic>> data_note_map = await database_db.query(
    'note',
    columns: ['id', 'title', 'content', 'tags', 'entry_date']
  );

  List<NoteData> data_note_list = [];

  for(var data in data_note_map)
  {
    data_note_list.add(
      NoteData(
        data["id"],
        data["title"],
        data["content"],
        data["tags"],
        DateTime.parse(data["entry_date"]),
      )
    );
  }

  return data_note_list;
}


Future<List<NoteData>> database_get_note_from_id(int id)
async
{
  Database database_db = await database_open();

  final List<Map<String, dynamic>> data_note_map = await database_db.query(
    'note',
    columns: ['id', 'title', 'content', 'tags', 'entry_date'],
    where: 'id = ?',
    whereArgs: [id],
  );

  List<NoteData> data_note_list = [];

  for(var data in data_note_map)
  {
    data_note_list.add(
      NoteData(
        data["id"],
        data["title"],
        data["content"],
        data["tags"],
        DateTime.parse(data["entry_date"]),
      )
    );
  }

  return data_note_list;
}

Future<int> database_insert_note(
  String title,
  String content,
  String tags,
  String entry_date,
  [int id=-1]
) async
{
  Database database_db = await database_open();

  int row_index = await database_db.insert(
    "note",
    {
      'title':title,
      'content':content,
      'tags':tags,
      'entry_date':entry_date,
      if(id!=-1) "id": id,
    },
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
  return row_index;
}


// Nutrition
Future<List<NutritionData>> database_get_nutrition() async
{
  Database database_db = await database_open();

  final List<Map<String, dynamic>> data_nutrition_map = await database_db.query(
    'nutrition',
    columns: ['id', 'name', 'form', 'type', 'qty', 'calories', 'mass', 'carbs', 'protein', 'fats', 'entry_date', 'entry_note\n'],
  );

  List<NutritionData> data_nutrition_list = [];

  for(var data in data_nutrition_map)
  {
    data_nutrition_list.add(
      NutritionData(
        data["id"],
        data["name"],
        data["form"],
        data["type"],
        data["qty"],
        data["calories"],
        data["mass"],
        data["carbs"],
        data["protein"],
        data["fats"],
        DateTime.parse(data["entry_date"]),
        data["entry_note"],
      )
    );
  }

  return data_nutrition_list;
}


Future<List<NutritionData>> database_get_nutrition_from_id(int id)
async
{
  Database database_db = await database_open();

  final List<Map<String, dynamic>> data_nutrition_map = await database_db.query(
    'nutrition',
    columns: ['id', 'name', 'form', 'type', 'qty', 'calories', 'mass', 'carbs', 'protein', 'fats', 'entry_date', 'entry_note\n'],
    where: 'id = ?',
    whereArgs: [id],
  );

  List<NutritionData> data_nutrition_list = [];

  for(var data in data_nutrition_map)
  {
    data_nutrition_list.add(
      NutritionData(
        data["id"],
        data["name"],
        data["form"],
        data["type"],
        data["qty"],
        data["calories"],
        data["mass"],
        data["carbs"],
        data["protein"],
        data["fats"],
        DateTime.parse(data["entry_date"]),
        data["entry_note"],
      )
    );
  }

  return data_nutrition_list;
}

Future<List<NutritionData>> database_get_nutrition_for_date(DateTime target_date) async
{
  Database database_db = await database_open();
  String _target_date = DateFormat('yyyy-MM-dd').format(target_date);

  final List<Map<String, dynamic>> data_nutrition_map = await database_db.query(
    'nutrition',
    columns: ['id', 'name', 'form', 'type', 'qty', 'calories', 'mass', 'carbs', 'protein', 'fats', 'entry_date', 'entry_note'],
    where: 'date(entry_date) = ?',
    whereArgs: [_target_date],
  );

  List<NutritionData> data_nutrition_list = [];

  for(var data in data_nutrition_map)
  {
    data_nutrition_list.add(
      NutritionData(
        data["id"],
        data["name"],
        data["form"],
        data["type"],
        data["qty"],
        data["calories"],
        data["mass"],
        data["carbs"],
        data["protein"],
        data["fats"],
        DateTime.parse(data["entry_date"]),
        data["entry_note"],
      )
    );
  }

  return data_nutrition_list;
}

Future<int> database_insert_nutrition(
  String name,
  String form,
  String type,
  double qty,
  double calories,
  double mass,
  double carbs,
  double protein,
  double fats,
  String entry_date,
  String entry_note,
  [int id=-1]
) async
{
  Database database_db = await database_open();

  int row_index = await database_db.insert(
    "nutrition",
    {
      'name':name,
      'form':form,
      'type':type,
      'qty':qty,
      'calories':calories,
      'mass':mass,
      'carbs':carbs,
      'protein':protein,
      'fats':fats,
      'entry_date':entry_date,
      'entry_note':entry_note,
      if(id!=-1) "id": id,
    },
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
  return row_index;
}

// Symptom

Future<List<SymptomData>> database_get_symptom() async
{
  Database database_db = await database_open();

  final List<Map<String, dynamic>> data_symptom_map = await database_db.query(
    'symptom',
    columns: ['id', 'name', 'intensity', 'resolved', 'end_date', 'entry_date', 'entry_note']
  );

  List<SymptomData> data_symptom_list = [];

  for(var data in data_symptom_map)
  {
    data_symptom_list.add(
      SymptomData(
        data["id"],
        data["name"],
        data["intensity"],
        data["resolved"],
        data["end_date"],
        DateTime.parse(data["entry_date"]),
        data["entry_note"],
      )
    );
  }

  return data_symptom_list;
}

Future<List<SymptomData>> database_get_symptom_from_id(int id)
async
{
  Database database_db = await database_open();

  final List<Map<String, dynamic>> data_symptom_map = await database_db.query(
    'symptom',
    columns: ['id', 'name', 'intensity', 'resolved', 'end_date', 'entry_date', 'entry_note'],
    where: 'id = ?',
    whereArgs: [id],
  );

  List<SymptomData> data_symptom_list = [];

  for(var data in data_symptom_map)
  {
    data_symptom_list.add(
      SymptomData(
        data["id"],
        data["name"],
        data["intensity"],
        data["resolved"],
        data["end_date"],
        DateTime.parse(data["entry_date"]),
        data["entry_note"],
      )
    );
  }

  return data_symptom_list;
}

Future<int> database_insert_symptom(
  String name,
  int intensity,
  int resolved,
  String end_date,
  String entry_date,
  String entry_note,
  [int id=-1]
) async
{
  Database database_db = await database_open();

  int row_index = await database_db.insert(
    "symptom",
    {
      'name':name,
      'intensity':intensity,
      'resolved':resolved,
      'end_date':end_date,
      'entry_date':entry_date,
      'entry_note':entry_note,
      if(id!=-1) "id": id,
    },
    conflictAlgorithm: ConflictAlgorithm.replace,
  );

  return row_index;
}

Future<bool> database_symptom_unresolved_present() async
{
  List<SymptomData> symptom_data = await database_get_symptom();

  for(var data in symptom_data)
  {
    if(data.resolved==0)
    {
      return true;
    }
  }

  return false;
}

class TimeDataGrouped{
  String event;
  int duration;

  TimeDataGrouped(this.event, this.duration);
}

Future<List<TimeData>> database_get_time() async
{
  Database database_db = await database_open();

  final List<Map<String, dynamic>> data_time_map = await database_db.query(
    'time',
    columns: ['id', 'event', 'duration', 'entry_date', 'entry_note'],
  );

  List<TimeData> data_time_list = [];

  for(var data in data_time_map)
  {
    data_time_list.add(
      TimeData(
        data["id"],
        data["event"],
        data["duration"],
        DateTime.parse(data["entry_date"]),
        data["entry_note"],
      )
    );
  }

  return data_time_list;
}


Future<List<TimeData>> database_get_time_from_id(int id)
async
{
  Database database_db = await database_open();

  final List<Map<String, dynamic>> data_time_map = await database_db.query(
    'time',
    columns: ['id', 'event', 'duration', 'entry_date', 'entry_note'],
    where: 'id = ?',
    whereArgs: [id],
  );

  List<TimeData> data_time_list = [];

  for(var data in data_time_map)
  {
    data_time_list.add(
      TimeData(
        data["id"],
        data["event"],
        data["duration"],
        DateTime.parse(data["entry_date"]),
        data["entry_note"],
      )
    );
  }

  return data_time_list;
}

Future<List<TimeData>> database_get_time_for_date(DateTime target_date) async
{
  Database database_db = await database_open();
  String _target_date = DateFormat('yyyy-MM-dd').format(target_date);

  final List<Map<String, dynamic>> data_time_map = await database_db.query(
    'time',
    columns: ['id', 'event', 'duration', 'entry_date', 'entry_note'],
    where: 'entry_date = ?',
    whereArgs: [_target_date],
  );

  List<TimeData> data_time_list = [];

  for(var data in data_time_map)
  {
    data_time_list.add(
      TimeData(
        data["id"],
        data["event"],
        data["duration"],
        data["entry_date"],
        data["entry_note"],
      )
    );
  }

  return data_time_list;
}

Future<List<TimeDataGrouped>> database_get_time_for_date_grouped(DateTime target_date) async
{
  Database database_db = await database_open();
  String _target_date = DateFormat('yyyy-MM-dd').format(target_date);

  final List<Map<String, dynamic>> data_time_map = await database_db.query(
    'time',
    columns: ['event', 'sum(duration) as duration'],
    where: 'date(entry_date) = ?',
    whereArgs: [_target_date],
    groupBy: 'event',
  );

  List<TimeDataGrouped> data_time_list = [];

  for(var data in data_time_map)
  {
    data_time_list.add(
      TimeDataGrouped(
        data["event"],
        data["duration"],
      )
    );
  }

  return data_time_list;
}

Future<int> database_insert_time(
  String event,
  int duration,
  String entry_date,
  String entry_note,
  [int id=-1]
) async
{
  Database database_db = await database_open();

  int row_index = await database_db.insert(
    "time",
    {
      'event':event,
      'duration':duration,
      'entry_date':entry_date,
      'entry_note':entry_note,
      if(id!=-1) "id": id,
    },
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
  return row_index;
}

// Vitals

Future<List<VitalsData>> database_get_vitals() async
{
  Database database_db = await database_open();

  final List<Map<String, dynamic>> data_vitals_map = await database_db.query(
    'vitals',
    columns: ['id', 'type', 'value', 'unit', 'entry_date', 'entry_note']);

  List<VitalsData> data_vitals_list = [];

  for(var data in data_vitals_map)
  {
    data_vitals_list.add(
      VitalsData(
        data["id"],
        data["type"],
        data["value"],
        data["unit"],
        DateTime.parse(data["entry_date"]),
        data["entry_note"],
      )
    );
  }

  return data_vitals_list;
}

Future<List<VitalsData>> database_get_vitals_from_id(int id)
async
{
  Database database_db = await database_open();

  final List<Map<String, dynamic>> data_vitals_map = await database_db.query(
    'vitals',
    columns: ['id', 'type', 'value', 'unit', 'entry_date', 'entry_note'],
    where: 'id = ?',
    whereArgs: [id],
  );

  List<VitalsData> data_vitals_list = [];

  for(var data in data_vitals_map)
  {
    data_vitals_list.add(
      VitalsData(
        data["id"],
        data["type"],
        data["value"],
        data["unit"],
        DateTime.parse(data["entry_date"]),
        data["entry_note"],
      )
    );
  }

  return data_vitals_list;
}

Future<List<VitalsData>> database_get_vitals_for_date(DateTime target_date) async
{
  Database database_db = await database_open();
  String _target_date = DateFormat('yyyy-MM-dd').format(target_date);

  final List<Map<String, dynamic>> data_vitals_map = await database_db.query(
    'vitals',
    columns: ['id', 'type', 'value', 'unit', 'entry_date', 'entry_note'],
    where: 'date(entry_date) = ?',
    whereArgs: [_target_date],
  );

  List<VitalsData> data_vitals_list = [];

  for(var data in data_vitals_map)
  {
    data_vitals_list.add(
      VitalsData(
        data["id"],
        data["type"],
        data["value"],
        data["unit"],
        DateTime.parse(data["entry_date"]),
        data["entry_note"],
      )
    );
  }

  return data_vitals_list;
}

Future<int> database_insert_vitals(
  String type,
  String value,
  String unit,
  String entry_date,
  String entry_note,
  [int id=-1]
) async
{
  Database database_db = await database_open();

  int row_index = await database_db.insert(
    "vitals",
    {
      'type':type,
      'value':value,
      'unit':unit,
      'entry_date':entry_date,
      'entry_note':entry_note,
      if(id!=-1) "id": id,
    },
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
  return row_index;
}

// Workout

Future<List<WorkoutData>> database_get_workout() async
{
  Database database_db = await database_open();

  final List<Map<String, dynamic>> data_workout_map = await database_db.query('workout', columns: ['id', 'name', 'type', 'duration', 'calories', 'reps', 'weight', 'entry_date', 'entry_note']);

  List<WorkoutData> data_workout_list = [];

  for(var data in data_workout_map)
  {
    data_workout_list.add(
      WorkoutData(
        data["id"],
        data["name"],
        data["type"],
        data["duration"],
        data["calories"],
        data["reps"],
        data["weight"],
        DateTime.parse(data["entry_date"]),
        data["entry_note"],
      )
    );
  }

  return data_workout_list;
}

Future<List<WorkoutData>> database_get_workout_from_id(int id)
async
{
  Database database_db = await database_open();

  final List<Map<String, dynamic>> data_workout_map = await database_db.query(
    'workout',
    columns: ['id', 'name', 'type', 'duration', 'calories', 'reps', 'weight', 'entry_date', 'entry_note'],
    where: 'id = ?',
    whereArgs: [id],
  );

  List<WorkoutData> data_workout_list = [];

  for(var data in data_workout_map)
  {
    data_workout_list.add(
      WorkoutData(
        data["id"],
        data["name"],
        data["type"],
        data["duration"],
        data["calories"],
        data["reps"],
        data["weight"],
        DateTime.parse(data["entry_date"]),
        data["entry_note"],
      )
    );
  }

  return data_workout_list;
}

Future<List<WorkoutData>> database_get_workout_for_date(DateTime target_date) async
{
  Database database_db = await database_open();
  String _target_date = DateFormat('yyyy-MM-dd').format(target_date);

  final List<Map<String, dynamic>> data_workout_map = await database_db.query(
    'workout',
    columns: ['id', 'name', 'type', 'duration', 'calories', 'reps', 'weight', 'entry_date', 'entry_note'],
    where: 'date(entry_date) = ?',
    whereArgs: [_target_date],
  );

  List<WorkoutData> data_workout_list = [];

  for(var data in data_workout_map)
  {
    data_workout_list.add(
      WorkoutData(
        data["id"],
        data["name"],
        data["type"],
        data["duration"],
        data["calories"],
        data["reps"],
        data["weight"],
        DateTime.parse(data["entry_date"]),
        data["entry_note"],
      )
    );
  }

  return data_workout_list;
}

Future<int> database_insert_workout(
  String name,
  String type,
  int duration,
  double calories,
  int reps,
  double weight,
  String entry_date,
  String entry_note,
  [int id=-1]
) async
{
  Database database_db = await database_open();

  int row_index = await database_db.insert(
    "workout",
    {
      'name':name,
      'type':type,
      'duration':duration,
      'calories':calories,
      'reps':reps,
      'weight':weight,
      'entry_date':entry_date,
      'entry_note':entry_note,
    },
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
  return row_index;
}

// Aggregate data
Future<int> database_aggregate_activity_calories(DateTime target_date) async
{
  Database database_db = await database_open();

  String _target_date = DateFormat('yyyy-MM-dd').format(target_date);

  final List<Map<String, dynamic>> data_aggregate = await database_db.rawQuery('select sum(calories) as total from activity where date(entry_date) = ?', [_target_date]);

  if(data_aggregate.isNotEmpty && data_aggregate.first['total']!=null)
  {
    //print((data_aggregate.first['total'] as num).toInt());
    return (data_aggregate.first['total'] as num).toInt();
  }

  return 0;
}

Future<int> database_aggregate_activity_distance(DateTime target_date) async
{
  Database database_db = await database_open();

  String _target_date = DateFormat('yyyy-MM-dd').format(target_date);

  final List<Map<String, dynamic>> data_aggregate = await database_db.rawQuery('select sum(distance) as total from activity where date(entry_date) = ?', [_target_date]);

  if(data_aggregate.isNotEmpty && data_aggregate.first['total']!=null)
  {
    //print((data_aggregate.first['total'] as num).toInt());
    return (data_aggregate.first['total'] as num).toInt();
  }

  return 0;
}

Future<int> database_aggregate_activity_duration(DateTime target_date) async
{
  Database database_db = await database_open();

  String _target_date = DateFormat('yyyy-MM-dd').format(target_date);

  final List<Map<String, dynamic>> data_aggregate = await database_db.rawQuery('select sum(duration) as total from activity where date(entry_date) = ?', [_target_date]);

  if(data_aggregate.isNotEmpty && data_aggregate.first['total']!=null)
  {
    //print((data_aggregate.first['total'] as num).toInt());
    return (data_aggregate.first['total'] as num).toInt();
  }

  return 0;
}

Future<int> database_aggregate_activity_steps(DateTime target_date) async
{
  Database database_db = await database_open();

  String _target_date = DateFormat('yyyy-MM-dd').format(target_date);

  int duration = 0;
  int distance = 0;

  // Activities whose steps we should count
  final List<String> activity_list = [
    "Badminton",
    "Baseball",
    "Basketball",
    "Cricket",
    "Football",
    "Golf",
    "Handball",
    "Hiking",
    "Hockey",
    "Kabbadi",
    "Martial Arts",
    "Mixed Martial Arts",
    "Pickleball",
    "Pool",
    "Rugby",
    "Running",
    "Sprint",
    "Volleyball",
    //"Custom"
  ];

  String activity_placeholder = List.filled(activity_list.length, '?').join(', ');
  List<dynamic> query_arguments = [...activity_list, _target_date];


  final List<Map<String, dynamic>> data_aggregate = await database_db.rawQuery('select sum(duration) as total_duration, sum(distance) as total_distance from activity where name in ($activity_placeholder) and date(entry_date) = ?', query_arguments);

  if(data_aggregate.isNotEmpty && data_aggregate.first['total_duration']!=null && data_aggregate.first['total_distance']!=null)
  {
    duration = (data_aggregate.first['total_duration'] as num).toInt();
    distance = (data_aggregate.first['total_distance'] as num).toInt();
  }

  // Calculate steps
  double speed = distance/(duration*60);

  double stride_length = 0.71;
  if(speed>=3)
  {
    stride_length = 1.2;
  }
  else if(speed>=2)
  {
    stride_length = 1.05;
  }
  else if(speed>=1.5)
  {
    stride_length = 0.85;
  }
  else if(speed>=1.2)
  {
    stride_length = 0.71;
  }
  else
  {
    stride_length = 0.6;
  }

  double _steps = distance/stride_length;

  int steps = _steps.toInt();

  return steps;
}

Future<int> database_aggregate_nutrition_calories(DateTime target_date) async
{
  Database database_db = await database_open();

  String _target_date = DateFormat('yyyy-MM-dd').format(target_date);

  final List<Map<String, dynamic>> data_aggregate = await database_db.rawQuery('select sum(calories) as total from nutrition where date(entry_date) = ?', [_target_date]);

  if(data_aggregate.isNotEmpty && data_aggregate.first['total']!=null)
  {
    //print((data_aggregate.first['total'] as num).toInt());
    return (data_aggregate.first['total'] as num).toInt();
  }

  return 0;
}

Future<int> database_aggregate_workout_calories(DateTime target_date) async
{
  Database database_db = await database_open();

  String _target_date = DateFormat('yyyy-MM-dd').format(target_date);

  final List<Map<String, dynamic>> data_aggregate = await database_db.rawQuery('select sum(calories) as total from workout where date(entry_date) = ?', [_target_date]);

  if(data_aggregate.isNotEmpty && data_aggregate.first['total']!=null)
  {
    //print((data_aggregate.first['total'] as num).toInt());
    return (data_aggregate.first['total'] as num).toInt();
  }

  return 0;
}

Future<int> database_aggregate_time_study(DateTime target_date) async
{
  Database database_db = await database_open();

  String _target_date = DateFormat('yyyy-MM-dd').format(target_date);

  final List<Map<String, dynamic>> data_aggregate = await database_db.rawQuery('select sum(duration) as total from time where event = ? and date(entry_date) = ?', ["Study", _target_date]);

  if(data_aggregate.isNotEmpty && data_aggregate.first['total']!=null)
  {
    //print((data_aggregate.first['total'] as num).toInt());
    return (data_aggregate.first['total'] as num).toInt();
  }

  return 0;
}

Future<int> database_aggregate_time_sleep(DateTime target_date) async
{
  Database database_db = await database_open();

  String _target_date = DateFormat('yyyy-MM-dd').format(target_date);

  final List<Map<String, dynamic>> data_aggregate = await database_db.rawQuery('select sum(duration) as total from time where event = ? and date(entry_date) = ?', ["Sleep", _target_date]);

  if(data_aggregate.isNotEmpty && data_aggregate.first['total']!=null)
  {
    //print((data_aggregate.first['total'] as num).toInt());
    return (data_aggregate.first['total'] as num).toInt();
  }

  return 0;
}

Future<int> database_aggregate_time_free(DateTime target_date) async
{
  Database database_db = await database_open();

  String _target_date = DateFormat('yyyy-MM-dd').format(target_date);

  final List<String> time_list = [
    //"Sleep",
    //"Study",
    //"Food",
    "Hobby",
    "Gaming",
    "Outing",
    //"Commute",
    "Entertainment",
  ];

  String query_placeholder = List.filled(time_list.length, '?').join(', ');
  List<dynamic> query_arguments = [...time_list, _target_date];

  final List<Map<String, dynamic>> data_aggregate = await database_db.rawQuery('select sum(duration) as total from time where event in ($query_placeholder) and date(entry_date) = ?', query_arguments);

  if(data_aggregate.isNotEmpty && data_aggregate.first['total']!=null)
  {
    //print((data_aggregate.first['total'] as num).toInt());
    return (data_aggregate.first['total'] as num).toInt();
  }

  return 0;
}

// Get latest
Future<int> database_latest_body_height() async
{
  Database database_db = await database_open();

  final List<Map<String, dynamic>> data_aggregate = await database_db.rawQuery('''select value from body_measurement where type = ? order by entry_date desc''', ['Height']);

  if(data_aggregate.isNotEmpty && data_aggregate.first['value']!=null)
  {
    //print((data_aggregate.first['total'] as num).toInt());
    return (data_aggregate.first['value'] as num).toInt();
  }

  return 0;
}

Future<int> database_latest_body_weight() async
{
  Database database_db = await database_open();

  final List<Map<String, dynamic>> data_aggregate = await database_db.rawQuery('''select value from body_measurement where type = ? order by entry_date desc''', ['Weight']);

  if(data_aggregate.isNotEmpty && data_aggregate.first['value']!=null)
  {
    //print((data_aggregate.first['total'] as num).toInt());
    return (data_aggregate.first['value'] as num).toInt();
  }

  return 0;
}

// Graph data
class GraphData{
  String value;
  DateTime entry_date;

  GraphData(this.value, this.entry_date);
}

Future<List<GraphData>> database_graphdata_retrive(String table_name, String column_name, String where_column, String where_condition, DateTime date_start, DateTime date_end) async
{
  List<GraphData> data_graphvalues = [];

  String _date_start = DateFormat('yyyy-MM-dd').format(date_start);
  String _date_end = DateFormat('yyyy-MM-dd').format(date_end);

  Database database_db = await database_open();

  // select value as value, entry_date from vitals where name = 'Heartrate' and entry_date between 2026-03-02 and 2026-03-09 order by entry_date asc
  final List<Map<String, dynamic>> database_result = await database_db.rawQuery('''select $column_name as value, entry_date from $table_name where $where_column = ? and date(entry_date) between date(?) and date(?) order by entry_date asc''', [ where_condition, _date_start, _date_end]);

  //print("$table_name: got ${database_result.length} rows");

  for (var row in database_result)
  {
    String value = row["value"].toString();
    DateTime entry_date = DateTime.parse(row["entry_date"] as String);
    //print("$value, $entry_date");
    data_graphvalues.add(GraphData(value, entry_date));
  }

  return data_graphvalues;
}
