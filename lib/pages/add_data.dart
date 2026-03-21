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

  // Absent
  final TextEditingController academics_absent_reason_controller = TextEditingController();
  DateTime academics_absent_date = DateTime.now();

  // Assignment
  final TextEditingController academics_assignment_topic_controller = TextEditingController();
  DateTime academics_assignment_due_date  = DateTime.now();
  DateTime academics_assignment_submission_date  = DateTime.now();
  bool? academics_assignment_submitted;

  // Exam
  final TextEditingController academics_exam_duration_hours_controller = TextEditingController();
  final TextEditingController academics_exam_duration_mins_controller = TextEditingController();
  DateTime academics_exam_date  = DateTime.now();
  DateTime academics_exam_time  = DateTime.now();

  // Marks
  final TextEditingController academics_marks_controller = TextEditingController();
  final TextEditingController academics_marks_total_controller = TextEditingController();

  // Activity controllers
  //final TextEditingController activity_name_controller = TextEditingController();
  final TextEditingController activity_type_controller = TextEditingController();
  final TextEditingController activity_duration_hours_controller = TextEditingController();
  final TextEditingController activity_duration_minutes_controller = TextEditingController();
  final TextEditingController activity_calories_controller = TextEditingController();
  final TextEditingController activity_distance_controller = TextEditingController(text: "0");

  final List<String> activity_dropdown_options = [
    "Badminton",
    "Baseball",
    "Basketball",
    "Cricket",
    "Cycling",
    "Downhill Skiing",
    "Electric Bike",
    "Football",
    "Golf",
    "Handball",
    "Hiking",
    "Hockey",
    "Ice Skating",
    "Kabbadi",
    "Kayaking",
    "Kite Surfing",
    "Martial Arts",
    "Mixed Martial Arts",
    "Motorsports",
    "Pickleball",
    "Pool",
    "Roller Skating",
    "Rugby",
    "Running",
    "Sailing",
    "Skateboarding",
    "Sprint",
    "Surfing",
    "Volleyball",
    "Custom"
  ];
  String? activity_dropdown_chosen;

  // Body measurement widgets
  final TextEditingController bodymeasurement_height_controller = TextEditingController();
  final TextEditingController bodymeasurement_weight_controller = TextEditingController();

  final List<String> bodymeasurement_dropdown_options = [
    "Height",
    "Weight",
  ];
  String? bodymeasurement_dropdown_chosen;

  // Mind widgets
  final TextEditingController mind_mood_name_controller = TextEditingController();
  bool? mind_mood_resolved;
  DateTime? mind_mood_end_date;

  final List<String> mind_mood_intensity_dropdown_options = [
    "Light",
    "Moderate",
    "Severe",
  ];
  String? mind_mood_intensity_dropdown_chosen;

  // Nutrition widgets
  final TextEditingController nutrition_name_controller = TextEditingController();
  final TextEditingController nutrition_qty_controller = TextEditingController(text: "1");
  final TextEditingController nutrition_mass_controller = TextEditingController();
  final TextEditingController nutrition_calories_controller = TextEditingController();
  final TextEditingController nutrition_carbs_controller = TextEditingController(text: "0");
  final TextEditingController nutrition_proteins_controller = TextEditingController(text: "0");
  final TextEditingController nutrition_fats_controller = TextEditingController(text: "0");

  final List<String> nutrition_form_options = [
    "Drink",
    "Solid Food",
    "Supplement",
  ];
  String? nutrition_form_dropdown_chosen;

  final List<String> nutrition_type_options = [
    "Breakfast",
    "Lunch",
    "Dinner",
    "Snacks",
    "Brunch",
  ];
  String? nutrition_type_dropdown_chosen;

  // Symptoms
  final TextEditingController symptoms_name_controller = TextEditingController();
  bool? symptoms_resolved;
  DateTime? symptoms_end_date;

  final List<String> symptoms_intensity_dropdown_options = [
    "Light",
    "Moderate",
    "Severe",
  ];
  String? symptoms_intensity_dropdown_chosen;

  // Time widgets
  final TextEditingController time_duration_hours_controller = TextEditingController();
  final TextEditingController time_duration_minutes_controller = TextEditingController();

  final List<String> time_type_options = [
    "Sleep",
    "Study",
    "Food",
    "Hobby",
    "Gaming",
    "Outing",
    "Commute",
    "Entertainment",
  ];
  String? time_type_dropdown_chosen;

  // Vital widgets
  final TextEditingController vital_bodytemperature_controller = TextEditingController();
  final TextEditingController vital_bloodoxygen_controller = TextEditingController();
  final TextEditingController vital_bloodsugar_controller = TextEditingController();

  final TextEditingController vital_bloodpressure_systolic_controller = TextEditingController();
  final TextEditingController vital_bloodpressure_diastolic_controller = TextEditingController();

  final TextEditingController vital_heartrate_controller = TextEditingController();

  final List<String> vital_name_options = [
    "Body Temperature",
    "Blood Oxygen",
    "Blood Pressure",
    "Blood Sugar",
    "Heartrate"
  ];
  String? vital_name_dropdown_chosen;

  // Workout widgets
  final TextEditingController workout_name_controller = TextEditingController();
  final TextEditingController workout_type_controller = TextEditingController();
  final TextEditingController workout_weight_controller = TextEditingController(text: "0");
  final TextEditingController workout_reps_controller = TextEditingController();
  final TextEditingController workout_sets_controller = TextEditingController();
  final TextEditingController workout_duration_hours_controller = TextEditingController();
  final TextEditingController workout_duration_minutes_controller = TextEditingController();
  final TextEditingController workout_calories_controller = TextEditingController();

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
