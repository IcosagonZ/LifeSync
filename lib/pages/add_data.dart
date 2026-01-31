import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import '../data/database.dart';

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

  // Marks
  final TextEditingController academics_marks_controller = TextEditingController();
  final TextEditingController academics_marks_total_controller = TextEditingController();

  // Activity controllers
  //final TextEditingController activity_name_controller = TextEditingController();
  final TextEditingController activity_type_controller = TextEditingController();
  final TextEditingController activity_duration_hours_controller = TextEditingController();
  final TextEditingController activity_duration_minutes_controller = TextEditingController();
  final TextEditingController activity_calories_controller = TextEditingController();
  final TextEditingController activity_distance_controller = TextEditingController();

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
  final TextEditingController nutrition_qty_controller = TextEditingController();
  final TextEditingController nutrition_mass_controller = TextEditingController();
  final TextEditingController nutrition_calories_controller = TextEditingController();
  final TextEditingController nutrition_carbs_controller = TextEditingController();
  final TextEditingController nutrition_proteins_controller = TextEditingController();
  final TextEditingController nutrition_fats_controller = TextEditingController();

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
  final TextEditingController workout_weight_controller = TextEditingController();
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
                  Visibility(
                    visible: academics_dropdown_chosen=="Absent",
                    child: Column(
                      children: [
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Text("Reason")
                            ),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth: 100,
                              ),
                              child: IntrinsicWidth(
                                child: TextField(
                                  controller: academics_absent_reason_controller,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    border: UnderlineInputBorder(),
                                    isDense: true,
                                  ),
                                ),
                              ),
                            ),
                          ]
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Text("Absent Date")
                            ),

                            ActionChip(
                              label: Text(academics_absent_date == null
                              ? "Select date"
                              : "${academics_absent_date!.toLocal()}".split(" ")[0],
                              ),
                              onPressed: () async{
                                final date_chosen = await data_date_select(context);
                                setState(()
                                {
                                  if(date_chosen!=null)
                                  {
                                    academics_absent_date = date_chosen;
                                  }
                                });
                              },
                            ),
                          ]
                        ),
                      ]
                    )
                  ),

                  // Assignment
                  Visibility(
                    visible: academics_dropdown_chosen=="Assignment",
                    child: Column(
                      children: [
                        SizedBox(height: 16),
                        Divider(),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Text("Subject")
                            ),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth: 100,
                              ),
                              child: IntrinsicWidth(
                                child: TextField(
                                  controller: academics_subject_controller,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    border: UnderlineInputBorder(),
                                    isDense: true,
                                  ),
                                ),
                              ),
                            ),
                          ]
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Text("Assignment Type")
                            ),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth: 100,
                              ),
                              child: IntrinsicWidth(
                                child: TextField(
                                  controller: academics_type_controller,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    border: UnderlineInputBorder(),
                                    isDense: true,
                                  ),
                                ),
                              ),
                            ),
                          ]
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Text("Assignment Topic")
                            ),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth: 100,
                              ),
                              child: IntrinsicWidth(
                                child: TextField(
                                  controller: academics_assignment_topic_controller,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    border: UnderlineInputBorder(),
                                    isDense: true,
                                  ),
                                ),
                              ),
                            ),
                          ]
                        ),
                        SizedBox(height: 16),
                        Divider(),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Text("Due Date")
                            ),

                            ActionChip(
                              label: Text(academics_assignment_due_date == null
                              ? "Select date"
                              : "${academics_assignment_due_date!.toLocal()}".split(" ")[0],
                              ),
                              onPressed: () async{
                                final date_chosen = await data_date_select(context);
                                setState(()
                                {
                                  if(date_chosen!=null)
                                  {
                                    academics_assignment_due_date = date_chosen;
                                  }
                                });
                              },
                            ),
                          ]
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Text("Submission Date")
                            ),
                            ActionChip(
                              label: Text(academics_assignment_submission_date == null
                              ? "Select date"
                              : "${academics_assignment_submission_date!.toLocal()}".split(" ")[0],
                              ),
                              onPressed: () async{
                                final date_chosen = await data_date_select(context);
                                setState(()
                                {
                                  if(date_chosen!=null)
                                  {
                                    academics_assignment_submission_date = date_chosen;
                                  }
                                });
                              },
                            ),
                          ]
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Text("Submitted")
                            ),
                            Checkbox(
                              tristate: true,
                              value: academics_assignment_submitted,
                              onChanged: (bool? value){
                                setState(() {
                                  academics_assignment_submitted = value;
                                });
                              },
                            )
                          ]
                        ),
                      ]
                    )
                  ),

                  // Exam
                  Visibility(
                    visible: academics_dropdown_chosen=="Exam",
                    child: Column(
                      children: [
                        SizedBox(height: 16),
                        Divider(),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Text("Subject")
                            ),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth: 100,
                              ),
                              child: IntrinsicWidth(
                                child: TextField(
                                  controller: academics_subject_controller,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    border: UnderlineInputBorder(),
                                    isDense: true,
                                  ),
                                ),
                              ),
                            ),
                          ]
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Text("Exam type")
                            ),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth: 100,
                              ),
                              child: IntrinsicWidth(
                                child: TextField(
                                  controller: academics_type_controller,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    border: UnderlineInputBorder(),
                                    isDense: true,
                                  ),
                                ),
                              ),
                            ),
                          ]
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Text("Exam date")
                            ),
                            ActionChip(
                              label: Text(academics_exam_date == null
                              ? "Select date"
                              : "${academics_exam_date!.toLocal()}".split(" ")[0],
                              ),
                              onPressed: () async{
                                final date_chosen = await data_date_select(context);
                                setState(()
                                {
                                  if(date_chosen!=null)
                                  {
                                    academics_exam_date = date_chosen;
                                  }
                                });
                              },
                            ),
                          ]
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Text("Exam duration")
                            ),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth: 20,
                              ),
                              child: IntrinsicWidth(
                                child: TextField(
                                  controller: academics_exam_duration_hours_controller,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    border: UnderlineInputBorder(),
                                    isDense: true,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            Text("hrs"),
                            SizedBox(width: 16),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth: 20,
                              ),
                              child: IntrinsicWidth(
                                child: TextField(
                                  controller: academics_exam_duration_mins_controller,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    border: UnderlineInputBorder(),
                                    isDense: true,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            Text("mins"),
                          ]
                        ),
                      ]
                    )
                  ),

                  // Marks
                  Visibility(
                    visible: academics_dropdown_chosen=="Marks",
                    child: Column(
                      children: [
                        SizedBox(height: 16),
                        Divider(),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Text("Subject")
                            ),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth: 100,
                              ),
                              child: IntrinsicWidth(
                                child: TextField(
                                  controller: academics_subject_controller,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    border: UnderlineInputBorder(),
                                    isDense: true,
                                  ),
                                ),
                              ),
                            ),
                          ]
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Text("Mark type")
                            ),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth: 100,
                              ),
                              child: IntrinsicWidth(
                                child: TextField(
                                  controller: academics_type_controller,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    border: UnderlineInputBorder(),
                                    isDense: true,
                                  ),
                                ),
                              ),
                            ),
                          ]
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Text("Marks received")
                            ),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth: 20,
                              ),
                              child: IntrinsicWidth(
                                child: TextField(
                                  controller: academics_marks_controller,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    border: UnderlineInputBorder(),
                                    isDense: true,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            Text("out of"),
                            SizedBox(width: 16),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth: 20,
                              ),
                              child: IntrinsicWidth(
                                child: TextField(
                                  controller: academics_marks_total_controller,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    border: UnderlineInputBorder(),
                                    isDense: true,
                                  ),
                                ),
                              ),
                            ),
                          ]
                        ),
                      ]
                    )
                  ),

                  SizedBox(height: 16),
                  Divider(),
                ]
              )
            ),

            // Activity data entry
            Visibility(
              visible: datatype_dropdown_chosen=="Activity",
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text("Name")
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 100,
                        ),
                        child:  DropdownButton<String>(
                          hint: Text("Select..."),
                          value: activity_dropdown_chosen,
                          onChanged: (String? newValue)
                          {
                            setState(()
                            {
                              activity_dropdown_chosen = newValue;
                              print(activity_dropdown_chosen);
                            });
                          },
                          items: activity_dropdown_options.map<DropdownMenuItem<String>>((String dropdown_item)
                          {
                            return DropdownMenuItem<String>(
                              value: dropdown_item,
                              child: Text(dropdown_item)
                            );
                          }
                          ).toList(),
                        )
                      ),
                    ]
                  ),
                  SizedBox(height: 16),
                  /*
                  Row(
                    children: [
                      Expanded(
                        child: Text("Type")
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 100,
                        ),
                        child: IntrinsicWidth(
                          child: TextField(
                            controller: activity_type_controller,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              isDense: true,
                            ),
                          ),
                        ),
                      ),
                    ]
                  ),
                  SizedBox(height: 16),
                  */
                  Row(
                    children: [
                      Expanded(
                        child: Text("Duration")
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 20,
                        ),
                        child: IntrinsicWidth(
                          child: TextField(
                            controller: activity_duration_hours_controller,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              isDense: true,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Text("hrs"),
                      SizedBox(width: 16),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 20,
                        ),
                        child: IntrinsicWidth(
                          child: TextField(
                            controller: activity_duration_minutes_controller,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              isDense: true,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Text("mins"),
                    ]
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Text("Calories")
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 50,
                        ),
                        child: IntrinsicWidth(
                          child: TextField(
                            controller: activity_calories_controller,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              isDense: true,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Text("cal"),
                    ]
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Text("Distance")
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 50,
                        ),
                        child: IntrinsicWidth(
                          child: TextField(
                            controller: activity_distance_controller,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              isDense: true,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Text("km"),
                    ]
                  ),
                  SizedBox(height: 16),
                  Divider(),
                ]
              )
            ),

            // Body measurements data entry
            Visibility(
              visible: datatype_dropdown_chosen=="Body Measurements",
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text("Type")
                      ),
                      DropdownButton<String>(
                        hint: Text("Select data type"),
                        value: bodymeasurement_dropdown_chosen,
                        onChanged: (String? newValue)
                        {
                          setState(()
                          {
                            bodymeasurement_dropdown_chosen = newValue;
                            print(bodymeasurement_dropdown_chosen);
                          });
                        },
                        items: bodymeasurement_dropdown_options.map<DropdownMenuItem<String>>((String dropdown_item)
                        {
                          return DropdownMenuItem<String>(
                            value: dropdown_item,
                            child: Text(dropdown_item)
                          );
                        }
                        ).toList(),
                      )
                    ]
                  ),
                  Visibility(
                    visible: bodymeasurement_dropdown_chosen=="Height",
                    child: Column(
                      children: [
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Text("Height")
                            ),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth: 50,
                              ),
                              child: IntrinsicWidth(
                                child: TextField(
                                  controller: bodymeasurement_height_controller,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    border: UnderlineInputBorder(),
                                    isDense: true,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            Text("cm"),
                          ]
                        ),
                      ]
                    )
                  ),
                  Visibility(
                    visible: bodymeasurement_dropdown_chosen=="Weight",
                    child: Column(
                      children: [
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Text("Weight")
                            ),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth: 50,
                              ),
                              child: IntrinsicWidth(
                                child: TextField(
                                  controller: bodymeasurement_weight_controller,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    border: UnderlineInputBorder(),
                                    isDense: true,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            Text("kg"),
                          ]
                        ),
                      ]
                    )
                  ),
                  SizedBox(height: 16),
                  Divider(),
                ]
              )
            ),

            // Mind data entry
            Visibility(
              visible: datatype_dropdown_chosen=="Mind",
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text("Mood")
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 100,
                        ),
                        child: IntrinsicWidth(
                          child: TextField(
                            controller: mind_mood_name_controller,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              isDense: true,
                            ),
                          ),
                        ),
                      ),
                    ]
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Text("Intensity")
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 100,
                        ),
                        child: DropdownButton<String>(
                          hint: Text("Select..."),
                          value: mind_mood_intensity_dropdown_chosen,
                          onChanged: (String? newValue)
                          {
                            setState(()
                            {
                              mind_mood_intensity_dropdown_chosen = newValue;
                              print(mind_mood_intensity_dropdown_chosen);
                            });
                          },
                          items: mind_mood_intensity_dropdown_options.map<DropdownMenuItem<String>>((String dropdown_item)
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
                  SizedBox(height: 16),
                  Divider(),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Text("Resolved")
                      ),
                      Checkbox(
                        tristate: true,
                        value: mind_mood_resolved,
                        onChanged: (bool? value){
                          setState(() {
                            mind_mood_resolved = value;
                          });
                        },
                      )
                    ]
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Text("End date")
                      ),

                      ActionChip(
                        label: Text(mind_mood_end_date == null
                        ? "Select date"
                        : "${mind_mood_end_date!.toLocal()}".split(" ")[0],
                        ),
                        onPressed: () async{
                          final date_chosen = await data_date_select(context);
                          setState(()
                          {
                            if(date_chosen!=null)
                            {
                              mind_mood_end_date = date_chosen;
                            }
                          });
                        },
                      ),
                    ]
                  ),
                  SizedBox(height: 16),
                  Divider(),
                ]
              )
            ),

            // Nutrition data entry
            Visibility(
              visible: datatype_dropdown_chosen=="Nutrition",
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text("Name")
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 100,
                        ),
                        child: IntrinsicWidth(
                          child: TextField(
                            controller: nutrition_name_controller,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              isDense: true,
                            ),
                          ),
                        ),
                      ),
                    ]
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Text("Form")
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 100,
                        ),
                        child:   DropdownButton<String>(
                          hint: Text("Select..."),
                          value: nutrition_form_dropdown_chosen,
                          onChanged: (String? newValue)
                          {
                            setState(()
                            {
                              nutrition_form_dropdown_chosen = newValue;
                              print(nutrition_form_dropdown_chosen);
                            });
                          },
                          items: nutrition_form_options.map<DropdownMenuItem<String>>((String dropdown_item)
                          {
                            return DropdownMenuItem<String>(
                              value: dropdown_item,
                              child: Text(dropdown_item)
                            );
                          }
                          ).toList(),
                        )
                      ),
                    ]
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Text("Type")
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 100,
                        ),
                        child:  DropdownButton<String>(
                          hint: Text("Select..."),
                          value: nutrition_type_dropdown_chosen,
                          onChanged: (String? newValue)
                          {
                            setState(()
                            {
                              nutrition_type_dropdown_chosen = newValue;
                              print(nutrition_type_dropdown_chosen);
                            });
                          },
                          items: nutrition_type_options.map<DropdownMenuItem<String>>((String dropdown_item)
                          {
                            return DropdownMenuItem<String>(
                              value: dropdown_item,
                              child: Text(dropdown_item)
                            );
                          }
                          ).toList(),
                        )
                      ),
                    ]
                  ),
                  SizedBox(height: 16),
                  Divider(),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Text("Quantity")
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 20,
                        ),
                        child: IntrinsicWidth(
                          child: TextField(
                            controller: nutrition_qty_controller,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              isDense: true,
                            ),
                          ),
                        ),
                      ),
                    ]
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Text("Calories")
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 30,
                        ),
                        child: IntrinsicWidth(
                          child: TextField(
                            controller: nutrition_calories_controller,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              isDense: true,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Text("cal"),
                    ]
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Text("Mass")
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 30,
                        ),
                        child: IntrinsicWidth(
                          child: TextField(
                            controller: nutrition_mass_controller,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              isDense: true,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Text("g"),
                    ]
                  ),
                  SizedBox(height: 16),
                  Divider(),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Text("Carbohydrates")
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 30,
                        ),
                        child: IntrinsicWidth(
                          child: TextField(
                            controller: nutrition_carbs_controller,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              isDense: true,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Text("g"),
                    ]
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Text("Proteins")
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 30,
                        ),
                        child: IntrinsicWidth(
                          child: TextField(
                            controller: nutrition_proteins_controller,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              isDense: true,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Text("g"),
                    ]
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Text("Fats")
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 30,
                        ),
                        child: IntrinsicWidth(
                          child: TextField(
                            controller: nutrition_fats_controller,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              isDense: true,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Text("g"),
                    ]
                  ),
                  SizedBox(height: 16),
                  Divider(),
                ]
              )
            ),

            // Symptom data entry
            Visibility(
              visible: datatype_dropdown_chosen=="Symptom",
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text("Symptom")
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 100,
                        ),
                        child: IntrinsicWidth(
                          child: TextField(
                            controller: symptoms_name_controller,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              isDense: true,
                            ),
                          ),
                        ),
                      ),
                    ]
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Text("Intensity")
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 100,
                        ),
                        child: DropdownButton<String>(
                          hint: Text("Select..."),
                          value: symptoms_intensity_dropdown_chosen,
                          onChanged: (String? newValue)
                          {
                            setState(()
                            {
                              symptoms_intensity_dropdown_chosen = newValue;
                              print(symptoms_intensity_dropdown_chosen);
                            });
                          },
                          items: symptoms_intensity_dropdown_options.map<DropdownMenuItem<String>>((String dropdown_item)
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
                  SizedBox(height: 16),
                  Divider(),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Text("Resolved")
                      ),
                      Checkbox(
                        tristate: true,
                        value: symptoms_resolved,
                        onChanged: (bool? value){
                          setState(() {
                            symptoms_resolved = value;
                          });
                        },
                      )
                    ]
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Text("End date")
                      ),

                      ActionChip(
                        label: Text(symptoms_end_date == null
                        ? "Select date"
                        : "${symptoms_end_date!.toLocal()}".split(" ")[0],
                        ),
                        onPressed: () async{
                          final date_chosen = await data_date_select(context);
                          setState(()
                          {
                            if(date_chosen!=null)
                            {
                              symptoms_end_date = date_chosen;
                            }
                          });
                        },
                      ),
                    ]
                  ),
                  SizedBox(height: 16),
                  Divider(),
                ]
              )
            ),

            // Time data entry
            Visibility(
              visible: datatype_dropdown_chosen=="Time",
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text("Type")
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 100,
                        ),
                        child: DropdownButton<String>(
                          hint: Text("Select..."),
                          value: time_type_dropdown_chosen,
                          onChanged: (String? newValue)
                          {
                            setState(()
                            {
                              time_type_dropdown_chosen = newValue;
                              print(time_type_dropdown_chosen);
                            });
                          },
                          items: time_type_options.map<DropdownMenuItem<String>>((String dropdown_item)
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
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Text("Duration")
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 20,
                        ),
                        child: IntrinsicWidth(
                          child: TextField(
                            controller: time_duration_hours_controller,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              isDense: true,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Text("hrs"),
                      SizedBox(width: 16),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 20,
                        ),
                        child: IntrinsicWidth(
                          child: TextField(
                            controller: time_duration_minutes_controller,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              isDense: true,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Text("mins"),
                    ]
                  ),
                  SizedBox(height: 16),
                  Divider(),
                ]
              )
            ),

            // Vital data entry
            Visibility(
              visible: datatype_dropdown_chosen=="Vitals",
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text("Type")
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 100,
                        ),
                        child: DropdownButton<String>(
                          hint: Text("Select..."),
                          value: vital_name_dropdown_chosen,
                          onChanged: (String? newValue)
                          {
                            setState(()
                            {
                              vital_name_dropdown_chosen = newValue;
                              print(vital_name_dropdown_chosen);
                            });
                          },
                          items: vital_name_options.map<DropdownMenuItem<String>>((String dropdown_item)
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
                  SizedBox(height: 16),
                  Visibility(
                    visible: vital_name_dropdown_chosen=="Blood Oxygen",
                    child: Column(
                      children: [
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Text("Blood Oxygen Percentage")
                            ),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth: 30,
                              ),
                              child: IntrinsicWidth(
                                child: TextField(
                                  controller: vital_bloodoxygen_controller,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    border: UnderlineInputBorder(),
                                    isDense: true,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            Text("%"),
                          ]
                        ),
                      ]
                    )
                  ),
                  Visibility(
                    visible: vital_name_dropdown_chosen=="Body Temperature",
                    child: Column(
                      children: [
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Text("Body Temperature")
                            ),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth: 30,
                              ),
                              child: IntrinsicWidth(
                                child: TextField(
                                  controller: vital_bodytemperature_controller,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    border: UnderlineInputBorder(),
                                    isDense: true,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            Text("°C"),
                          ]
                        ),
                      ]
                    )
                  ),
                  Visibility(
                    visible: vital_name_dropdown_chosen=="Blood Pressure",
                    child: Column(
                      children: [
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Text("Blood Pressure")
                            ),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth: 30,
                              ),
                              child: IntrinsicWidth(
                                child: TextField(
                                  controller: vital_bloodpressure_systolic_controller,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    border: UnderlineInputBorder(),
                                    isDense: true,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            Text("/"),
                            SizedBox(width: 16),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth: 30,
                              ),
                              child: IntrinsicWidth(
                                child: TextField(
                                  controller: vital_bloodpressure_diastolic_controller,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    border: UnderlineInputBorder(),
                                    isDense: true,
                                  ),
                                ),
                              ),
                            ),
                          ]
                        ),
                      ]
                    )
                  ),
                  Visibility(
                    visible: vital_name_dropdown_chosen=="Blood Sugar",
                    child: Column(
                      children: [
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Text("Blood Sugar")
                            ),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth: 30,
                              ),
                              child: IntrinsicWidth(
                                child: TextField(
                                  controller: vital_bloodsugar_controller,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    border: UnderlineInputBorder(),
                                    isDense: true,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            Text("mmol/L"),
                          ]
                        ),
                      ]
                    )
                  ),
                  Visibility(
                    visible: vital_name_dropdown_chosen=="Heartrate",
                    child: Column(
                      children: [
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Text("Heartrate")
                            ),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth: 30,
                              ),
                              child: IntrinsicWidth(
                                child: TextField(
                                  controller: vital_heartrate_controller,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    border: UnderlineInputBorder(),
                                    isDense: true,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            Text("bpm"),
                          ]
                        ),
                      ]
                    )
                  ),
                  SizedBox(height: 16),
                  Divider(),
                ],
              ),
            ),

            // Workout data entry
            Visibility(
              visible: datatype_dropdown_chosen=="Workout",
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text("Name")
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 100,
                        ),
                        child: IntrinsicWidth(
                          child: TextField(
                            controller: workout_name_controller,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              isDense: true,
                            ),
                          ),
                        ),
                      ),
                    ]
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Text("Type")
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 100,
                        ),
                        child: IntrinsicWidth(
                          child: TextField(
                            controller: workout_type_controller,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              isDense: true,
                            ),
                          ),
                        ),
                      ),
                    ]
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Text("Duration")
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 20,
                        ),
                        child: IntrinsicWidth(
                          child: TextField(
                            controller: workout_duration_hours_controller,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              isDense: true,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Text("hrs"),
                      SizedBox(width: 16),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 20,
                        ),
                        child: IntrinsicWidth(
                          child: TextField(
                            controller: workout_duration_minutes_controller,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              isDense: true,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Text("mins"),
                    ]
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Text("Calories")
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 50,
                        ),
                        child: IntrinsicWidth(
                          child: TextField(
                            controller: workout_calories_controller,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              isDense: true,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Text("cal"),
                    ]
                  ),
                  SizedBox(height: 16),
                  Divider(),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Text("Repetitions per set")
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 30,
                        ),
                        child: IntrinsicWidth(
                          child: TextField(
                            controller: workout_reps_controller,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              isDense: true,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Text("reps"),
                    ]
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Text("Sets")
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 30,
                        ),
                        child: IntrinsicWidth(
                          child: TextField(
                            controller: workout_sets_controller,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              isDense: true,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Text("sets"),
                    ]
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Text("Weight")
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 30,
                        ),
                        child: IntrinsicWidth(
                          child: TextField(
                            controller: workout_weight_controller,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              isDense: true,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Text("kg"),
                    ]
                  ),
                  SizedBox(height: 16),
                  Divider(),
                ]
              )
            ),

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
          child: ElevatedButton(
            child: Text("Add data"),
            onPressed: ()
            {
              print("Add data pressed");

              // Set date time
              data_datetime = DateTime(
                data_date_chosen!.year,
                data_date_chosen!.month,
                data_date_chosen!.day,
                data_time_chosen!.hour,
                data_time_chosen!.minute,
              );

              final String entry_date = data_datetime.toIso8601String();

              if(datatype_dropdown_chosen=="Academics")
              {
                if(academics_dropdown_chosen=="Absent")
                {
                  if(academics_absent_reason_controller.text.isEmpty)
                  {
                    ScaffoldMessenger.of(context).showSnackBar(notify_snackbar("Empty field not allowed!"));
                  }
                  else
                  {
                    database_insert_academics_absent(
                      academics_absent_reason_controller.text,
                      academics_absent_date.toIso8601String(),
                      entry_date,
                      general_notes_controller.text
                    ).then((int row_index)
                    {
                      if(row_index==0)
                      {
                        ScaffoldMessenger.of(context).showSnackBar(notify_snackbar("Data entry failed"));
                      }
                      else
                      {
                        ScaffoldMessenger.of(context).showSnackBar(notify_snackbar("Data entry success"));
                      }
                    });
                  }
                }
                else if(academics_dropdown_chosen=="Assignment")
                {
                  if(
                    academics_subject_controller.text.isEmpty ||
                    academics_type_controller.text.isEmpty ||
                    academics_assignment_topic_controller.text.isEmpty
                  )
                  {
                    ScaffoldMessenger.of(context).showSnackBar(notify_snackbar("Empty field not allowed!"));
                  }
                  else
                  {
                    int academics_assignment_submitted_int = 0;
                    if(academics_assignment_submitted==true)
                    {
                      academics_assignment_submitted_int = 1;
                    }
                    else
                    {
                      academics_assignment_submitted_int = 0;
                    }

                    database_insert_academics_assignment(
                      academics_subject_controller.text,
                      academics_type_controller.text,
                      academics_assignment_topic_controller.text,
                      academics_assignment_submitted_int,
                      academics_assignment_due_date.toIso8601String(),
                      academics_assignment_submission_date.toIso8601String(),
                      entry_date,
                      general_notes_controller.text
                    ).then((int row_index)
                    {
                      if(row_index==0)
                      {
                        ScaffoldMessenger.of(context).showSnackBar(notify_snackbar("Data entry failed"));
                      }
                      else
                      {
                        ScaffoldMessenger.of(context).showSnackBar(notify_snackbar("Data entry success"));
                      }
                    });
                  }


                }
                else if(academics_dropdown_chosen=="Exam")
                {
                  if(
                    academics_exam_duration_hours_controller.text.isEmpty ||
                    academics_exam_duration_mins_controller.text.isEmpty ||
                    academics_subject_controller.text.isEmpty ||
                    academics_type_controller.text.isEmpty
                  )
                  {
                    ScaffoldMessenger.of(context).showSnackBar(notify_snackbar("Empty field not allowed!"));
                  }
                  else
                  {
                    int duration = int.parse(academics_exam_duration_hours_controller.text) * 60 + int.parse(academics_exam_duration_mins_controller.text);

                    database_insert_academics_exam(
                      academics_subject_controller.text,
                      academics_type_controller.text,
                      academics_exam_date.toIso8601String(),
                      duration,
                      entry_date,
                      general_notes_controller.text
                    ).then((int row_index)
                    {
                      if(row_index==0)
                      {
                        ScaffoldMessenger.of(context).showSnackBar(notify_snackbar("Data entry failed"));
                      }
                      else
                      {
                        ScaffoldMessenger.of(context).showSnackBar(notify_snackbar("Data entry success"));
                      }
                    });
                  }
                }
                else if(academics_dropdown_chosen=="Marks")
                {
                  if(
                    academics_subject_controller.text.isEmpty ||
                    academics_type_controller.text.isEmpty ||
                    academics_marks_controller.text.isEmpty ||
                    academics_marks_total_controller.text.isEmpty
                  )
                  {
                    ScaffoldMessenger.of(context).showSnackBar(notify_snackbar("Empty field not allowed!"));
                  }
                  else
                  {
                    database_insert_academics_mark(
                      academics_subject_controller.text,
                      academics_type_controller.text,
                      double.parse(academics_marks_controller.text),
                      double.parse(academics_marks_total_controller.text),
                      entry_date,
                      general_notes_controller.text
                    ).then((int row_index)
                    {
                      if(row_index==0)
                      {
                        ScaffoldMessenger.of(context).showSnackBar(notify_snackbar("Data entry failed"));
                      }
                      else
                      {
                        ScaffoldMessenger.of(context).showSnackBar(notify_snackbar("Data entry success"));
                      }
                    });
                  }
                }
              }

              if(datatype_dropdown_chosen=="Body Measurements")
              {
                if(bodymeasurement_dropdown_chosen=="Height")
                {
                  if(bodymeasurement_height_controller.text.isEmpty)
                  {
                    ScaffoldMessenger.of(context).showSnackBar(notify_snackbar("Height is empty"));
                  }
                  else
                  {
                    database_insert_bodymeasurements(
                      "Height",
                      bodymeasurement_height_controller.text,
                      "cm",
                      entry_date,
                      general_notes_controller.text
                    ).then((int row_index)
                    {
                      if(row_index==0)
                      {
                        ScaffoldMessenger.of(context).showSnackBar(notify_snackbar("Data entry failed"));
                      }
                      else
                      {
                        ScaffoldMessenger.of(context).showSnackBar(notify_snackbar("Data entry success"));
                      }
                    });
                  }
                }

                if(bodymeasurement_dropdown_chosen=="Weight")
                {
                  if(bodymeasurement_weight_controller.text.isEmpty)
                  {
                    ScaffoldMessenger.of(context).showSnackBar(notify_snackbar("Weight is empty"));
                  }
                  else
                  {
                    database_insert_bodymeasurements(
                      "Weight",
                      bodymeasurement_weight_controller.text,
                      "kg",
                      entry_date,
                      general_notes_controller.text
                    ).then((int row_index)
                    {
                      if(row_index==0)
                      {
                        ScaffoldMessenger.of(context).showSnackBar(notify_snackbar("Data entry failed"));
                      }
                      else
                      {
                        ScaffoldMessenger.of(context).showSnackBar(notify_snackbar("Data entry success"));
                      }
                    });
                  }
                }
              }
            },
          )
        )
      ),
    );
  }
}
