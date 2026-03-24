import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

// Data
import '../data/database.dart';
import '../helpers/helper_string.dart';
import '../helpers/helper_calculate.dart';

// Pages
import '../main.dart';
import 'timeline.dart';
import 'settings.dart';
import 'add_data.dart';
import 'recommendations.dart';
import 'login.dart';
import 'chat.dart';
import 'goals.dart';

// Page sections
import 'sections/academics.dart';
import 'sections/activity.dart';
import 'sections/bodymeasurements.dart';
import 'sections/mind.dart';
import 'sections/notes.dart';
import 'sections/nutrition.dart';
import 'sections/sleep.dart';
import 'sections/symptoms.dart';
import 'sections/time.dart';
import 'sections/vitals.dart';
import 'sections/workout.dart';

// Misc
import '../components/icon_gradient.dart';
import '../components/mask_gradient.dart';
import '../components/text_logo.dart';

class Page_Overview extends StatefulWidget
{
  const Page_Overview({super.key});

  @override
  State<Page_Overview> createState() => Page_Overview_State();
}

class Page_Overview_State extends State<Page_Overview> with RouteAware
{
  // Widget variables
  DateTime data_timenow = DateTime.now();

  int activity_data_total_calories = 0;
  int activity_data_total_distance = 0;
  int activity_data_total_duration = 0;
  int activity_data_total_steps = 0;

  int nutrition_data_total_calories = 0;
  int workout_data_total_calories = 0;

  int data_total_burned_calories = 0;
  int data_calorie_deficit = 0;

  int data_time_study = 0;
  int data_time_sleep = 0;
  int data_time_free = 0;

  int data_latest_height = 0;
  int data_latest_weight = 0;

  // Route aware initializers
  @override
  void didChangeDependencies()
  {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void initState()
  {
    initData();

    super.initState();
  }

  Future<void> initData() async
  {
    if(!mounted)
    {
      return;
    }

    int activity_data_total_calories_result = await database_aggregate_activity_calories(data_timenow);
    int activity_data_total_distance_result = await database_aggregate_activity_distance(data_timenow);
    int activity_data_total_duration_result = await database_aggregate_activity_duration(data_timenow);
    int activity_data_total_steps_result = await database_aggregate_activity_steps(data_timenow);

    int nutrition_data_total_calories_result = await database_aggregate_nutrition_calories(data_timenow);

    int workout_data_total_calories_result = await database_aggregate_workout_calories(data_timenow);

    int data_time_study_result = await database_aggregate_time_study(data_timenow);
    // Get previous datas sleep data since entry_datetime = time person went to bed
    int data_time_sleep_result = await database_aggregate_time_sleep(data_timenow.subtract(Duration(days: 1)));
    int data_time_free_result = await database_aggregate_time_free(data_timenow);

    int data_latest_height_result = await database_latest_body_height();
    int data_latest_weight_result = await database_latest_body_weight();

    setState(()
    {
      activity_data_total_calories = activity_data_total_calories_result;
      activity_data_total_distance = activity_data_total_distance_result;
      activity_data_total_duration = activity_data_total_duration_result;
      activity_data_total_steps = activity_data_total_steps_result;

      nutrition_data_total_calories = nutrition_data_total_calories_result;
      workout_data_total_calories = workout_data_total_calories_result;

      data_total_burned_calories = activity_data_total_calories + workout_data_total_calories;
      data_calorie_deficit = data_total_burned_calories - nutrition_data_total_calories;

      data_time_study = data_time_study_result;
      data_time_sleep = data_time_sleep_result;
      data_time_free = data_time_free_result;

      data_latest_height = data_latest_height_result;
      data_latest_weight = data_latest_weight_result;
    });
  }

  // Route aware functions
  @override
  void didPopNext()
  {
    initData();
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
    final style_titlesmall = text_theme.titleSmall?.copyWith(
      fontWeight: FontWeight.w500
    );;

    // Widget size variables
    const double spacing_quickaction = 8;
    const double iconsize_quickaction = 24;

    return Scaffold(
      //backgroundColor: Colors.transparent,
      //extendBodyBehindAppBar: true,
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              /*
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: AlignmentGeometry.topLeft,
                  end:AlignmentGeometry.bottomRight,
                  colors: [
                    color_primary.withValues(alpha: 0.01),
                    color_scheme.surface,
                  ]
                )
              ),*/
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextLogo(
                    "LifeSyncAI",
                    [
                      color_primary,
                      color_primary.withValues(alpha: 0.5)
                    ],
                    48
                  ),
                  Text(
                    "Version 0.1.1",
                    style: TextStyle(
                      color: color_primary
                    ),
                  )
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.login),
              title: Text("Login"),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)
                {
                  return const Page_Login();
                },
                ));
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.chat),
              title: Text("Chat with AI"),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)
                {
                  return const Page_Chat();
                },
                ));
              },
            ),
            ListTile(
              leading: Icon(Icons.lightbulb),
              title: Text("Recommendations"),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)
                {
                  return const Page_Recommendations();
                }
                ));
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.add),
              title: Text("Add data"),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)
                {
                  return const Page_AddData();
                },
                ));
              },
            ),
            ListTile(
              leading: Icon(Icons.notes),
              title: Text("Notes"),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)
                {
                  return const Page_Notes();
                }
                ));
              },
            ),
            ListTile(
              leading: Icon(Icons.timeline),
              title: Text("Timeline"),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)
                {
                  return const Page_Timeline();
                }
                ));
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.sports_football),
              title: Text("Goals"),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)
                {
                  return const Page_Goals();
                }
                ));
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)
                {
                  return const Page_Settings();
                }
                ));
              },
            ),
          ]
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Overview"),
      ),
      body: Container(
        //width: double.infinity,
        //height:double.infinity,
        padding: EdgeInsets.all(16),
        /*decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: AlignmentGeometry.topLeft,
            end: AlignmentGeometry.bottomRight,
            colors: [
              //Colors.white,
              //Color(0xffadb5bd),
              Color(0xff212529),
              Colors.black,
            ]
          )
        ),*/
        child: ListView(
          children:[
            Row(
              children:
              [
                // Left quick action buttons
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                  [
                    IconButton(
                      icon: IconGradient(
                        Symbols.schedule,
                        [
                          Colors.grey,
                          Colors.white,
                        ],
                        iconsize_quickaction
                      ),
                      tooltip: "Time",
                      onPressed: (){
                        print("Time pressed");
                        Navigator.push(context, MaterialPageRoute(builder: (context)
                        {
                          return const Page_Time();
                        }
                        ));
                      },
                    ),
                    SizedBox(height: spacing_quickaction),
                    IconButton(
                      icon: IconGradient(
                        Symbols.grading,
                        [
                          Colors.lightBlue,
                          Colors.purple,
                        ],
                        iconsize_quickaction
                      ),
                      tooltip: "Academics",
                      onPressed: (){
                        print("Academics pressed");
                        Navigator.push(context, MaterialPageRoute(builder: (context)
                        {
                          return const Page_Academics();
                        }
                        ));
                      },
                    ),
                    SizedBox(height: spacing_quickaction),
                    IconButton(
                      icon: IconGradient(
                        Symbols.sports_basketball,
                        [
                          Colors.cyan,
                          Colors.deepPurple,
                        ],
                        iconsize_quickaction
                      ),
                      tooltip: "Activity",
                      onPressed: (){
                        print("Activity pressed");
                        Navigator.push(context, MaterialPageRoute(builder: (context)
                        {
                          return const Page_Activity();
                        }
                        ));
                      },
                    ),
                    SizedBox(height: spacing_quickaction),
                    IconButton(
                      icon: IconGradient(
                        Symbols.cognition_2,
                        [
                          Colors.purple,
                          Colors.blue,
                        ],
                        iconsize_quickaction
                      ),
                      tooltip: "Mind",
                      onPressed: (){
                        print("Mind pressed");
                        Navigator.push(context, MaterialPageRoute(builder: (context)
                        {
                          return const Page_Mind();
                        }
                        ));
                      },
                    ),
                    SizedBox(height: spacing_quickaction),
                    IconButton(
                      icon: IconGradient(
                        Symbols.ecg_heart,
                        [
                          Colors.red,
                          Colors.purple,
                        ],
                        iconsize_quickaction
                      ),
                      tooltip: "Vitals",
                      onPressed: (){
                        print("Vitals pressed");
                        Navigator.push(context, MaterialPageRoute(builder: (context)
                        {
                          return const Page_Vitals();
                        }
                        ));
                      },
                    ),
                  ]
                ),
                // Avatar
                Expanded(
                  child: MaskGradient(
                    SvgPicture.asset(
                      "assets/avatar.svg",
                      colorFilter: ColorFilter.mode(color_surface, BlendMode.srcIn),
                      fit: BoxFit.contain,
                      height: MediaQuery.of(context).size.height * 0.45,
                    ),
                    [
                      Colors.green,
                      Colors.red,
                    ]
                  ),
                ),
                // Right quick action buttons
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                  [
                    IconButton(
                      icon: IconGradient(
                        Symbols.bedtime,
                        [
                          Colors.blue,
                          Colors.purple,
                        ],
                        iconsize_quickaction
                      ),
                      tooltip: "Sleep",
                      onPressed: (){
                        print("Sleep pressed");
                        Navigator.push(context, MaterialPageRoute(builder: (context)
                        {
                          return const Page_Sleep();
                        }
                        ));
                      },
                    ),
                    SizedBox(height: spacing_quickaction),
                    IconButton(
                      icon: IconGradient(
                        Symbols.exercise,
                        [
                          Colors.grey,
                          Colors.purple,
                        ],
                        iconsize_quickaction
                      ),
                      tooltip: "Workout",
                      onPressed: (){
                        print("Workout pressed");
                        Navigator.push(context, MaterialPageRoute(builder: (context)
                        {
                          return const Page_Workout();
                        }
                        ));
                      },
                    ),
                    SizedBox(height: spacing_quickaction),
                    IconButton(
                      icon: IconGradient(
                        Symbols.cookie,
                        [
                          Colors.deepOrange,
                          Colors.brown,
                        ],
                        iconsize_quickaction
                      ),
                      tooltip: "Nutrition",
                      onPressed: (){
                        print("Nutrition pressed");
                        Navigator.push(context, MaterialPageRoute(builder: (context)
                        {
                          return const Page_Nutrition();
                        }
                        ));
                      },
                    ),
                    SizedBox(height: spacing_quickaction),
                    IconButton(
                      icon: IconGradient(
                        Symbols.symptoms,
                        [
                          Colors.pink,
                          Colors.purple,
                        ],
                        iconsize_quickaction
                      ),
                      tooltip: "Symptoms",
                      onPressed: (){
                        print("Symptoms pressed");
                        Navigator.push(context, MaterialPageRoute(builder: (context)
                        {
                          return const Page_Symptoms();
                        }
                        ));
                      },
                    ),
                    SizedBox(height: spacing_quickaction),
                    IconButton(
                      icon: IconGradient(
                        Symbols.height,
                        [
                          Colors.yellow,
                          Colors.purple,
                        ],
                        iconsize_quickaction
                      ),
                      tooltip: "Body",
                      onPressed: (){
                        print("Body pressed");
                        Navigator.push(context, MaterialPageRoute(builder: (context)
                        {
                          return const Page_BodyMeasurements();
                        }
                        ));
                      },
                    ),
                  ]
                ),
              ]
            ),
            SizedBox(
              height: 32
            ),
            // Summary
            Center(
              child: Text("Summary", style:style_headlinemedium),
            ),
            SizedBox(
              height: 8
            ),
            Center(
              child: Text("All good", style:style_titlelarge),
            ),
            SizedBox(
              height: 16
            ),

            // Time
            // Time label
            Row(
              children: [
                Expanded(
                  child: Divider(),
                ),
                SizedBox(
                  width: 16,
                ),
                Text("Time", style:style_titlesmall),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Divider(),
                )
              ]
            ),
            SizedBox(
              height: 8
            ),

            // Time details
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(helper_get_duration_single(data_time_sleep), style:style_headlinesmall),
                      SizedBox(height: 8),
                      Text("Slept", style:style_titlesmall),
                    ]
                  )
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(helper_get_duration_single(data_time_study), style:style_headlinesmall),
                      SizedBox(height: 8),
                      Text("Studied", style:style_titlesmall),
                    ]
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(helper_get_duration_single(data_time_free), style:style_headlinesmall),
                      SizedBox(height: 8),
                      Text("Free", style:style_titlesmall),
                    ]
                  ),
                ),
              ]
            ),
            SizedBox(
              height: 16
            ),

            // Activity
            // Activity label
            Row(
              children: [
                Expanded(
                  child: Divider(),
                ),
                SizedBox(
                  width: 16,
                ),
                Text("Activity", style:style_titlesmall),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Divider(),
                )
              ]
            ),
            SizedBox(
              height: 8
            ),

            // Activity details
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text("$activity_data_total_steps", style:style_headlinesmall),
                      SizedBox(height: 8),
                      Text("Steps", style:style_titlesmall),
                    ]
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(helper_get_distance_single(activity_data_total_distance), style:style_headlinesmall),
                      SizedBox(height: 8),
                      Text("Moved", style:style_titlesmall),
                    ]
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(helper_get_duration_single(activity_data_total_duration), style:style_headlinesmall),
                      SizedBox(height: 8),
                      Text("Active", style:style_titlesmall),
                    ]
                  ),
                ),
              ]
            ),
            SizedBox(
              height: 16
            ),

            // Calorie
            // Calorie label
            Row(
              children: [
                Expanded(
                  child: Divider(),
                ),
                SizedBox(
                  width: 16,
                ),
                Text("Calories", style:style_titlesmall),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Divider(),
                )
              ]
            ),
            SizedBox(
              height: 8
            ),

            // Calorie details
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text("$nutrition_data_total_calories cal", style:style_headlinesmall),
                      SizedBox(height: 8),
                      Text("Consumed", style:style_titlesmall),
                    ]
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text("$data_total_burned_calories cal", style:style_headlinesmall),
                      SizedBox(height: 8),
                      Text("Burned", style:style_titlesmall),
                    ]
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text("$data_calorie_deficit cal", style:style_headlinesmall),
                      SizedBox(height: 8),
                      Text("Deficit", style:style_titlesmall),
                    ]
                  ),
                ),
              ]
            ),
            SizedBox(
              height: 16
            ),

            // Body
            // Body label
            Row(
              children: [
                Expanded(
                  child: Divider(),
                ),
                SizedBox(
                  width: 16,
                ),
                Text("Body", style:style_titlesmall),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Divider(),
                )
              ]
            ),
            SizedBox(
              height: 8
            ),

            // Body details
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text("$data_latest_height cm", style:style_headlinesmall),
                      SizedBox(height: 8),
                      Text("Height", style:style_titlesmall),
                    ]
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text("${helper_get_bmi(data_latest_height, data_latest_weight).toStringAsFixed(1)}", style:style_headlinesmall),
                      SizedBox(height: 8),
                      Text("BMI", style:style_titlesmall),
                    ]
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text("$data_latest_weight kg", style:style_headlinesmall),
                      SizedBox(height: 8),
                      Text("Weight", style:style_titlesmall),
                    ]
                  ),
                ),
              ]
            ),
            SizedBox(
              height: 16
            ),
          ]
        )
      ),

      /*
      floatingActionButton: FloatingActionButton(
        onPressed: ()
        {
          print("Add data pressed");
        },
        child: const Icon(Symbols.add),
      ),
      */
    );
  }
}
