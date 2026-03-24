import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../main.dart';

import '../../data/database.dart';
import '../../data/models/activity.dart';

import '../../data/iconmapper.dart';
import '../../helpers/helper_string.dart';

import '../../components/recents_listtile_multiline.dart';
import '../../components/avatar_gradient.dart';

// Misc
//import '../../colors/colors_overview_buttons.dart';

class Page_Activity extends StatefulWidget
{
  const Page_Activity({super.key});

  @override
  State<Page_Activity> createState() => Page_Activity_State();
}

class Page_Activity_State extends State<Page_Activity> with RouteAware
{
  // Widget variables
  DateTime data_timenow = DateTime.now();

  List<ActivityData> activity_data = [];

  int activity_data_total_calories = 0;
  int activity_data_total_distance = 0;
  int activity_data_total_duration = 0;
  int activity_data_total_steps = 0;

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
    List<ActivityData> activity_data_result = await database_get_activity_for_date(data_timenow);
    int activity_data_total_calories_result = await database_aggregate_activity_calories(data_timenow);
    int activity_data_total_distance_result = await database_aggregate_activity_distance(data_timenow);
    int activity_data_total_duration_result = await database_aggregate_activity_duration(data_timenow);
    int activity_data_total_steps_result = await database_aggregate_activity_steps(data_timenow);

    setState(()
    {
      activity_data = activity_data_result;
      activity_data_total_calories = activity_data_total_calories_result;
      activity_data_total_distance = activity_data_total_distance_result;
      activity_data_total_duration = activity_data_total_duration_result;
      activity_data_total_steps = activity_data_total_steps_result;
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

    final color_primary = color_scheme.primary;//Theme.of(context).extension<ColorsOverviewButtons>()?.activity;
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
        title: Text("Activity"),
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
                              Text("$activity_data_total_calories cal"),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: Text("Active time", style: style_cardlabel)
                              ),
                              Text(helper_get_duration(activity_data_total_duration)),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: Text("Steps", style: style_cardlabel)
                              ),
                              Text("$activity_data_total_steps steps"),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: Text("Distance", style: style_cardlabel)
                              ),
                              Text(helper_get_distance(activity_data_total_distance))
                            ],
                          )
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
                      visible: activity_data.isEmpty,
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(
                          child: Text("No data available")
                        ),
                      )
                    ),
                    Visibility(
                      visible: activity_data.isNotEmpty,
                      child: Center(
                        child: Column(
                          spacing: 2,
                          children: List.generate(activity_data.length, (index)
                          {
                            final data = activity_data[index];
                            final tile = RecentsListTileMultiline(
                              list_icon: Icon(iconmapper_geticon("Activity", data.name)),
                              list_title: data.name,
                              list_subtitle: "${helper_get_duration(data.duration)}, ${helper_get_distance_single(data.distance)}, ${data.calories} cal",
                              list_trail: DateFormat('h:mm a').format(data.entry_date),
                              id: data.id,
                              datatype: "activity",
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
