import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../main.dart';

import '../../data/database.dart';
import '../../data/models/workout.dart';

import '../../data/iconmapper.dart';

import '../../components/recents_listtile_multiline.dart';
import '../../components/avatar_gradient.dart';

class Page_Workout extends StatefulWidget
{
  const Page_Workout({super.key});

  @override
  State<Page_Workout> createState() => Page_Workout_State();
}

class Page_Workout_State extends State<Page_Workout> with RouteAware
{
  // Widget variables
  DateTime data_timenow = DateTime.now();

  List<WorkoutData> workout_data = [];
  int workout_data_total_calories = 0;

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
    List<WorkoutData> workout_data_result = await database_get_workout_for_date(data_timenow);
    int workout_data_total_calories_result = await database_aggregate_workout_calories(data_timenow);

    setState(()
    {
      workout_data = workout_data_result;
      workout_data_total_calories_result = workout_data_total_calories;
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

    final color_primary = color_scheme.primary;//Theme.of(context).extension<ColorsOverviewButtons>()?.workout;
    final color_secondary = color_scheme.secondary;
    final color_onprimary = color_scheme.onPrimary;
    final color_onsecondary = color_scheme.onSecondary;
    final color_background = color_scheme.onBackground;
    final color_surface = color_scheme.onSurface;

    final style_displaylarge = text_theme.displayLarge;
    final style_displaymedium = text_theme.displayMedium;
    final style_displaysmall = text_theme.displaySmall;

    final style_headlinelarge = text_theme.headlineLarge;
    final style_headlinemedium = text_theme.headlineMedium;
    final style_headlinesmall = text_theme.headlineSmall;

    final style_titlelarge = text_theme.titleLarge;
    final style_titlemedium = text_theme.titleMedium;
    final style_titlesmall = text_theme.titleSmall;

    final style_cardlabel = TextStyle(fontWeight: FontWeight.w600);

    return Scaffold(
      appBar: AppBar(
        title: Text("Workout"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children:[

            Text("Overview", style: style_titlelarge),
            SizedBox(height: 16),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text("Calories burned", style: style_cardlabel)
                              ),
                              Text("$workout_data_total_calories cal")
                            ],
                          ),
                        ]
                      )
                    ),
                    SizedBox(width: 32),
                    AvatarGradient(
                      "N/A",
                      "Score",
                      [
                        color_primary,
                        color_secondary
                      ]
                    ),
                  ],
                )
              )
            ),
            SizedBox(height: 16),
            Text("Today", style: style_titlelarge),
            SizedBox(height: 16),
            Card.outlined(
              child: Padding(
                padding: EdgeInsets.all(2),
                child: Stack(
                  children: [
                    Visibility(
                      visible: workout_data.isEmpty,
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(
                          child: Text("No data available")
                        ),
                      )
                    ),
                    Visibility(
                      visible: workout_data.isNotEmpty,
                      child: Center(
                        child: Column(
                          spacing: 2,
                          children: List.generate(workout_data.length, (index){
                            final data = workout_data[index];
                            final tile = RecentsListTileMultiline(
                              list_icon: Icon(iconmapper_geticon("Workout")),
                              list_title: data.name,
                              list_subtitle: "${data.reps} reps",
                              list_trail: DateFormat('h:mm a').format(data.entry_date),
                              id: data.id,
                              datatype: "workout",
                            );

                            if(index>0)
                            {
                              return Column(
                                children: [
                                  Divider(height: 1),
                                  tile,
                                ]
                              );
                            }
                            else
                            {
                              return tile;
                            }
                          }),
                        )
                      )
                    ),
                  ]
                )
              )
            )
          ]
        )
      ),
    );
  }
}
