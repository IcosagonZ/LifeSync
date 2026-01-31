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
'''

rowise_columns = []
for table in tables:
    table_columns = []
    for column in table[1]:
        if(column=='' or column=='\n'):
            pass
        else:
            table_columns.append(column[0])
    rowise_columns.append(table_columns)

#insert
i = 0
for table in tables:
    print("Future<List<TABLENAMEData> database_insert_" + table[0] + "() async")
    print("{")
    print("  Database database_db = await database_open();\n")
    print("  final List<Map<String, dynamic>> data_{}_map = await database_db.query('{}', columns: {});".format(table[0], table[0], rowise_columns[i]))
    print()
    print("  List<TABLENAMEData> data_{}_list = [];".format(table[0]))
    print()
    print("  for(var data in data_{}_map)".format(table[0]))
    print("  {")
    print("    data_{}_list.add(".format(table[0]))
    print("      TABLENAMEData(")
    for column in table[1]:
        if(column=='' or column=='\n'):
            pass
        else:
            print('        data["{}"],'.format(column[0], column[0]))
    print("    )")
    print("  );")
    print("}")
    print()
    i+=1

'''
Future<List<AcademicsAbsentData> database_insert_academics_absent() async
{
  Database database_db = await database_open();

  final List<Map<String, dynamic>> data_academics_absent_map = await database_db.query('academics_absent', columns: ['reason', 'absent_date', 'entry_date', 'entry_note']);

  List<AcademicsAbsentData> data_academics_absent_list = [];

  for(var data in data_academics_absent_map)
  {
    data_academics_absent_list.add(
      AcademicsAbsentData(
        data["reason"],
        data["absent_date"],
        data["entry_date"],
        data["entry_note"],
      )
    );
  }
}

Future<List<AcademicsAssignmentData> database_insert_academics_assignment() async
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
        data["due_date"],
        data["submission_date"],
        data["entry_date"],
        data["entry_note"],
      )
    );
  }
}

Future<List<AcademicsExamData> database_insert_academics_exam() async
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
        data["exam_date"],
        data["duration"],
        data["entry_date"],
        data["entry_note"],
      )
    );
  }
}

Future<List<AcademicsMarkData> database_insert_academics_mark() async
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
        data["entry_date"],
        data["entry_note"],
      )
    );
  }
}

Future<List<ActivityData> database_insert_activity() async
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
        data["entry_date"],
        data["entry_note"],
      )
    );
  }
}

Future<List<BodyMeasurementData> database_insert_body_measurement() async
{
  Database database_db = await database_open();

  final List<Map<String, dynamic>> data_body_measurement_map = await database_db.query('body_measurement', columns: ['type', 'value', 'unit', 'entry_date', 'entry_note']);

  List<BodyMeasurementData> data_body_measurement_list = [];

  for(var data in data_body_measurement_map)
  {
    data_body_measurement_list.add(
      BodyMeasurementData(
        data["type"],
        data["value"],
        data["unit"],
        data["entry_date"],
        data["entry_note"],
      )
    );
  }
}

Future<List<MindMoodData> database_insert_mind_mood() async
{
  Database database_db = await database_open();

  final List<Map<String, dynamic>> data_mind_mood_map = await database_db.query('mind_mood', columns: ['name', 'intensity', 'resolved', 'end_date', 'entry_date', 'entry_note']);

  List<MindMoodData> data_mind_mood_list = [];

  for(var data in data_mind_mood_map)
  {
    data_mind_mood_list.add(
      MindMoodData(
        data["name"],
        data["intensity"],
        data["resolved"],
        data["end_date"],
        data["entry_date"],
        data["entry_note"],
      )
    );
  }
}

Future<List<NoteData> database_insert_note() async
{
  Database database_db = await database_open();

  final List<Map<String, dynamic>> data_note_map = await database_db.query('note', columns: ['title', 'content', 'tags', 'entry_date']);

  List<NoteData> data_note_list = [];

  for(var data in data_note_map)
  {
    data_note_list.add(
      NoteData(
        data["title"],
        data["content"],
        data["tags"],
        data["entry_date"],
      )
    );
  }
}

Future<List<NutritionData> database_insert_nutrition() async
{
  Database database_db = await database_open();

  final List<Map<String, dynamic>> data_nutrition_map = await database_db.query('nutrition', columns: ['name', 'form', 'type', 'qty', 'calories', 'mass', 'carbs', 'protein', 'fats', 'entry_date', 'entry_note\n']);

  List<NutritionData> data_nutrition_list = [];

  for(var data in data_nutrition_map)
  {
    data_nutrition_list.add(
      NutritionData(
        data["name"],
        data["form"],
        data["type"],
        data["qty"],
        data["calories"],
        data["mass"],
        data["carbs"],
        data["protein"],
        data["fats"],
        data["entry_date"],
        data["entry_note"],
      )
    );
  }
}

Future<List<SymptomData> database_insert_symptom() async
{
  Database database_db = await database_open();

  final List<Map<String, dynamic>> data_symptom_map = await database_db.query('symptom', columns: ['name', 'intensity', 'resolved', 'end_date', 'entry_date', 'entry_note']);

  List<SymptomData> data_symptom_list = [];

  for(var data in data_symptom_map)
  {
    data_symptom_list.add(
      SymptomData(
        data["name"],
        data["intensity"],
        data["resolved"],
        data["end_date"],
        data["entry_date"],
        data["entry_note"],
      )
    );
  }
}

Future<List<TimeData> database_insert_time() async
{
  Database database_db = await database_open();

  final List<Map<String, dynamic>> data_time_map = await database_db.query('time', columns: ['event', 'duration', 'entry_date', 'entry_note']);

  List<TimeData> data_time_list = [];

  for(var data in data_time_map)
  {
    data_time_list.add(
      TimeData(
        data["event"],
        data["duration"],
        data["entry_date"],
        data["entry_note"],
      )
    );
  }
}

Future<List<VitalsData> database_insert_vitals() async
{
  Database database_db = await database_open();

  final List<Map<String, dynamic>> data_vitals_map = await database_db.query('vitals', columns: ['type', 'value', 'unit', 'entry_date', 'entry_note']);

  List<VitalsData> data_vitals_list = [];

  for(var data in data_vitals_map)
  {
    data_vitals_list.add(
      VitalsData(
        data["type"],
        data["value"],
        data["unit"],
        data["entry_date"],
        data["entry_note"],
      )
    );
  }
}

Future<List<WorkoutData> database_insert_workout() async
{
  Database database_db = await database_open();

  final List<Map<String, dynamic>> data_workout_map = await database_db.query('workout', columns: ['name', 'type', 'duration', 'calories', 'reps', 'weight', 'entry_date', 'entry_note']);

  List<WorkoutData> data_workout_list = [];

  for(var data in data_workout_map)
  {
    data_workout_list.add(
      WorkoutData(
        data["name"],
        data["type"],
        data["duration"],
        data["calories"],
        data["reps"],
        data["weight"],
        data["entry_date"],
        data["entry_note"],
      )
    );
  }
}
'''
