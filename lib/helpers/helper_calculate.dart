// Calculate BMI
double helper_get_bmi(int _height, int weight)
{
  double height = _height/100; // convert height in cm to m
  double bmi = weight / (height*height);

  return bmi;
}

// Calculate daily calories required
int helper_get_calories_required(int user_height, int user_weight, int user_age, String user_gender)
{
  double user_basal_metabolic_rate = 10 * user_weight + 6.25 * user_height - 5.0 * user_age;
  if(user_gender=="F")
  {
    user_basal_metabolic_rate -= 161;
  }
  else
  {
    user_basal_metabolic_rate += 5;
  }

  final user_activity = "sedentary";

  final total_calories_multiplier = {
    "sedentary":1.2,
    "lightly_active":1.375,
    "moderately_active":1.55,
    "very_active":1.725,
    "extra_active":1.9,
  };
  double calorie_multipler = 1.2;
  //calorie_multipler = total_calories_multiplier[user_activity];
  var user_total_calorie_needs = user_basal_metabolic_rate * calorie_multipler;
  return user_total_calorie_needs.toInt();
}
