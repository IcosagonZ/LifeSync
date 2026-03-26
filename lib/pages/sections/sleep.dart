import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import 'package:intl/intl.dart';

import '../../main.dart';

import '../../data/database.dart';
import '../../data/models/time.dart';

import '../../helpers/helper_string.dart';

import '../../components/listtile_single_icon.dart';
import '../../components/avatar_gradient.dart';

class Page_Sleep extends StatefulWidget
{
  const Page_Sleep({super.key});

  @override
  State<Page_Sleep> createState() => Page_Sleep_State();
}

class Page_Sleep_State extends State<Page_Sleep> with RouteAware
{
  DateTime data_timenow = DateTime.now();


  DateTime data_datestart= DateTime.now().subtract(Duration(days: 7));
  DateTime data_dateend = DateTime.now();

  int data_time_sleep = 0;
  List<TimeData> data_time_sleep_range = [];

  String score = "N/A";

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
    // Get previous datas sleep data since entry_datetime = time person went to bed
    int data_time_sleep_result = await database_aggregate_time_sleep(data_timenow.subtract(Duration(days: 1)));
    final data_time_sleep_range_result = await database_get_time_sleep_date_range(data_datestart, data_dateend);
    final score_result = await database_get_score("sleep");

    setState(()
    {
      if(score_result!=-1)
      {
        score = score_result.toString();
      }
      else
      {
        score = "N/A";
      }
      data_time_sleep = data_time_sleep_result;
      data_time_sleep_range = data_time_sleep_range_result;
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

    final color_primary = color_scheme.primary;//Theme.of(context).extension<ColorsOverviewButtons>()?.sleep;
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
                                child: Text("Time slept yesterday", style: style_cardlabel)
                              ),
                              Text(helper_get_duration(data_time_sleep))
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: Text("Recommended", style: style_cardlabel)
                              ),
                              Text("8 hrs")
                            ],
                          )
                        ]
                      )
                    ),
                    SizedBox(width: 32),
                    AvatarGradient(
                      "${score}",
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
            Text("Recents", style: style_titlelarge),
            SizedBox(height: 16),
            Card(
              child: Padding(
                padding: EdgeInsets.all(2),
                child: Stack(
                  children: [
                    Visibility(
                      visible: data_time_sleep_range.isEmpty,
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(
                          child: Text("No data available")
                        ),
                      )
                    ),
                    Visibility(
                      visible: data_time_sleep_range.isNotEmpty,
                      child: Center(
                        child: Column(
                          children: data_time_sleep_range.map((data)
                          {
                            return ListTileSingleIcon(
                              list_icon: Icon(Symbols.sleep),
                              list_title: data.event,
                              list_subtitle: "${helper_get_duration(data.duration)}",
                              list_trail: DateFormat('h:mm a dd/mm').format(data.entry_date),
                              id: data.id,
                              datatype: "time",
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
