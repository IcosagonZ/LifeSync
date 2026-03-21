part of '../add_data.dart';


final datatypes_valid = [
  "academics_absent",
  "academics_assignment",
  "academics_exam",
  "academics_marks",
  "activity",
  "body_measurements",
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
        setState((){
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
        setState((){
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
        setState((){
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

      if(datatype=="mind_mood")
      {
        List<MindMoodData> mind_mood_data_list = await database_get_mind_mood_from_id(id);
        MindMoodData mind_mood_data = mind_mood_data_list.first;

        // Set widgets
        setState((){
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
    }
  }
}
