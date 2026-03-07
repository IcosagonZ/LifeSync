// Calculate BMI
double helper_get_bmi(int _height, int weight)
{
  double height = _height/100; // convert height in cm to m
  double bmi = weight / (height*height);

  return bmi;
}
