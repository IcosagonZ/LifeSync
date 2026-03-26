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
List<String> database_sql_commands = ['create table if not exists settings(id integer primary key, name text, value text);','create table if not exists scores(name text, value integer);', 'create table if not exists chat(id integer primary key, user text, server text);', 'create table if not exists goals(name text, value integer);', 'create table if not exists insights(id integer primary key, title text, subtitle text, description text, score integer, datetime text);', 'create table if not exists recommendations(id integer primary key, content text, datetime text);', 'create table if not exists academics_absent (id integer primary key, reason text, absent_date text, entry_date text, entry_note text);', 'create table if not exists academics_assignment (id integer primary key, subject text, type text, topic text, submitted integer, due_date text, submission_date text, entry_date text, entry_note text);', 'create table if not exists academics_exam (id integer primary key, subject text, type text, exam_date text, duration integer, entry_date text, entry_note text);', 'create table if not exists academics_mark (id integer primary key, subject text, type text, marks real, marks_total real, entry_date text, entry_note text);', 'create table if not exists activity (id integer primary key, name text, duration integer, distance integer, calories real, entry_date text, entry_note text);', 'create table if not exists body_measurement (id integer primary key, type text, value real, unit text, entry_date text, entry_note text);', 'create table if not exists mind_mood (id integer primary key, name text, intensity text, resolved integer, end_date text, entry_date text, entry_note text);', 'create table if not exists note (id integer primary key, title text, content text, tags text, entry_date text);', 'create table if not exists nutrition (id integer primary key, name text, form text, type text, qty real, calories real, mass real, carbs real, protein real, fats real, entry_date text, entry_note text);', 'create table if not exists symptom (id integer primary key, name text, intensity text, resolved integer, end_date text, entry_date text, entry_note text);', 'create table if not exists time (id integer primary key, event text, duration integer, entry_date text, start_datetime text, end_datetime text, entry_note text);', 'create table if not exists vitals (id integer primary key, type text, value text, unit text, entry_date text, entry_note text);', 'create table if not exists workout (id integer primary key, name text, type text, duration integer, calories real, reps integer, weight real, entry_date text, entry_note text);'];

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

bool database_print_enabled = false;

void database_print(String text)
{
  print(text);
}

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

Future<String> database_rawQuery(String command) async
{
  try
  {
    String sql_command = command.trim();
    String sql_command_type = sql_command.split(" ").first.toUpperCase();

    Database database_db = await database_open();

    if(sql_command_type=="SELECT" || sql_command_type=="PRAGMA")
    {
      List<Map<String, dynamic>> result_map = await database_db.rawQuery(sql_command);
      String result="";
      for(var row in result_map)
      {
        result += "${row.toString()}\n";
      }
      return result;
    }
    else if(sql_command_type=="DELETE")
    {
      int result_int = await database_db.rawDelete(sql_command);
      String result="Deleted ${result_int} rows";
      return result;
    }
    else if(sql_command_type=="UPDATE")
    {
      int result_int = await database_db.rawUpdate(sql_command);
      String result="Updated ${result_int} rows";
      return result;
    }
    else if(sql_command_type=="INSERT")
    {
      int result_int = await database_db.rawInsert(sql_command);
      String result="Inserted at index ${result_int}";
      return result;
    }
    else if(sql_command[0]==".")
    {
      switch(sql_command)
      {
        case '.tables':
          List<Map<String, dynamic>> result_map = await database_db.rawQuery("select name from sqlite_master where type='table' and name not like 'sqlite_%';");
          String result="";
          for(var row in result_map)
          {
            result += "${row.toString()}\n";
          }
          return result;
        case '.schema':
          List<Map<String, dynamic>> result_map = await database_db.rawQuery("select name,sql from sqlite_master where type='table' and name not like 'sqlite_%';");
          String result="";
          for(var row in result_map)
          {
            result += "${row.toString()}\n";
          }
          return result;
        case '.databases':
          List<Map<String, dynamic>> result_map = await database_db.rawQuery("pragma database_list;");
          String result="";
          for(var row in result_map)
          {
            result += "${row.toString()}\n";
          }
          return result;
        default:
          return "Unknown dot command, valid dot commands are: .tables, .schema, .databases";
      }
    }
    else
    {
      database_db.execute(sql_command);
      return "Executed command";
    }
  }
  catch(e)
  {
    return "${e}";
  }
}

Future<void> database_delete() async
{
  await deleteDatabase(await database_path());
  database_print("Deleted database");
}

Future<int> database_delete_row_from_id(String table, int id) async
{
  Database database_db = await database_open();

  int deleted_rows = await database_db.delete(
    table,
    where: 'id = ?',
    whereArgs: [id],
  );

  return deleted_rows;
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
      iconmapper_geticon(type, heading),
      heading,
      subtitle,
      type,
      DateTime.parse(entry_date)
    ));
  }

  return data_timeline;
}

// Settings
class SettingsData
{
  int id;
  String name;
  String value;

  SettingsData(this.id, this.name, this.value);
}

Future<List<SettingsData>> database_get_settings() async
{
  Database database_db = await database_open();

  final List<Map<String, dynamic>> data_settings_map = await database_db.query(
    'settings',
    columns: ['id', 'name', 'value']
  );

  List<SettingsData> data_settings_list = [];

  for(var data in data_settings_map)
  {
    data_settings_list.add(
      SettingsData(
        data["id"],
        data["name"],
        data["value"]
      )
    );
  }

  return data_settings_list;
}

Future<String> database_get_settings_from_name(String name) async
{
  Database database_db = await database_open();

  final List<Map<String, dynamic>> data_settings_map = await database_db.query(
    'settings',
    columns: ['id', 'name', 'value'],
    where: 'name = ?',
    whereArgs: [name],
  );

  List<SettingsData> data_settings_list = [];

  for(var data in data_settings_map)
  {
    data_settings_list.add(
      SettingsData(
        data["id"],
        data["name"],
        data["value"]
      )
    );
  }

  if(data_settings_list.isEmpty)
  {
    return "No data";
  }

  return data_settings_list.first.value;
}

Future<int> database_insert_settings(
  String name,
  String value,
  [int id=-1]
) async
{
  Database database_db = await database_open();

  int row_index = await database_db.insert(
    "settings",
    {
      'name':name,
      'value':value,

      if(id!=-1) "id": id,
    },
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
  database_print("Row index: ${row_index}");
  return row_index;
}

Future<String> database_get_settings_backendurl() async
{
  Database database_db = await database_open();
  String default_url = 'http://127.0.0.1:8000/';

  final List<Map<String, dynamic>> data_settings_map = await database_db.query(
    'settings',
    columns: ['id', 'name', 'value']
  );

  for(var data in data_settings_map)
  {
    if(data["name"]=="backend_url")
    {
      return data["value"];
    }
  }

  // if not returned it doesnt exist, add backendurl
  database_print("Added backend url as it didnt exist");
  database_insert_settings("backend_url", default_url);

  return default_url;
}

Future<String> database_get_settings_token() async
{
  Database database_db = await database_open();

  final List<Map<String, dynamic>> data_settings_map = await database_db.query(
    'settings',
    columns: ['id', 'name', 'value']
  );

  for(var data in data_settings_map)
  {
    if(data["name"]=="token")
    {
      return data["value"];
    }
  }

  // if not returned it doesnt exist, add backendurl
  database_print("Database: Token doesnt exist");
  return "N/A";
}

Future<int> database_update_settings(
  String name,
  String value,
) async
{
  Database database_db = await database_open();

  int row_index = await database_db.update(
    "settings",
    {
      'value':value,
    },
    where: 'name = ?',
    whereArgs: [name],
  );
  database_print("Updated rows: ${row_index}");
  return row_index;
}

Future<int> database_delete_settings(
  String value,
) async
{
  Database database_db = await database_open();

  int row_index = await database_db.delete(
    "settings",
    where: 'name = ?',
    whereArgs: [value],
  );
  database_print("Deleted rows: ${row_index}");
  return row_index;
}

Future<DateTime?> database_get_settings_last_update() async
{
  Database database_db = await database_open();

  final List<Map<String, dynamic>> data_settings_map = await database_db.query(
    'settings',
    columns: ['id', 'name', 'value']
  );

  for(var data in data_settings_map)
  {
    if(data["name"]=="last_update")
    {
      return DateTime.parse(data["value"]);
    }
  }

  return null;
}

Future<String> database_get_settings_last_update_string() async
{
  Database database_db = await database_open();

  final List<Map<String, dynamic>> data_settings_map = await database_db.query(
    'settings',
    columns: ['id', 'name', 'value']
  );

  for(var data in data_settings_map)
  {
    if(data["name"]=="last_update")
    {
      return "${DateFormat('dd/MM/yy hh:mm aa').format(DateTime.parse(data["value"]))}";
    }
  }

  return "Never";
}

Future<int> database_set_settings_last_update(DateTime update_time) async
{
  database_delete_settings("last_update");

  Database database_db = await database_open();

  int row_index = await database_db.insert(
    "settings",
    {
      'name': "last_update",
      'value': update_time.toIso8601String(),
    },
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
  database_print("Row index: ${row_index}");
  return row_index;
}

// Chat
class ChatData
{
  String user;
  String server;

  ChatData(this.user, this.server);
}

Future<List<ChatData>> database_get_chat() async
{
  Database database_db = await database_open();

  final List<Map<String, dynamic>> data_chat_map = await database_db.query(
    'chat',
    columns: ['user', 'server']
  );

  List<ChatData> data_chat_list = [];

  for(var data in data_chat_map)
  {
    data_chat_list.add(
      ChatData(
        data["user"],
        data["server"],
      )
    );
  }

  return data_chat_list;
}

Future<int> database_insert_chat(
  String user,
  String server,
) async
{
  Database database_db = await database_open();

  int row_index = await database_db.insert(
    "chat",
    {
      'user':user,
      'server':server,
    },
  );
  database_print("Row index: ${row_index}");
  return row_index;
}

Future<int> database_delete_chat() async
{
  Database database_db = await database_open();

  int row_index = await database_db.delete(
    "chat"
  );
  database_print("Deleted $row_index");
  return row_index;
}

// Recommendations
class RecommendationsData
{
  int id;

  String content;
  DateTime datetime;

  RecommendationsData(this.id, this.content, this.datetime);
}

Future<List<RecommendationsData>> database_get_recommendations() async
{
  Database database_db = await database_open();

  final List<Map<String, dynamic>> data_recommendations_map = await database_db.query(
    'recommendations',
    columns: ['id','content', 'datetime']
  );

  List<RecommendationsData> data_recommendations_list = [];

  for(var data in data_recommendations_map)
  {
    data_recommendations_list.add(
      RecommendationsData(
        data["id"],
        data["content"],
        DateTime.parse(data["datetime"]),
      )
    );
  }

  return data_recommendations_list;
}

Future<int> database_insert_recommendation(
  String content,
) async
{
  Database database_db = await database_open();

  int row_index = await database_db.insert(
    "recommendations",
    {
      'content': content,
      'datetime': DateTime.now().toIso8601String(),
    },
  );
  database_print("Row index: ${row_index}");
  return row_index;
}

Future<int> database_delete_recommendation_from_id(int id) async
{
  Database database_db = await database_open();

  int row_index = await database_db.delete(
    "recommendations",
    where: 'id = ?',
    whereArgs: [id],
  );
  database_print("Deleted $row_index");
  return row_index;
}

// Insights

class InsightsData{
  int id;

  String title;
  String subtitle;
  String description;
  DateTime datetime;

  int score;

  InsightsData(this.id, this.title, this.subtitle, this.description, this.score, this.datetime);
}

Future<List<InsightsData>> database_get_insights() async
{
  Database database_db = await database_open();

  final List<Map<String, dynamic>> data_insights_map = await database_db.query(
    'insights',
    columns: ['id','title', 'subtitle', 'description', 'datetime', 'score']
  );

  List<InsightsData> data_insights_list = [];

  for(var data in data_insights_map)
  {
    data_insights_list.add(
      InsightsData(
        data["id"],
        data["title"],
        data["subtitle"],
        data["description"],
        data["score"],
        DateTime.parse(data["datetime"]),
      )
    );
  }

  return data_insights_list;
}

Future<int> database_insert_insights(
  String title,
  String subtitle,
  String description,
  int score,
) async
{
  Database database_db = await database_open();

  int row_index = await database_db.insert(
    "insights",
    {
      "title":title,
      "subtitle":subtitle,
      "description":description,
      "score":score,
      "datetime": DateTime.now().toIso8601String(),
    },
  );
  database_print("Row index: ${row_index}");
  return row_index;
}

Future<int> database_delete_insights() async
{
  Database database_db = await database_open();

  int row_index = await database_db.delete(
    "insights",
  );
  database_print("Deleted $row_index");
  return row_index;
}

Future<int> database_delete_insights_from_id(int id) async
{
  Database database_db = await database_open();

  int row_index = await database_db.delete(
    "insights",
    where: 'id = ?',
    whereArgs: [id],
  );
  database_print("Deleted $row_index");
  return row_index;
}

// Scores
Future<int> database_get_score(String name) async
{
  Database database_db = await database_open();

  final List<Map<String, dynamic>> data_recommendations_map = await database_db.query(
    'scores',
    columns: ['name', 'value']
  );

  for(var data in data_recommendations_map)
  {
    final value = data["value"] as int;
    if(data["name"] ==name)
    {
      return value;
    }
  }

  return -1;
}

Future<int> database_get_score_total() async
{
  Database database_db = await database_open();

  final score_total = Sqflite.firstIntValue(await database_db.rawQuery(
    'select sum(value)/count(*) from scores where name!=?',
    ['total']
  ));

  if(score_total==null)
  {
    return -1;
  }
  else
  {
    return score_total;
  }
}

Future<int> database_insert_score(
  String name,
  int value
) async
{
  Database database_db = await database_open();

  int row_index = await database_db.insert(
    "scores",
    {
      'name': name,
      'value': value,
    },
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
  database_print("Row index: ${row_index}");
  return row_index;
}

Future<int> database_delete_score() async
{
  Database database_db = await database_open();

  int row_index = await database_db.delete(
    "scores",
  );
  database_print("Deleted $row_index");
  return row_index;
}

// Goals
Future<int> database_get_goal(String name) async
{
  Database database_db = await database_open();

  final List<Map<String, dynamic>> data_recommendations_map = await database_db.query(
    'goals',
    columns: ['name', 'value']
  );

  for(var data in data_recommendations_map)
  {
    final value = data["value"] as int;
    if(data["name"] ==name)
    {
      return value;
    }
  }

  return -1;
}

Future<int> database_set_goal(
  String name,
  String value
) async
{
  Database database_db = await database_open();

  int row_index = await database_db.insert(
    "goals",
    {
      'name': name,
      'value': int.parse(value),
    },
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
  database_print("Row index: ${row_index}");
  return row_index;
}

Future<bool> database_isempty_goals() async
{
  Database database_db = await database_open();

  int? row_index = Sqflite.firstIntValue(await database_db.rawQuery(
    'select count(*) from goals'
  ));
  return row_index==0;
}

Future<int> database_delete_goals() async
{
  Database database_db = await database_open();

  int row_index = await database_db.delete(
    "goals",
  );
  database_print("Deleted $row_index");
  return row_index;
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

Future<int> database_get_absent_total() async
{
  Database database_db = await database_open();

  final result = Sqflite.firstIntValue(await database_db.rawQuery(
    'select count(*) from academics_absent',
  ));

  if(result==null)
  {
    return -1;
  }
  else
  {
    return result;
  }
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
  database_print("Row index: ${row_index}");
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

Future<int> database_get_assignments_not_submitted_total() async
{
  Database database_db = await database_open();

  final result = Sqflite.firstIntValue(await database_db.rawQuery(
    'select count(*) from academics_assignment where submitted!=?',
    [1]
  ));

  if(result==null)
  {
    return -1;
  }
  else
  {
    return result;
  }
}

Future<int> database_get_assignments_submitted_total() async
{
  Database database_db = await database_open();

  final result = Sqflite.firstIntValue(await database_db.rawQuery(
    'select count(*) from academics_assignment where submitted=?',
    [1]
  ));

  if(result==null)
  {
    return -1;
  }
  else
  {
    return result;
  }
}

Future<int> database_get_assignments_total() async
{
  Database database_db = await database_open();

  final result = Sqflite.firstIntValue(await database_db.rawQuery(
    'select count(*) from academics_assignment',
  ));

  if(result==null)
  {
    return -1;
  }
  else
  {
    return result;
  }
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
  database_print("Row index: ${row_index}");
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
  database_print("Row index: ${row_index}");
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
  database_print("Row index: ${row_index}");
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
  database_print("Row index: ${row_index}");
  return row_index;
}

// Body measurements

// Data display for body measurements page
Future<List<BodyMeasurementData>> database_get_bodymeasurement() async
{
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
  return data_bodymeasurements_list;
}


Future<List<BodyMeasurementData>> database_get_bodymeasurement_from_id(int id) async
{
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
  return data_bodymeasurements_list;
}

// Data display for body measurements page
Future<List<BodyMeasurementData>> database_get_bodymeasurement_for_date(DateTime target_date) async
{
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
  database_print("Row index: ${row_index}");
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

Future<List<MindMoodData>> database_get_mind_mood_unresolved() async
{
  Database database_db = await database_open();

  final List<Map<String, dynamic>> data_mind_mood_map = await database_db.query(
    'mind_mood',
    columns: ['id', 'name', 'intensity', 'resolved', 'end_date', 'entry_date', 'entry_note'],
  );

  List<MindMoodData> data_mind_mood_list = [];

  for(var data in data_mind_mood_map)
  {
    if(data["resolved"]!=1)
    {
      data_mind_mood_list.add(
        MindMoodData(
          data["id"],
          data["name"],
          data["intensity"],
          false,
          DateTime.tryParse(data["end_date"]),
          DateTime.parse(data["entry_date"]),
          data["entry_note"],
        )
      );
    }
  }

  return data_mind_mood_list;
}

Future<int> database_get_mind_mood_tracking_total() async
{
  Database database_db = await database_open();

  final result = Sqflite.firstIntValue(await database_db.rawQuery(
    'select count(*) from mind_mood where resolved!=?',
    [1]
  ));

  if(result==null)
  {
    return -1;
  }
  else
  {
    return result;
  }
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

  database_print("Replacing {$id}");

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
  database_print("Row index: ${row_index}");
  return row_index;
}

Future<int> database_mind_mood_resolve(int id) async
{
  Database database_db = await database_open();

  int row_index = await database_db.update(
    "mind_mood",
    {
      'resolved':1,
    },
    where: 'id = ?',
    whereArgs: [id],
  );
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

Future<List<SymptomData>> database_get_symptom_for_date(DateTime target_date) async
{
  Database database_db = await database_open();
  String _target_date = DateFormat('yyyy-MM-dd').format(target_date);

  final List<Map<String, dynamic>> data_symptom_map = await database_db.query(
    'symptom',
    columns: ['id', 'name', 'intensity', 'resolved', 'end_date', 'entry_date', 'entry_note'],
    where: 'date(entry_date) = ?',
    whereArgs: [_target_date],
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

Future<List<SymptomData>> database_get_symptom_unresolved() async
{
  Database database_db = await database_open();

  final List<Map<String, dynamic>> data_symptom_map = await database_db.query(
    'symptom',
    columns: ['id', 'name', 'intensity', 'resolved', 'end_date', 'entry_date', 'entry_note']
  );

  List<SymptomData> data_symptom_list = [];

  for(var data in data_symptom_map)
  {
    if(data["resolved"]!=1)
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
  }

  return data_symptom_list;
}


Future<int> database_get_symptom_tracking_total() async
{
  Database database_db = await database_open();

  final result = Sqflite.firstIntValue(await database_db.rawQuery(
    'select count(*) from symptom where resolved!=?',
    [1]
  ));

  if(result==null)
  {
    return -1;
  }
  else
  {
    return result;
  }
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
  String intensity,
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

Future<int> database_symptom_resolve(int id) async
{
  Database database_db = await database_open();

  int row_index = await database_db.update(
    "symptom",
    {
      'resolved':1,
    },
    where: 'id = ?',
    whereArgs: [id],
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
    columns: ['id', 'event', 'duration', 'entry_date', 'start_datetime', 'end_datetime', 'entry_note'],
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
        DateTime.parse(data["start_datetime"]),
        DateTime.parse(data["end_datetime"]),
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
    columns: ['id', 'event', 'duration', 'entry_date', 'start_datetime', 'end_datetime', 'entry_note'],
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
        DateTime.parse(data["start_datetime"]),
        DateTime.parse(data["end_datetime"]),
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
    columns: ['id', 'event', 'duration', 'entry_date', 'start_datetime', 'end_datetime', 'entry_note'],
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
        DateTime.parse(data["entry_date"]),
        DateTime.parse(data["start_datetime"]),
        DateTime.parse(data["end_datetime"]),
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


Future<List<TimeData>> database_get_time_sleep_date_range(DateTime start_date, DateTime end_date) async
{
  Database database_db = await database_open();

  String _start_date = DateFormat('yyyy-MM-dd').format(start_date);
  String _end_date = DateFormat('yyyy-MM-dd').format(end_date);

  //database_print("${_start_date} and ${_end_date}");

  final List<Map<String, dynamic>> data_time_map = await database_db.rawQuery('select * from time where event = ? and date(entry_date) between date(?) and date(?)', ["Sleep", _start_date, _end_date]);

  List<TimeData> data_time_list = [];

  for(var data in data_time_map)
  {
    data_time_list.add(
      TimeData(
        data["id"],
        data["event"],
        data["duration"],
        DateTime.parse(data["entry_date"]),
        DateTime.parse(data["start_datetime"]),
        DateTime.parse(data["end_datetime"]),
        data["entry_note"],
      )
    );
  }

  return data_time_list;
}

Future<int> database_insert_time(
  String event,
  int duration,
  String entry_date,
  String start_datetime,
  String end_datetime,
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
      'start_datetime':start_datetime,
      'end_datetime':end_datetime,
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

Future<int> database_get_vitals_total_for_date(DateTime target_date) async
{
  Database database_db = await database_open();
  String _target_date = DateFormat('yyyy-MM-dd').format(target_date);

  final result = Sqflite.firstIntValue(await database_db.rawQuery(
    'select count(distinct type) from symptom where date(entry_date) = ?',
    [_target_date],
  ));

  if(result==null)
  {
    return -1;
  }
  else
  {
    return result;
  }
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
      if(id!=-1) "id": id,
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
    //database_print((data_aggregate.first['total'] as num).toInt());
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
    //database_print((data_aggregate.first['total'] as num).toInt());
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
    //database_print((data_aggregate.first['total'] as num).toInt());
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

  //database_print("$table_name: got ${database_result.length} rows");

  for (var row in database_result)
  {
    String value = row["value"].toString();
    DateTime entry_date = DateTime.parse(row["entry_date"] as String);
    //print("$value, $entry_date");
    data_graphvalues.add(GraphData(value, entry_date));
  }

  return data_graphvalues;
}
