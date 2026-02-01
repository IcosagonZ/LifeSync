// Convert duration in mins to String

String helper_get_duration(int duration)
{
  String duration_string = "";
  if(duration<60)
  {
    duration_string = "${duration} mins";
  }
  else
  {
    duration_string = "${duration~/60} hrs";
    if(duration~/60!=0)
    {
      duration_string += " ${duration%60} mins";
    }
  }

  return duration_string;
}
