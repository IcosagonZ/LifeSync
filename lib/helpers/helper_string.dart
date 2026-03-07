// Convert duration in mins to String
String helper_get_duration(int duration)
{
  if(duration==0)
  {
    return "0 mins";
  }

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

// Get values like 54 mins, 1.5 hrs
String helper_get_duration_single(int duration)
{
  if(duration==0)
  {
    return "0 mins";
  }

  String duration_string = "";
  if(duration<60)
  {
    duration_string = "${duration} mins";
  }
  else
  {
    if(duration%60==0)
    {
      duration_string = "${(duration/60).toInt()} hrs";
    }
    else
    {
      duration_string = "${(duration/60).toStringAsFixed(1)} hrs";
    }
  }

  return duration_string;
}

// Convert distance in m to km and String
String helper_get_distance(int distance)
{
  if(distance==0)
  {
    return "0 km";
  }

  String distance_string = "";
  if(distance<1000)
  {
    distance_string = "${distance} m";
  }
  else
  {
    distance_string = "${distance~/1000} km";
    if(distance%1000!=0)
    {
      distance_string += " ${distance%1000} m";
    }
  }

  return distance_string;
}

String helper_get_distance_single(int distance)
{
  //print(distance/1000);
  if(distance==0)
  {
    return "0 km";
  }

  String distance_string = "";
  if(distance<1000)
  {
    distance_string = "${distance} m";
  }
  else
  {
    if(distance%1000==0)
    {
      distance_string = "${(distance/1000).toInt()} km";
    }
    else
    {
      distance_string = "${(distance/1000).toStringAsFixed(1)} km";
    }
  }

  return distance_string;
}

// Calculate steps from distance
String helper_get_steps(int distance, int duration)
{
  double speed = distance/(duration*60);

  double stride_length = 0.71;
  if(speed>=3)
  {
    stride_length = 1.2;
  }
  else if(speed>=2)
  {
    stride_length = 1.05;
  }
  else if(speed>=1.5)
  {
    stride_length = 0.85;
  }
  else if(speed>=1.2)
  {
    stride_length = 0.71;
  }
  else
  {
    stride_length = 0.6;
  }

  double steps = distance/stride_length;

  return "${steps.toInt()} steps";
}
