import 'package:flutter/material.dart';

import '../data/database.dart';

import 'misc/nutrition_image_recognition.dart';

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

class Page_AddData extends StatefulWidget
{
  const Page_AddData({super.key});

  @override
  State<Page_AddData> createState() => Page_AddData_State();
}

class Page_AddData_State extends State<Page_AddData>
{
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
  DateTime? _data_time_chosen;
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

  // Move to seperate file
  SnackBar notify_snackbar(String message)
  {
    return SnackBar(
      content: Text(
        message,
        style: TextStyle(
          color:Color.fromRGBO(250, 250, 250, 1)
        ),
      ),
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      backgroundColor: Color.fromRGBO(33, 33, 33, 1),
      closeIconColor: Color.fromRGBO(250, 250, 250, 1),
    );
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

  Future<void> data_time_select(BuildContext context) async
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
      setState(()
      {
        data_time_chosen = picked_time;
        _data_time_chosen = DateTime(2025, 5, 15, picked_time.hour, picked_time.minute);
      }
      );
    }
  }

  Future<DateTime?> data_date_select(BuildContext context) async
  {
    final DateTime? picked_date = await showDatePicker
    (
      context: context,
      initialDate: data_date_chosen ?? DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime.now(),
    );

    if(picked_date != null && picked_date != data_date_chosen)
    {
      return picked_date;
    }

    return null;
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

    return Scaffold(
      appBar: AppBar(
        title: Text("Add data"),
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
                      print(datatype_dropdown_chosen);
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
                  onPressed: (){
                    data_time_select(context);
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
              getAddDataButton(),
            ]
          )
        )
      ),
    );
  }
}
