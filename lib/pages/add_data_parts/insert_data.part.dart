part of '../add_data.dart';

extension InsertData on Page_AddData_State{
  void insertData(String argument)
  async{
    //print(argument);
    final datatype = argument;

    if(datatype=="academics")
    {
      // Set widgets
      setState((){
        datatype_dropdown_chosen="Academics";
      });
    }

    if(datatype=="academics_absent")
    {
      // Set widgets
      setState((){
        datatype_dropdown_chosen="Academics";
        academics_dropdown_chosen="Absent";
      });
    }

    if(datatype=="academics_assignment")
    {
      // Set widgets
      setState(()
      {
        datatype_dropdown_chosen="Academics";
        academics_dropdown_chosen="Assignment";
      });
    }

    if(datatype=="academics_exam")
    {
      // Set widgets
      setState(()
      {
        datatype_dropdown_chosen="Academics";
        academics_dropdown_chosen="Exam";
      });
    }

    if(datatype=="academics_marks")
    {
      // Set widgets
      setState(()
      {
        datatype_dropdown_chosen="Academics";
        academics_dropdown_chosen="Marks";
      });
    }

    if(datatype=="activity")
    {
      // Set widgets
      setState(()
      {
        datatype_dropdown_chosen="Activity";
      });
    }

    if(datatype=="body_measurement")
    {

      // Set widgets
      setState(()
      {
        datatype_dropdown_chosen="Body Measurements";
      });
    }

    if(datatype=="mind_mood")
    {
      // Set widgets
      setState(()
      {
        datatype_dropdown_chosen="Mind";
      });
    }

    if(datatype=="nutrition")
    {
      // Set widgets
      setState(()
      {
        datatype_dropdown_chosen="Nutrition";
      });
    }

    if(datatype=="symptom")
    {
      // Set widgets
      setState(()
      {
        datatype_dropdown_chosen="Symptom";
      });
    }

    if(datatype=="time")
    {
      // Set widgets
      setState(()
      {
        datatype_dropdown_chosen="Time";
      });
    }

    if(datatype=="sleep")
    {
      // Set widgets
      setState(()
      {
        datatype_dropdown_chosen="Time";
        time_type_dropdown_chosen="Sleep";
      });
    }

    if(datatype=="vitals")
    {
      // Set widgets
      setState(()
      {
        datatype_dropdown_chosen="Vitals";
      });
    }

    if(datatype=="workout")
    {
      // Set widgets
      setState(()
      {
        datatype_dropdown_chosen="Workout";
      });
    }
  }
}
