import 'package:flutter/material.dart';

import '../data/database.dart';

import '../components/snackbar_notify.dart';
import '../components/dialog_information.dart';

class Page_Goals extends StatefulWidget
{
  const Page_Goals({super.key});

  @override
  State<Page_Goals> createState() => Page_Goals_State();
}

class Page_Goals_State extends State<Page_Goals>
{
  // Controllers
  TextEditingController height_controller = TextEditingController();
  TextEditingController weight_controller = TextEditingController();
  TextEditingController age_controller = TextEditingController();
  TextEditingController gender_controller = TextEditingController();

  TextEditingController steps_controller = TextEditingController(text: "8000");
  TextEditingController distance_controller = TextEditingController(text: "6");
  TextEditingController calories_controller = TextEditingController(text: "0");

  TextEditingController study_controller = TextEditingController(text: "1");
  TextEditingController sleep_controller = TextEditingController(text: "8");
  TextEditingController exercise_controller = TextEditingController(text: "1");

  // Also move this to seperate file
  bool isNumeric(String s)
  {
    if(s.isEmpty)
    {
      return false;
    }
    else
    {
      return double.tryParse(s)!=null;
    }
  }

  @override
  void initState()
  {
    super.initState();

    loadData();
  }

  void loadData() async
  {
    // Check if goals table is empty
    final result = await database_isempty_goals();
    if(result)
    {
      return;
    }

    int height_result = await database_get_goal("height");
    int weight_result = await database_get_goal("weight");
    int age_result = await database_get_goal("age");
    int gender_result = await database_get_goal("gender");

    int steps_result = await database_get_goal("steps");
    int distance_result = await database_get_goal("distance");
    int calories_result = await database_get_goal("calories");

    int study_result = await database_get_goal("study");
    int sleep_result = await database_get_goal("sleep");
    int exercise_result = await database_get_goal("exercise");

    setState(()
    {
      height_controller.text = height_result.toString();
      weight_controller.text = weight_result.toString();
      age_controller.text = age_result.toString();

      if(gender_result==0)
      {
        gender_controller.text = "F";
      }
      else
      {
        gender_controller.text = "M";
      }

      steps_controller.text = steps_result.toString();
      distance_controller.text = distance_result.toString();
      calories_controller.text = calories_result.toString();

      study_controller.text = study_result.toString();
      sleep_controller.text = sleep_result.toString();
      exercise_controller.text = exercise_result.toString();
    });
  }

  Future<int> saveData() async
  {
    database_delete_goals();

    String gender = "0";
    if(gender_controller.text=="M")
    {
      gender = "1";
    }

    int height_result = await database_set_goal("height", height_controller.text);
    int weight_result = await database_set_goal("weight", weight_controller.text);
    int age_result = await database_set_goal("age", age_controller.text);
    int gender_result = await database_set_goal("gender", gender);

    int steps_result = await database_set_goal("steps", steps_controller.text);
    int distance_result = await database_set_goal("distance", distance_controller.text);
    int calories_result = await database_set_goal("calories", calories_controller.text);

    int study_result = await database_set_goal("study", study_controller.text);
    int sleep_result = await database_set_goal("sleep", sleep_controller.text);
    int exercise_result = await database_set_goal("exercise", exercise_controller.text);

    return height_result+weight_result+gender_result+steps_result+distance_result+calories_result+study_result+sleep_result+exercise_result;
  }

  @override
  Widget build(BuildContext context)
  {
    // Theming and text styles
    final color_scheme = Theme.of(context).colorScheme;
    final text_theme = Theme.of(context).textTheme;

    Color color_primary = color_scheme.primary;
    Color color_secondary = color_scheme.secondary;
    Color color_onprimary = color_scheme.onPrimary;
    Color color_onsecondary = color_scheme.onSecondary;
    Color color_background = color_scheme.onBackground;
    Color color_surface = color_scheme.onSurface;

    final style_displaylarge = text_theme.displayLarge;
    final style_displaymedium = text_theme.displayMedium;
    final style_displaysmall = text_theme.displaySmall;

    final style_headlinelarge = text_theme.headlineLarge;
    final style_headlinemedium = text_theme.headlineMedium;
    final style_headlinesmall = text_theme.headlineSmall;

    final style_titlelarge = text_theme.titleLarge;
    final style_titlemedium = text_theme.titleMedium;
    final style_titlesmall = text_theme.titleSmall;

    return Scaffold(
      appBar: AppBar(
        title: Text("Goals"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children:[
            Text("Basic details", style: style_titlelarge),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text("Height")
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 50,
                  ),
                  child: IntrinsicWidth(
                    child: TextField(
                      controller: height_controller,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        isCollapsed: true,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Text("cm"),
              ]
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text("Weight")
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 50,
                  ),
                  child: IntrinsicWidth(
                    child: TextField(
                      controller: weight_controller,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        isCollapsed: true,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Text("kg"),
              ]
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text("Age")
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 50,
                  ),
                  child: IntrinsicWidth(
                    child: TextField(
                      controller: age_controller,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        isCollapsed: true,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Text("yrs"),
              ]
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text("Gender")
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 50,
                  ),
                  child: IntrinsicWidth(
                    child: TextField(
                      controller: gender_controller,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        isCollapsed: true,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Text("M/F"),
              ]
            ),
            SizedBox(height: 16),
            Divider(),
            SizedBox(height: 16),
            Text("Goals", style: style_titlelarge),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text("Steps goal")
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 50,
                  ),
                  child: IntrinsicWidth(
                    child: TextField(
                      controller: steps_controller,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        isCollapsed: true,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Text("steps"),
              ]
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text("Distance goals")
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 50,
                  ),
                  child: IntrinsicWidth(
                    child: TextField(
                      controller: distance_controller,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        isCollapsed: true,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Text("km"),
              ]
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text("Calorie expenditure goals")
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 50,
                  ),
                  child: IntrinsicWidth(
                    child: TextField(
                      controller: calories_controller,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        isCollapsed: true,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Text("cal"),
              ]
            ),
            SizedBox(height: 16),
            Divider(),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text("Study goal")
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 50,
                  ),
                  child: IntrinsicWidth(
                    child: TextField(
                      controller: study_controller,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        isCollapsed: true,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Text("hrs"),
              ]
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text("Sleep goal")
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 50,
                  ),
                  child: IntrinsicWidth(
                    child: TextField(
                      controller: sleep_controller,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        isCollapsed: true,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Text("hrs"),
              ]
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text("Exercise goals")
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 50,
                  ),
                  child: IntrinsicWidth(
                    child: TextField(
                      controller: exercise_controller,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        isCollapsed: true,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Text("hrs"),
              ]
            ),
            SizedBox(height: 16),
          ]
        )
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: ElevatedButton(
            child: Text("Save data"),
            onPressed: () async
            {
              if(height_controller.text.isEmpty || !isNumeric(height_controller.text))
              {
                ScaffoldMessenger.of(context).showSnackBar(notify_snackbar("Invalid height"));
              }
              else if(weight_controller.text.isEmpty || !isNumeric(weight_controller.text))
              {
                ScaffoldMessenger.of(context).showSnackBar(notify_snackbar("Invalid weight"));
              }
              else if(age_controller.text.isEmpty || !isNumeric(age_controller.text))
              {
                ScaffoldMessenger.of(context).showSnackBar(notify_snackbar("Invalid age"));
              }
              else if(gender_controller.text!="M" && gender_controller.text!="F")
              {
                ScaffoldMessenger.of(context).showSnackBar(notify_snackbar("Invalid gender"));
              }
              // Goals
              else if(steps_controller.text.isEmpty || !isNumeric(steps_controller.text))
              {
                ScaffoldMessenger.of(context).showSnackBar(notify_snackbar("Invalid steps goal"));
              }
              else if(distance_controller.text.isEmpty || !isNumeric(distance_controller.text))
              {
                ScaffoldMessenger.of(context).showSnackBar(notify_snackbar("Invalid distance goal"));
              }
              else if(calories_controller.text.isEmpty || !isNumeric(calories_controller.text))
              {
                ScaffoldMessenger.of(context).showSnackBar(notify_snackbar("Invalid calories goal"));
              }
              // Time goals
              else if(study_controller.text.isEmpty || !isNumeric(study_controller.text))
              {
                ScaffoldMessenger.of(context).showSnackBar(notify_snackbar("Invalid study goal"));
              }
              else if(sleep_controller.text.isEmpty || !isNumeric(sleep_controller.text))
              {
                ScaffoldMessenger.of(context).showSnackBar(notify_snackbar("Invalid sleep goal"));
              }
              else if(exercise_controller.text.isEmpty || !isNumeric(exercise_controller.text))
              {
                ScaffoldMessenger.of(context).showSnackBar(notify_snackbar("Invalid exercise goal"));
              }
              // Enter data
              else{
                final result = await saveData();
                print(result);
                if(result==52)
                {
                  ScaffoldMessenger.of(context).showSnackBar(notify_snackbar("Saved data"));
                }
                else
                {
                  ScaffoldMessenger.of(context).showSnackBar(notify_snackbar("Error saving data"));
                }
              }
            },
          )
        )
      ),
    );
  }
}
