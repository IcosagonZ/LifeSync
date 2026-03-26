import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:intl/intl.dart';

import '../../main.dart';

import '../../data/database.dart';
import '../../data/models/time.dart';

import '../../data/iconmapper.dart';
import '../../helpers/helper_string.dart';

import '../add_data.dart';

import '../../components/listtile_single_icon.dart';

class Page_Time extends StatefulWidget
{
  const Page_Time({super.key});

  @override
  State<Page_Time> createState() => Page_Time_State();
}

class Page_Time_State extends State<Page_Time> with RouteAware
{
  Container piechart_label(String label_text)
  {
    return Container(
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label_text,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Widget variables
  DateTime data_timenow = DateTime.now();

  List<TimeDataGrouped> time_data_grouped = [];
  List<TimeData> time_data = [];

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
    List<TimeDataGrouped> time_data_grouped_result = await database_get_time_for_date_grouped(data_timenow);
    List<TimeData> time_data_result = await database_get_time_for_date(data_timenow);
    setState(()
    {
      time_data_grouped = time_data_grouped_result;
      time_data = time_data_result;
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

    return Scaffold(
      appBar: AppBar(
        title: Text("Time"),
        actions: [
          IconButton(
            icon: Icon(Icons.playlist_add),
            tooltip: "Add data",
            onPressed: () async {
              //print("Add data pressed");
              final result = await Navigator.push(context, MaterialPageRoute(builder: (context)
              {
                return const Page_AddData();
              },
              settings: RouteSettings(
                arguments: "time",
              ),
              ));
              if(result!=null) // when returning
              {
                initData();
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children:[
            Visibility(
              visible: time_data_grouped.isNotEmpty,
              child: AspectRatio(
                aspectRatio: 1,
                child: Padding(
                  padding: EdgeInsets.all(32),
                  child: PieChart(
                    PieChartData(
                      sections: List.generate(time_data_grouped.length, (index){
                        if(time_data_grouped[index].duration!=0)
                        {
                          return PieChartSectionData(
                            color: color_primary,
                            value: time_data_grouped[index].duration.toDouble(),
                            title: "",
                            badgeWidget: Icon(time_data_grouped[index].icon, color:color_onprimary),
                          );
                        }
                        return PieChartSectionData();
                      })
                    )
                  )
                )
              )
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Stack(
                  children: [
                    Visibility(
                      visible: time_data_grouped.isEmpty,
                      child: Text("Data unavailable for current day")
                    ),
                    Visibility(
                      visible: time_data_grouped.isNotEmpty,
                      child: Column(
                        children: List.generate(time_data_grouped.length, (index){
                          if(time_data_grouped[index].duration!=0)
                          {
                            return Row(
                              children: [
                                Icon(time_data_grouped[index].icon, color: color_primary),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(time_data_grouped[index].event, style: TextStyle(color: color_primary))
                                ),
                                SizedBox(width: 8),
                                Text("${helper_get_duration(time_data_grouped[index].duration.toInt() ?? 0)}")
                              ],
                            );
                          }
                          return SizedBox(height: 0);
                        })
                      )
                    )
                  ]
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
                      visible: time_data.isEmpty,
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(
                          child: Text("No data available")
                        ),
                      )
                    ),
                    Visibility(
                      visible: time_data.isNotEmpty,
                      child: Center(
                        child: Column(
                          children: time_data.map((data)
                          {
                            return ListTileSingleIcon(
                              list_icon: Icon(iconmapper_geticon("Time", data.event)),
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
