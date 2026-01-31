'''
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


'''

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

#for t in tables:
#    print(t)

'''
class BodyMeasurementData{
  String measurement_type;
  double value;
  String unit;
  DateTime entry_date;
  String entry_note;

  BodyMeasurementData(this.measurement_type, this.value, this.unit, this.entry_date, this.entry_note);
}
'''

#class
for table in tables:
    tablename = table[0][0].upper() + table[0][1::] + "Data"
    this_s = tablename + "("
    print("class " + table[0] + "{")
    for column in table[1]:
        print("  ", end="")
        # datatype
        if(column[1]=="text"):
            print("String ",end="")
        elif(column[1]=="real"):
            print("Double ",end="")
        elif(column[1]=="integer"):
            print("int ",end="")
        print(column[0],end=";\n")

        this_s += "this.{}, ".format(column[0])
    print()
    this_s = this_s[:-2] + ");"
    print("  " + this_s)
    print("}")
    print()

'''
class AcademicsAbsentData{
  String reason;
  String absent_date;
  String entry_date;
  String entry_note;

  AcademicsAbsentData(this.reason, this.absent_date, this.entry_date, this.entry_note);
}

class AcademicsAssignmentData{
  String subject;
  String type;
  String topic;
  int submitted;
  String due_date;
  String submission_date;
  String entry_date;
  String entry_note;

  AcademicsAssignmentData(this.subject, this.type, this.topic, this.submitted, this.due_date, this.submission_date, this.entry_date, this.entry_note);
}

class AcademicsExamData{
  String subject;
  String type;
  String exam_date;
  int duration;
  String entry_date;
  String entry_note;

  AcademicsExamData(this.subject, this.type, this.exam_date, this.duration, this.entry_date, this.entry_note);
}

class AcademicsMarkData{
  String subject;
  String type;
  Double marks;
  Double marks_total;
  String entry_date;
  String entry_note;

  AcademicsMarkData(this.subject, this.type, this.marks, this.marks_total, this.entry_date, this.entry_note);
}

class ActivityData{
  String name;
  int duration;
  int distance;
  Double calories;
  String entry_date;
  String entry_note;

  ActivityData(this.name, this.duration, this.distance, this.calories, this.entry_date, this.entry_note);
}

class BodyMeasurementData{
  String type;
  Double value;
  String unit;
  String entry_date;
  String entry_note;

  BodyMeasurementData(this.type, this.value, this.unit, this.entry_date, this.entry_note);
}

class MindMoodData{
  String name;
  String intensity;
  int resolved;
  String end_date;
  String entry_date;
  String entry_note;

  MindMoodData(this.name, this.intensity, this.resolved, this.end_date, this.entry_date, this.entry_note);
}

class NoteData{
  String title;
  String content;
  String tags;
  String entry_date;

  NoteData(this.title, this.content, this.tags, this.entry_date);
}

class NutritionData{
  String name;
  String form;
  String type;
  Double qty;
  Double calories;
  Double mass;
  Double carbs;
  Double protein;
  Double fats;
  String entry_date;
  String entry_note;

  NutritionData(this.name, this.form, this.type, this.qty, this.calories, this.mass, this.carbs, this.protein, this.fats, this.entry_date, this.entry_note);
}

class SymptomData{
  String name;
  int intensity;
  int resolved;
  String end_date;
  String entry_date;
  String entry_note;

  SymptomData(this.name, this.intensity, this.resolved, this.end_date, this.entry_date, this.entry_note);
}

class TimeData{
  String event;
  int duration;
  String entry_date;
  String entry_note;

  TimeData(this.event, this.duration, this.entry_date, this.entry_note);
}

class Vitals{
  String type;
  String value;
  String unit;
  String entry_date;
  String entry_note;

  VitalsData(this.type, this.value, this.unit, this.entry_date, this.entry_note);
}

class WorkoutData{
  String name;
  String type;
  int duration;
  Double calories;
  int reps;
  Double weight;
  String entry_date;
  String entry_note;

  WorkoutData(this.name, this.type, this.duration, this.calories, this.reps, this.weight, this.entry_date, this.entry_note);
}

'''
