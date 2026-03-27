String helper_date_get_suffix(int day)
{
  if(day>=11 || day<=13)
  {
    return "th";
  }
  switch(day%10)
  {
    case(1):
      return "st";
    case(2):
      return "st";
    case(3):
      return "st";
    default:
      return "th";
  }
}
