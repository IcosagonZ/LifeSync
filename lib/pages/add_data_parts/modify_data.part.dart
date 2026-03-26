part of '../add_data.dart';


final datatypes_valid = [
  "academics_absent",
  "academics_assignment",
  "academics_exam",
  "academics_marks",
  "activity",
  "body_measurement",
  "mind_mood",
  "nutrition",
  "symptom",
  "time",
  "vitals",
  "workout",
];

extension ModifyData on Page_AddData_State{
  void modifyData(List argument) async{
    //print(argument);
    final id = argument[0];
    final datatype = argument[1];

    if(datatypes_valid.contains(datatype))
    {
      if(datatype=="academics_absent")
      {
        List<AcademicsAbsentData> academics_absent_data_list = await database_get_academics_absent_from_id(id);
        AcademicsAbsentData absent_data = academics_absent_data_list.first;

        // Set widgets
        setState((){
          datatype_dropdown_chosen="Academics";
          academics_dropdown_chosen="Absent";

          academics_absent_reason_controller.text = absent_data.reason;
          academics_absent_date = absent_data.absent_date;

          data_date_chosen = absent_data.entry_date;
          data_time_chosen = TimeOfDay.fromDateTime(absent_data.entry_date);
          general_notes_controller.text = absent_data.entry_note;
        });
      }

      if(datatype=="academics_assignment")
      {
        List<AcademicsAssignmentData> academics_assignment_data_list = await database_get_academics_assignment_from_id(id);
        AcademicsAssignmentData assignment_data = academics_assignment_data_list.first;

        // Set widgets
        setState(()
        {
          datatype_dropdown_chosen="Academics";
          academics_dropdown_chosen="Assignment";

          academics_subject_controller.text = assignment_data.subject;
          academics_type_controller.text = assignment_data.type;
          academics_assignment_topic_controller.text = assignment_data.topic;
          if(assignment_data.submitted==1)
          {
            academics_assignment_submitted = true;
          }
          else
          {
            academics_assignment_submitted = false;
          }
          academics_assignment_due_date = assignment_data.due_date;
          academics_assignment_submission_date = assignment_data.submission_date;

          data_date_chosen = assignment_data.entry_date;
          data_time_chosen = TimeOfDay.fromDateTime(assignment_data.entry_date);
          general_notes_controller.text = assignment_data.entry_note;
        });
      }

      if(datatype=="academics_exam")
      {
        List<AcademicsExamData> academics_assignment_data_list = await database_get_academics_exam_from_id(id);
        AcademicsExamData exam_data = academics_assignment_data_list.first;

        // Set widgets
        setState(()
        {
          datatype_dropdown_chosen="Academics";
          academics_dropdown_chosen="Exam";

          academics_subject_controller.text = exam_data.subject;
          academics_type_controller.text = exam_data.exam_type;
          academics_exam_date = exam_data.exam_date;

          final int _hours = exam_data.duration~/60;
          final int _minutes = exam_data.duration-(_hours*60);

          academics_exam_duration_hours_controller.text = _hours.toString();
          academics_exam_duration_mins_controller.text = _minutes.toString();

          data_date_chosen = exam_data.entry_date;
          data_time_chosen = TimeOfDay.fromDateTime(exam_data.entry_date);
          general_notes_controller.text = exam_data.entry_note;
        });
      }

      if(datatype=="academics_marks")
      {
        List<AcademicsMarkData> academics_mark_data_list = await database_get_academics_mark_from_id(id);
        AcademicsMarkData mark_data = academics_mark_data_list.first;

        // Set widgets
        setState(()
        {
          datatype_dropdown_chosen="Academics";
          academics_dropdown_chosen="Marks";

          academics_subject_controller.text = mark_data.subject;
          academics_type_controller.text = mark_data.type;
          academics_marks_controller.text = mark_data.marks.toString();
          academics_marks_total_controller.text = mark_data.marks_total.toString();

          data_date_chosen = mark_data.entry_date;
          data_time_chosen = TimeOfDay.fromDateTime(mark_data.entry_date);
          general_notes_controller.text = mark_data.entry_note;
        });
      }

      if(datatype=="activity")
      {
        List<ActivityData> activity_data_list = await database_get_activity_from_id(id);
        ActivityData activity_data = activity_data_list.first;

        // Set widgets
        setState(()
        {
          datatype_dropdown_chosen="Activity";

          activity_dropdown_chosen = activity_data.name;

          final int _hours = activity_data.duration~/60;
          final int _minutes = activity_data.duration-(_hours*60);

          activity_duration_hours_controller.text = _hours.toString();
          activity_duration_minutes_controller.text = _minutes.toString();

          activity_distance_controller.text = (activity_data.distance/1000).toString();
          activity_calories_controller.text = activity_data.calories.toString();

          data_date_chosen = activity_data.entry_date;
          data_time_chosen = TimeOfDay.fromDateTime(activity_data.entry_date);
          general_notes_controller.text = activity_data.entry_note;
        });
      }

      if(datatype=="body_measurement")
      {
        List<BodyMeasurementData> bodymeasurement_data_list = await database_get_bodymeasurement_from_id(id);
        BodyMeasurementData bodymeasurement_data = bodymeasurement_data_list.first;

        // Set widgets
        setState(()
        {
          datatype_dropdown_chosen="Body Measurements";

          bodymeasurement_dropdown_chosen = bodymeasurement_data.measurement_type;
          if(bodymeasurement_dropdown_chosen=="Height")
          {
            bodymeasurement_height_controller.text = bodymeasurement_data.value.toString();
          }
          else if(bodymeasurement_dropdown_chosen=="Weight")
          {
            bodymeasurement_weight_controller.text = bodymeasurement_data.value.toString();
          }

          data_date_chosen = bodymeasurement_data.entry_date;
          data_time_chosen = TimeOfDay.fromDateTime(bodymeasurement_data.entry_date);
          general_notes_controller.text = bodymeasurement_data.entry_note;
        });
      }

      if(datatype=="mind_mood")
      {
        List<MindMoodData> mind_mood_data_list = await database_get_mind_mood_from_id(id);
        MindMoodData mind_mood_data = mind_mood_data_list.first;

        // Set widgets
        setState(()
        {
          datatype_dropdown_chosen="Mind";
          mind_mood_name_controller.text = mind_mood_data.name;
          mind_mood_intensity_dropdown_chosen = mind_mood_data.intensity;
          mind_mood_resolved =mind_mood_data.resolved;
          mind_mood_end_date = mind_mood_data.end_date;

          data_date_chosen = mind_mood_data.entry_date;
          data_time_chosen = TimeOfDay.fromDateTime(mind_mood_data.entry_date);
          general_notes_controller.text = mind_mood_data.entry_note;
        });
      }

      if(datatype=="nutrition")
      {
        List<NutritionData> nutrition_data_list = await database_get_nutrition_from_id(id);
        NutritionData nutrition_data = nutrition_data_list.first;

        // Set widgets
        setState(()
        {
          datatype_dropdown_chosen="Nutrition";

          nutrition_name_controller.text = nutrition_data.name;
          nutrition_qty_controller.text = nutrition_data.qty.toString();
          nutrition_mass_controller.text = nutrition_data.mass.toString();
          nutrition_calories_controller.text = nutrition_data.calories.toString();
          nutrition_carbs_controller.text = nutrition_data.carbs.toString();
          nutrition_proteins_controller.text = nutrition_data.protein.toString();
          nutrition_fats_controller.text = nutrition_data.fats.toString();
          nutrition_form_dropdown_chosen = nutrition_data.form;
          nutrition_type_dropdown_chosen = nutrition_data.type;

          data_date_chosen = nutrition_data.entry_date;
          data_time_chosen = TimeOfDay.fromDateTime(nutrition_data.entry_date);
          general_notes_controller.text = nutrition_data.entry_note;
        });
      }

      if(datatype=="symptom")
      {
        List<SymptomData> symptoms_data_list = await database_get_symptom_from_id(id);
        SymptomData symptoms_data = symptoms_data_list.first;

        // Set widgets
        setState(()
        {
          datatype_dropdown_chosen="Symptom";

          symptoms_name_controller.text = symptoms_data.name;

          if(symptoms_data.resolved==1)
          {
            symptoms_resolved = true;
          }
          else
          {
            symptoms_resolved = false;
          }

          if(symptoms_data.end_date.isNotEmpty)
          {
            symptoms_end_date = DateTime.parse(symptoms_data.end_date);
          }

          data_date_chosen = symptoms_data.entry_date;
          data_time_chosen = TimeOfDay.fromDateTime(symptoms_data.entry_date);
          general_notes_controller.text = symptoms_data.entry_note;
        });
      }

      if(datatype=="time")
      {
        List<TimeData> time_data_list = await database_get_time_from_id(id);
        TimeData time_data = time_data_list.first;

        // Set widgets
        setState(()
        {
          datatype_dropdown_chosen="Time";

          time_type_dropdown_chosen = time_data.event;

          final int _hours = time_data.duration~/60;
          final int _minutes = time_data.duration-(_hours*60);

          time_duration_hours_controller.text = _hours.toString();
          time_duration_minutes_controller.text = _minutes.toString();

          data_date_chosen = time_data.entry_date;
          data_time_chosen = TimeOfDay.fromDateTime(time_data.entry_date);

          data_time_start_date = time_data.start_datetime;
          data_time_end_date = time_data.end_datetime;

          data_time_start_chosen = TimeOfDay.fromDateTime(time_data.start_datetime);
          data_time_end_chosen = TimeOfDay.fromDateTime(time_data.end_datetime);

          general_notes_controller.text = time_data.entry_note;
        });
      }

      if(datatype=="vitals")
      {
        List<VitalsData> vitals_data_list = await database_get_vitals_from_id(id);
        VitalsData vitals_data = vitals_data_list.first;

        // Set widgets
        setState(()
        {
          datatype_dropdown_chosen="Vitals";

          if(vitals_data.type=="Body Temperature")
          {
            vital_name_dropdown_chosen = "Body Temperature";
            vital_bodytemperature_controller.text = vitals_data.value;
          }
          else if(vitals_data.type=="Blood Oxygen")
          {
            vital_name_dropdown_chosen = "Blood Oxygen";
            vital_bloodoxygen_controller.text = vitals_data.value;
          }
          else if(vitals_data.type=="Blood Pressure")
          {
            vital_name_dropdown_chosen = "Blood Pressure";
            final _blood_pressure = vitals_data.value.split("/");
            vital_bloodpressure_systolic_controller.text = _blood_pressure.first;
            vital_bloodpressure_diastolic_controller.text = _blood_pressure.last;
          }
          else if(vitals_data.type=="Blood Sugar")
          {
            vital_name_dropdown_chosen = "Blood Sugar";
            vital_bloodsugar_controller.text = vitals_data.value;
          }
          else if(vitals_data.type=="Heartrate")
          {
            vital_name_dropdown_chosen = "Heartrate";
            vital_heartrate_controller.text = vitals_data.value;
          }

          data_date_chosen = vitals_data.entry_date;
          data_time_chosen = TimeOfDay.fromDateTime(vitals_data.entry_date);
          general_notes_controller.text = vitals_data.entry_note;
        });
      }

      if(datatype=="workout")
      {
        List<WorkoutData> workout_data_list = await database_get_workout_from_id(id);
        WorkoutData workout_data = workout_data_list.first;

        // Set widgets
        setState(()
        {
          datatype_dropdown_chosen="Workout";

          workout_name_controller.text = workout_data.name;
          workout_type_controller.text = workout_data.type;
          workout_weight_controller.text = workout_data.weight.toString();
          workout_reps_controller.text = workout_data.reps.toString();
          //workout_sets_controller.text = ;

          final int _hours = workout_data.duration~/60;
          final int _minutes = workout_data.duration-(_hours*60);
          workout_duration_hours_controller.text = _hours.toString();
          workout_duration_minutes_controller.text = _minutes.toString();
          workout_calories_controller.text = workout_data.calories.toString();

          data_date_chosen = workout_data.entry_date;
          data_time_chosen = TimeOfDay.fromDateTime(workout_data.entry_date);
          general_notes_controller.text = workout_data.entry_note;
        });
      }
    }
  }
}
