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
