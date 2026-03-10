import 'package:flutter/material.dart';

import '../../data/database.dart';
import '../../data/models/time.dart';

import '../../helpers/helper_string.dart';

import '../../components/recents_listtile.dart';

class Page_Sleep extends StatefulWidget
{
  const Page_Sleep({super.key});

  @override
  State<Page_Sleep> createState() => Page_Sleep_State();
}

class Page_Sleep_State extends State<Page_Sleep>
{
  DateTime data_timenow = DateTime.now();
  int data_time_sleep = 0;

  @override
  void initState()
  {
    initData();

    super.initState();
  }

  Future<void> initData() async
  {
    // Get previous datas sleep data since entry_datetime = time person went to bed
    int data_time_sleep_result = await database_aggregate_time_sleep(data_timenow.subtract(Duration(days: 1)));

    setState(()
    {
      data_time_sleep = data_time_sleep_result;
    });
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

    // Widget variables
    List<TimelineData> recents_data = [];
    //List<TimelineData> recents_data = get_sleep_data();

    return Scaffold(
      appBar: AppBar(
        title: Text("Sleep"),
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
                                child: Text("Time slept", style: TextStyle(color: color_primary))
                              ),
                              Text(helper_get_duration(data_time_sleep))
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: Text("Recommended", style: TextStyle(color: color_primary))
                              ),
                              Text("8 hrs")
                            ],
                          )
                        ]
                      )
                    ),
                    SizedBox(width: 32),
                    CircleAvatar(
                      radius: 32,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("N/A"),
                          Text("Score", style: TextStyle(fontSize: 10)),
                        ]
                      ),
                    ),
                  ],
                )
              )
            ),
            SizedBox(height: 16),
            Text("Recents", style: style_titlelarge),
            SizedBox(height: 16),
            Card(
              child: Padding(
                padding: EdgeInsets.all(2),
                child: Stack(
                  children: [
                    Visibility(
                      visible: recents_data.isEmpty,
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(
                          child: Text("No data available")
                        ),
                      )
                    ),
                    Visibility(
                      visible: recents_data.isNotEmpty,
                      child: Center(
                        child: Column(
                          children: recents_data.map((data)
                          {
                            return RecentsListTile(
                              list_icon: Icon(data.icon),
                              list_title: data.title,
                              list_subtitle: data.subtitle,
                              list_date: data.date_time,
                            );
                          }).toList(),
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
