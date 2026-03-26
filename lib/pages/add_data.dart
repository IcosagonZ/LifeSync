import 'package:flutter/material.dart';

import '../data/database.dart';

import 'misc/nutrition_image_recognition.dart';
import '../components/snackbar_notify.dart';

// Model files (data class) for use by modify_data part
import '../data/models/academics_absent.dart';
import '../data/models/academics_assignment.dart';
import '../data/models/academics_exam.dart';
import '../data/models/academics_mark.dart';
import '../data/models/activity.dart';
import '../data/models/body_measurement.dart';
import '../data/models/mind_mood.dart';
import '../data/models/note.dart';
import '../data/models/nutrition.dart';
import '../data/models/symptom.dart';
import '../data/models/time.dart';
import '../data/models/vitals.dart';
import '../data/models/workout.dart';

// Widget parts
part 'add_data_parts/academics_absent.part.dart';
part 'add_data_parts/academics_assignment.part.dart';
part 'add_data_parts/academics_exam.part.dart';
part 'add_data_parts/academics_marks.part.dart';
part 'add_data_parts/activity.part.dart';
part 'add_data_parts/bodymeasurements.part.dart';
part 'add_data_parts/mind.part.dart';
part 'add_data_parts/nutrition.part.dart';
part 'add_data_parts/symptom.part.dart';
part 'add_data_parts/time.part.dart';
part 'add_data_parts/vitals.part.dart';
part 'add_data_parts/workout.part.dart';

part 'add_data_parts/add_data_button.part.dart';
part 'add_data_parts/modify_data.part.dart';
part 'add_data_parts/insert_data.part.dart';

class Page_AddData extends StatefulWidget
{
  const Page_AddData({super.key});

  @override
  State<Page_AddData> createState() => Page_AddData_State();
}

class Page_AddData_State extends State<Page_AddData>
{
  // Misc variables
  bool isInitialized = false;

  int dataId = -1;
  String dataType = "N/A";
  var add_data_text = "Add data"; // It will be add data / update data

  // Datatype variables
  final List<String> datatype_dropdown_options = [
    "Academics", // Contains 4 subcategories
    "Activity",
    "Body Measurements",
    "Mind",
    "Nutrition",
    "Symptom",
    "Time",
    "Vitals",
    "Workout",
  ];
  String? datatype_dropdown_chosen;

  // Time and date variables
  DateTime data_datetime = DateTime.now();

  TimeOfDay? data_time_chosen;
  //DateTime? _data_time_chosen;
  DateTime? data_date_chosen;

  // Controllers
  // Common controllers
  final TextEditingController general_notes_controller = TextEditingController();

  // Academic controllers
  final List<String> academics_dropdown_options = [
    "Absent",
    "Assignment",
    "Exam",
    "Marks",
  ];
  String? academics_dropdown_chosen;

  // Common to assignment, absent, exam and marks (type not required for absent)
  final TextEditingController academics_subject_controller = TextEditingController();
  final TextEditingController academics_type_controller = TextEditingController();

  @override
  void initState()
  {
    super.initState();

    data_time_chosen = TimeOfDay.now();
    data_date_chosen = DateTime.now();
  }

  // Also move this to seperate file
  bool isNumeric(String s)
  {
    if(s.isEmpty)
    {
      return false;
    }
    else
    {
      return double.tryParse(s)!=null;
    }
  }

  Future<TimeOfDay?> data_time_select(BuildContext context) async
  {
    final TimeOfDay? picked_time = await showTimePicker
    (
      context: context,
      initialTime: data_time_chosen ?? TimeOfDay.now(),
      builder: (BuildContext context, Widget? child)
      {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      }
    );

    if(picked_time != null && picked_time != data_time_chosen)
    {
      return picked_time;
    }

    return null;
  }

  Future<DateTime?> data_date_select(BuildContext context) async
  {
    final DateTime? picked_date = await showDatePicker
    (
      context: context,
      initialDate: data_date_chosen ?? DateTime.now(),
      firstDate: DateTime(data_datetime.year-1),
      lastDate: DateTime(data_datetime.year+1),
    );

    if(picked_date != null && picked_date != data_date_chosen)
    {
      return picked_date;
    }

    return null;
  }

  // Duration calculator for time page
  void time_calculate_duration()
  {
    if(data_time_start_chosen!=null &&
      data_time_end_chosen!=null &&
      data_time_start_date!=null &&
      data_time_end_date!=null
    )
    {
      // Set combined date time
      final start_datetime = DateTime(
        data_time_start_date!.year,
        data_time_start_date!.month,
        data_time_start_date!.day,
        data_time_start_chosen!.hour,
        data_time_start_chosen!.minute,
      );
      final end_datetime = DateTime(
        data_time_end_date!.year,
        data_time_end_date!.month,
        data_time_end_date!.day,
        data_time_end_chosen!.hour,
        data_time_end_chosen!.minute,
      );
      final duration = end_datetime.difference(start_datetime);
      if(!duration.isNegative)
      {
        int mins = duration.inMinutes;
        int hrs = mins~/60;
        mins -= hrs*60;

        setState(()
        {
          time_duration_hours_controller.text = hrs.toString();
          time_duration_minutes_controller.text = mins.toString();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context)
  {
    // Widget style variables
    final text_theme = Theme.of(context).textTheme;
    final style_displaylarge = text_theme.displayLarge;
    final style_displaymedium = text_theme.displayMedium;
    final style_displaysmall = text_theme.displaySmall;

    final style_headlinelarge = text_theme.headlineLarge;
    final style_headlinemedium = text_theme.headlineMedium;
    final style_headlinesmall = text_theme.headlineSmall;

    final style_titlelarge = text_theme.titleLarge;
    final style_titlemedium = text_theme.titleMedium;
    final style_titlesmall = text_theme.titleSmall;

    final _arguments = ModalRoute.of(context)?.settings.arguments;
    // If we are modifying existing data
    if(!isInitialized && _arguments is List<String> && _arguments!=null){
      final arguments = _arguments as List;
      isInitialized = true;

      dataId = arguments[0];
      dataType = arguments[1];

      //print(dataId);

      if(dataId!=-1)
      {
        setState(()
        {
          add_data_text = "Update data";
        }
        );
      }

      modifyData(arguments);
    }
    else if(!isInitialized && _arguments is String && _arguments!=null){
      final arguments = _arguments as String;
      isInitialized = true;

      insertData(arguments);
    }


    return Scaffold(
      appBar: AppBar(
        title: Text(add_data_text),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children:[
            // Data type choser
            Row(
              children: [
                Expanded(
                  child: Text("Data type")
                ),
                DropdownButton<String>(
                  hint: Text("Select data type"),
                  value: datatype_dropdown_chosen,
                  onChanged: (String? newValue)
                  {
                    setState(()
                    {
                      datatype_dropdown_chosen = newValue;

                      // Reset id variable
                      setState(()
                      {
                        dataId = -1;
                        add_data_text = "Add data";
                      });

                      //print(datatype_dropdown_chosen);
                    });
                  },
                  items: datatype_dropdown_options.map<DropdownMenuItem<String>>((String dropdown_item)
                  {
                    return DropdownMenuItem<String>(
                      value: dropdown_item,
                      child: Text(dropdown_item)
                    );
                  }
                  ).toList(),
                )
              ],
            ),
            SizedBox(height: 16),

            // Time choser
            Row(
              children: [
                Expanded(
                  child: Text("Time")
                ),
                ActionChip(
                  label: Text(data_time_chosen == null
                    ? "Select time"
                    : "${data_time_chosen!.format(context)}"
                  ),
                  onPressed: () async
                  {
                    final time_chosen = await data_time_select(context);;
                    setState(()
                    {
                      if(time_chosen!=null)
                      {
                        data_time_chosen = time_chosen;
                      }
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 16),

            // Date choser
            Row(
              children: [
                Expanded(
                  child: Text("Date")
                ),
                ActionChip(
                  label: Text(data_date_chosen == null
                  ? "Select date"
                  : "${data_date_chosen!.toLocal()}".split(" ")[0],
                  ),
                  onPressed: () async{
                    final date_chosen = await data_date_select(context);
                    setState(()
                    {
                      if(date_chosen!=null)
                      {
                        data_date_chosen = date_chosen;
                      }
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 16),

            Divider(),

            SizedBox(height: 16),

            // Academics data entry
            Visibility(
              visible: datatype_dropdown_chosen=="Academics",
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text("Subtype")
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 100,
                        ),
                        child: DropdownButton<String>(
                          hint: Text("Select..."),
                          value: academics_dropdown_chosen,
                          onChanged: (String? newValue)
                          {
                            setState(()
                            {
                              academics_dropdown_chosen = newValue;
                              print(academics_dropdown_chosen);
                            });
                          },
                          items: academics_dropdown_options.map<DropdownMenuItem<String>>((String dropdown_item)
                          {
                            return DropdownMenuItem<String>(
                              value: dropdown_item,
                              child: Text(dropdown_item)
                            );
                          }
                          ).toList(),
                        ),
                      ),
                    ]
                  ),
                  // Absent
                  getAcademicsAbsentWidget(),

                  // Assignment
                  getAcademicsAssignmentWidget(),

                  // Exam
                  getAcademicsExamWidget(),

                  // Marks
                  getAcademicsMarksWidget(),

                  SizedBox(height: 16),
                  Divider(),
                ]
              )
            ),

            // Activity data entry
            getActivityWidget(),

            // Body measurements data entry
            getBodyMeasurementsWidget(),

            // Mind data entry
            getMindWidget(),

            // Nutrition data entry
            getNutritionWidget(),

            // Symptom data entry
            getSymptomWidget(),

            // Time data entry
            getTimeWidget(),

            // Vital data entry
            getVitalsWidget(),

            // Workout data entry
            getWorkoutWidget(),

            // Notes
            SizedBox(height: 16),
            IntrinsicHeight(
              child: TextField(
                controller: general_notes_controller,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: "Note",
                  hintText: "Enter note",
                ),
                maxLines: null,
              ),
            ),
          ]
        )
      ),

      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Visibility(
                visible: datatype_dropdown_chosen=="Nutrition",
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      child: Text("Add image"),
                      onPressed: () async{
                        print("Add image pressed");
                        final result = await Navigator.push(context, MaterialPageRoute(builder: (context)
                        {
                          return const Page_NutritionImageRecognition();
                        }
                        ));
                        if(result!=null)
                        {
                          //print("Result: $result");
                          nutrition_name_controller.text = result["name"];
                          nutrition_calories_controller.text = result["calories"];
                        }
                      },
                    ),
                    SizedBox(height: 16),
                  ]
                )
              ),
              Visibility(
                visible: dataId!=-1 && dataType!="N/A",
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ElevatedButton(
                      child: Text("Delete data"),
                      onPressed: () async{
                        //print("Delete data pressed");
                        final result = await database_delete_row_from_id(dataType, dataId);
                        if(result>0)
                        {
                          ScaffoldMessenger.of(context).showSnackBar(notify_snackbar("Data deleted"));
                          Navigator.pop(context, "refresh");
                        }
                        else
                        {
                          ScaffoldMessenger.of(context).showSnackBar(notify_snackbar("Data deletion error"));
                        }
                        //print("Deleted $result rows");
                      },
                    ),
                    SizedBox(height: 16),
                  ]
                )
              ),
              getAddDataButton(),
            ]
          )
        )
      ),
    );
  }
}
