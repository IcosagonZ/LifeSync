part of '../add_data.dart';

extension AddDataButton on Page_AddData_State{
  Widget getAddDataButton(){
    return ElevatedButton(
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
              academics_type_controller.text.isEmpty ||
              // Check if number
              !isNumeric(academics_exam_duration_hours_controller.text) ||
              !isNumeric(academics_exam_duration_mins_controller.text)
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
              academics_marks_total_controller.text.isEmpty ||
              // Check if number
              !isNumeric(academics_marks_controller.text) ||
              !isNumeric(academics_marks_total_controller.text)
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

        if(datatype_dropdown_chosen=="Mind")
        {
          if(mind_mood_name_controller.text.isEmpty)
          {
            ScaffoldMessenger.of(context).showSnackBar(notify_snackbar("Empty field not allowed!"));
          }
          else
          {
            print(mind_mood_resolved);
            database_insert_mind_mood(
              mind_mood_name_controller.text,
              mind_mood_intensity_dropdown_chosen ?? "",
              mind_mood_resolved ?? false,
              mind_mood_end_date?.toIso8601String() ?? "",
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

        if(datatype_dropdown_chosen=="Activity")
        {
          if(
            activity_dropdown_chosen==null ||
            activity_duration_hours_controller.text.isEmpty ||
            activity_duration_minutes_controller.text.isEmpty ||
            activity_distance_controller.text.isEmpty ||
            activity_calories_controller.text.isEmpty ||
            // Check if number
            !isNumeric(activity_duration_hours_controller.text) ||
            !isNumeric(activity_duration_minutes_controller.text) ||
            !isNumeric(activity_distance_controller.text) ||
            !isNumeric(activity_calories_controller.text)
          )
          {
            ScaffoldMessenger.of(context).showSnackBar(notify_snackbar("Empty field not allowed!"));
          }
          else
          {
            int duration = int.parse(activity_duration_hours_controller.text) * 60 + int.parse(activity_duration_minutes_controller.text);

            database_insert_activity(
              activity_dropdown_chosen ?? "",
              duration,
              (double.parse(activity_distance_controller.text)*1000).toInt(),
              double.parse(activity_calories_controller.text),
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

        if(datatype_dropdown_chosen=="Body Measurements")
        {
          if(bodymeasurement_dropdown_chosen=="Height")
          {
            if(
              bodymeasurement_height_controller.text.isEmpty ||
              !isNumeric(bodymeasurement_height_controller.text)
            )
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
            if(
              bodymeasurement_weight_controller.text.isEmpty ||
              !isNumeric(bodymeasurement_weight_controller.text)
            )
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

        if(datatype_dropdown_chosen=="Nutrition")
        {
          if(
            nutrition_name_controller.text.isEmpty ||
            nutrition_qty_controller.text.isEmpty ||
            nutrition_mass_controller.text.isEmpty ||
            nutrition_calories_controller.text.isEmpty ||
            nutrition_carbs_controller.text.isEmpty ||
            nutrition_proteins_controller.text.isEmpty ||
            nutrition_fats_controller.text.isEmpty ||
            nutrition_form_dropdown_chosen==null ||
            nutrition_type_dropdown_chosen==null ||
            !isNumeric(nutrition_qty_controller.text) ||
            !isNumeric(nutrition_mass_controller.text) ||
            !isNumeric(nutrition_mass_controller.text) ||
            !isNumeric(nutrition_calories_controller.text)
          )
          {
            ScaffoldMessenger.of(context).showSnackBar(notify_snackbar("Invalid/missing field"));
          }
          else
          {
            database_insert_nutrition(
              nutrition_name_controller.text,
              nutrition_form_dropdown_chosen ?? "",
              nutrition_type_dropdown_chosen ?? "",
              double.parse(nutrition_qty_controller.text),
              double.parse(nutrition_calories_controller.text),
              double.parse(nutrition_mass_controller.text),
              double.parse(nutrition_carbs_controller.text),
              double.parse(nutrition_proteins_controller.text),
              double.parse(nutrition_fats_controller.text),
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

        if(datatype_dropdown_chosen=="Symptom")
        {
          if(
            symptoms_name_controller.text.isEmpty
          )
          {
            ScaffoldMessenger.of(context).showSnackBar(notify_snackbar("Symptom is empty"));
          }
          else
          {
            // Convert bool to int
            int _symptoms_resolved = 0;
            if(symptoms_resolved!= null)
            {
              if(symptoms_resolved ?? false)
              {
                _symptoms_resolved = 1;
              }
              else
              {
                _symptoms_resolved = 0;
              }
            }

            // Convert optional end date into String
            String _symptoms_end_date = "";
            if(symptoms_end_date!=null)
            {
              _symptoms_end_date = symptoms_end_date?.toIso8601String() ?? "";
            }

            database_insert_symptom(
              symptoms_name_controller.text,
              1,
              _symptoms_resolved,
              _symptoms_end_date,
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

        if(datatype_dropdown_chosen=="Time")
        {
          if(
            time_type_dropdown_chosen==null ||
            time_duration_hours_controller.text.isEmpty ||
            time_duration_minutes_controller.text.isEmpty ||
            !isNumeric(time_duration_hours_controller.text) ||
            !isNumeric(time_duration_minutes_controller.text)
          )
          {
            ScaffoldMessenger.of(context).showSnackBar(notify_snackbar("Invalid/missing field"));
          }
          else
          {
            int duration = int.parse(time_duration_hours_controller.text) * 60 + int.parse(time_duration_minutes_controller.text);

            database_insert_time(
              time_type_dropdown_chosen ?? "",
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

        if(datatype_dropdown_chosen=="Vitals")
        {
          if(vital_name_dropdown_chosen==null)
          {
            ScaffoldMessenger.of(context).showSnackBar(notify_snackbar("Choose vital data type"));
          }
          else
          {
            if(vital_name_dropdown_chosen=="Body Temperature")
            {
              if(
                vital_bodytemperature_controller.text.isEmpty ||
                !isNumeric(vital_bodytemperature_controller.text)
              )
              {
                ScaffoldMessenger.of(context).showSnackBar(notify_snackbar("Invalid/missing temperature data"));
              }
              else
              {
                database_insert_vitals(
                  vital_name_dropdown_chosen ?? " ",
                  vital_bodytemperature_controller.text,
                  "C",
                  entry_date,
                  general_notes_controller.text,
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

            if(vital_name_dropdown_chosen=="Blood Oxygen")
            {
              if(
                vital_bloodoxygen_controller.text.isEmpty ||
                !isNumeric(vital_bloodoxygen_controller.text)
              )
              {
                ScaffoldMessenger.of(context).showSnackBar(notify_snackbar("Invalid/missing blood oxygen data"));
              }
              else
              {
                database_insert_vitals(
                  vital_name_dropdown_chosen ?? " ",
                  vital_bloodoxygen_controller.text,
                  "%",
                  entry_date,
                  general_notes_controller.text,
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

            if(vital_name_dropdown_chosen=="Blood Pressure")
            {
              if(
                vital_bloodpressure_systolic_controller.text.isEmpty ||
                !isNumeric(vital_bloodpressure_systolic_controller.text) ||
                vital_bloodpressure_diastolic_controller.text.isEmpty ||
                !isNumeric(vital_bloodpressure_diastolic_controller.text)
              )
              {
                ScaffoldMessenger.of(context).showSnackBar(notify_snackbar("Invalid/missing blood oxygen data"));
              }
              else
              {
                database_insert_vitals(
                  vital_name_dropdown_chosen ?? " ",
                  "${vital_bloodpressure_systolic_controller.text}/${vital_bloodpressure_diastolic_controller.text}",
                  "",
                  entry_date,
                  general_notes_controller.text,
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

            if(vital_name_dropdown_chosen=="Blood Sugar")
            {
              if(
                vital_bloodsugar_controller.text.isEmpty ||
                !isNumeric(vital_bloodsugar_controller.text)
              )
              {
                ScaffoldMessenger.of(context).showSnackBar(notify_snackbar("Invalid/missing blood sugar data"));
              }
              else
              {
                database_insert_vitals(
                  vital_name_dropdown_chosen ?? " ",
                  vital_bloodsugar_controller.text,
                  "mmol/L",
                  entry_date,
                  general_notes_controller.text,
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

            if(vital_name_dropdown_chosen=="Heartrate")
            {
              if(
                vital_heartrate_controller.text.isEmpty ||
                !isNumeric(vital_heartrate_controller.text)
              )
              {
                ScaffoldMessenger.of(context).showSnackBar(notify_snackbar("Invalid/missing heartrate data"));
              }
              else
              {
                database_insert_vitals(
                  vital_name_dropdown_chosen ?? " ",
                  vital_heartrate_controller.text,
                  "bpm",
                  entry_date,
                  general_notes_controller.text,
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
        }

        if(datatype_dropdown_chosen=="Workout")
        {
          if(
            workout_name_controller.text.isEmpty ||
            workout_type_controller.text.isEmpty ||
            workout_weight_controller.text.isEmpty ||
            workout_reps_controller.text.isEmpty ||
            workout_sets_controller.text.isEmpty ||
            workout_duration_hours_controller.text.isEmpty ||
            workout_duration_minutes_controller.text.isEmpty ||
            workout_calories_controller.text.isEmpty ||
            // Check if number
            !isNumeric(workout_weight_controller.text) ||
            !isNumeric(workout_reps_controller.text) ||
            !isNumeric(workout_sets_controller.text) ||
            !isNumeric(workout_duration_hours_controller.text) ||
            !isNumeric(workout_duration_minutes_controller.text) ||
            !isNumeric(workout_calories_controller.text)
          )
          {
            ScaffoldMessenger.of(context).showSnackBar(notify_snackbar("Empty/Invalid field"));
          }
          else
          {
            int duration = int.parse(workout_duration_hours_controller.text) * 60 + int.parse(workout_duration_minutes_controller.text);
            int reps = int.parse(workout_sets_controller.text) * int.parse(workout_reps_controller.text);

            database_insert_workout(
              workout_name_controller.text,
              workout_type_controller.text,
              duration,
              double.parse(workout_calories_controller.text),
              reps,
              double.parse(workout_weight_controller.text),
              entry_date,
              general_notes_controller.text,
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
      },
    );
  }
}
