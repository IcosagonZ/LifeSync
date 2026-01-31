f = open("table_main.csv")

rows = f.readlines()
no_rows = len(rows)
no_tables = len(rows)/3

tables = []

for i in range(0, no_rows, 3):
    columns_current = []
    datatypes_current = []

    table_name = rows[i].split(",")[0]

    columns = rows[i+1].split(",")
    datatypes = rows[i+2].split(",")

    # Ignore empty columns and \n
    i = 0
    for column in columns:
        if(column=='' or column=='\n'):
            pass
        else:
            c_name = column
            c_type = datatypes[i]

            columns_current.append([c_name, c_type])

        i+=1
    tables.append([table_name, columns_current])

'''
Future<int> database_insert_bodymeasurements(
  String measurement_type,
  String value,
  String unit,
  DateTime entry_date,
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
      'entry_date':entry_date.toIso8601String(),
      'entry_note':entry_note,
    }
  );

  return row_index;
}
'''

#insert
for table in tables:
    print("Future<int> database_insert_" + table[0] + "(")
    for column in table[1]:
        print("  ", end="")
        # datatype
        if(column[1]=="text"):
            print("String ",end="")
        elif(column[1]=="real"):
            print("Double ",end="")
        elif(column[1]=="integer"):
            print("int ",end="")
        print(column[0],end=",\n")
    print(") async")
    print("{")
    print("  Database database_db = await database_open();\n")
    print("  int row_index = await database_db.insert(")
    print('    "{}"'.format(table[0]))
    print("    {")
    for column in table[1]:
        if(column=='' or column=='\n'):
            pass
        else:
            print("      '{}':{},".format(column[0], column[0]))
    print("    }")
    print("  );")
    print("  return row_index;")
    print("}")
    print()

'''
Future<int> database_insert_academics_absent(
  String reason,
  String absent_date,
  String entry_date,
  String entry_note,
) async
{
  Database database_db = await database_open();

  int row_index = await database_db.insert(
    "academics_absent"
    {
      'reason':reason,
      'absent_date':absent_date,
      'entry_date':entry_date,
      'entry_note':entry_note,
    }
  );
  return row_index;
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
    "academics_assignment"
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
  return row_index;
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
    "academics_exam"
    {
      'subject':subject,
      'type':type,
      'exam_date':exam_date,
      'duration':duration,
      'entry_date':entry_date,
      'entry_note':entry_note,
    }
  );
  return row_index;
}

Future<int> database_insert_academics_mark(
  String subject,
  String type,
  Double marks,
  Double marks_total,
  String entry_date,
  String entry_note,
) async
{
  Database database_db = await database_open();

  int row_index = await database_db.insert(
    "academics_mark"
    {
      'subject':subject,
      'type':type,
      'marks':marks,
      'marks_total':marks_total,
      'entry_date':entry_date,
      'entry_note':entry_note,
    }
  );
  return row_index;
}

Future<int> database_insert_activity(
  String name,
  int duration,
  int distance,
  Double calories,
  String entry_date,
  String entry_note,
) async
{
  Database database_db = await database_open();

  int row_index = await database_db.insert(
    "activity"
    {
      'name':name,
      'duration':duration,
      'distance':distance,
      'calories':calories,
      'entry_date':entry_date,
      'entry_note':entry_note,
    }
  );
  return row_index;
}

Future<int> database_insert_body_measurement(
  String type,
  Double value,
  String unit,
  String entry_date,
  String entry_note,
) async
{
  Database database_db = await database_open();

  int row_index = await database_db.insert(
    "body_measurement"
    {
      'type':type,
      'value':value,
      'unit':unit,
      'entry_date':entry_date,
      'entry_note':entry_note,
    }
  );
  return row_index;
}

Future<int> database_insert_mind_mood(
  String name,
  String intensity,
  int resolved,
  String end_date,
  String entry_date,
  String entry_note,
) async
{
  Database database_db = await database_open();

  int row_index = await database_db.insert(
    "mind_mood"
    {
      'name':name,
      'intensity':intensity,
      'resolved':resolved,
      'end_date':end_date,
      'entry_date':entry_date,
      'entry_note':entry_note,
    }
  );
  return row_index;
}

Future<int> database_insert_note(
  String title,
  String content,
  String tags,
  String entry_date,
) async
{
  Database database_db = await database_open();

  int row_index = await database_db.insert(
    "note"
    {
      'title':title,
      'content':content,
      'tags':tags,
      'entry_date':entry_date,
    }
  );
  return row_index;
}

Future<int> database_insert_nutrition(
  String name,
  String form,
  String type,
  Double qty,
  Double calories,
  Double mass,
  Double carbs,
  Double protein,
  Double fats,
  String entry_date,
  String entry_note,
) async
{
  Database database_db = await database_open();

  int row_index = await database_db.insert(
    "nutrition"
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
    }
  );
  return row_index;
}

Future<int> database_insert_symptom(
  String name,
  int intensity,
  int resolved,
  String end_date,
  String entry_date,
  String entry_note,
) async
{
  Database database_db = await database_open();

  int row_index = await database_db.insert(
    "symptom"
    {
      'name':name,
      'intensity':intensity,
      'resolved':resolved,
      'end_date':end_date,
      'entry_date':entry_date,
      'entry_note':entry_note,
    }
  );
  return row_index;
}

Future<int> database_insert_time(
  String event,
  int duration,
  String entry_date,
  String entry_note,
) async
{
  Database database_db = await database_open();

  int row_index = await database_db.insert(
    "time"
    {
      'event':event,
      'duration':duration,
      'entry_date':entry_date,
      'entry_note':entry_note,
    }
  );
  return row_index;
}

Future<int> database_insert_vitals(
  String type,
  String value,
  String unit,
  String entry_date,
  String entry_note,
) async
{
  Database database_db = await database_open();

  int row_index = await database_db.insert(
    "vitals"
    {
      'type':type,
      'value':value,
      'unit':unit,
      'entry_date':entry_date,
      'entry_note':entry_note,
    }
  );
  return row_index;
}

Future<int> database_insert_workout(
  String name,
  String type,
  int duration,
  Double calories,
  int reps,
  Double weight,
  String entry_date,
  String entry_note,
) async
{
  Database database_db = await database_open();

  int row_index = await database_db.insert(
    "workout"
    {
      'name':name,
      'type':type,
      'duration':duration,
      'calories':calories,
      'reps':reps,
      'weight':weight,
      'entry_date':entry_date,
      'entry_note':entry_note,
    }
  );
  return row_index;
}

'''
