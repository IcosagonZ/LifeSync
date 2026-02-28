import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import '../../data/database.dart';
import '../../data/iconmapper.dart';

import '../../helpers/helper_string.dart';

class Page_Time extends StatefulWidget
{
  const Page_Time({super.key});

  @override
  State<Page_Time> createState() => Page_Time_State();
}

class Page_Time_State extends State<Page_Time>
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
  List<TimeDataGrouped> time_data_grouped = [];

  @override
  void initState()
  {
    initData();

    super.initState();
  }

  Future<void> initData() async
  {
    List<TimeDataGrouped> time_data_grouped_result = await database_get_time_for_date_grouped(DateTime.now());
    List<TimeData> time_data_result = await database_get_time();

    print(time_data_grouped_result.length);

    setState(()
    {
      time_data_grouped = time_data_grouped_result;
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

    Map<String, double> time_breakdown = {
      for (var data in time_data_grouped) data.event : data.duration.toDouble()
    };

    /*Map<String, double> time_breakdown = {
      "Sleep": 0,
      "Study": 3,
      "Eating": 3,
      "Hobby": 2,
      "Gaming": 2,
      "Outing": 1,
      "Commute": 1,
      "Entertainment": 3,
    };*/

    return Scaffold(
      appBar: AppBar(
        title: Text("Time"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children:[
            Visibility(
              visible: time_breakdown.isNotEmpty,
              child: AspectRatio(
                aspectRatio: 1,
                child: Padding(
                  padding: EdgeInsets.all(32),
                  child: PieChart(
                    PieChartData(
                      sections: [
                        // Sleep
                        PieChartSectionData(
                          color: color_primary,
                          value: time_breakdown["Sleep"],
                          title: "",
                          badgeWidget: (time_breakdown["Sleep"] ?? 0.0) > 0.01 ?
                          Icon(Symbols.bedtime, color:color_onprimary)
                          : null,
                        ),
                        // Study
                        PieChartSectionData(
                          color: color_primary,
                          value: time_breakdown["Study"],
                          title: "",
                          badgeWidget: (time_breakdown["Study"] ?? 0.0) > 0.01 ?
                          Icon(Symbols.book, color:color_onprimary)
                          : null,
                        ),
                        // Food
                        PieChartSectionData(
                          color: color_primary,
                          value: time_breakdown["Eating"],
                          title: "",
                          badgeWidget: (time_breakdown["Eating"] ?? 0.0) > 0.01 ?
                          Icon(Symbols.flatware, color:color_onprimary)
                          : null,
                        ),
                        // Hobby
                        PieChartSectionData(
                          color: color_primary,
                          value: time_breakdown["Hobby"],
                          title: "",
                          badgeWidget: (time_breakdown["Hobby"] ?? 0.0) > 0.01 ?
                          Icon(Symbols.construction, color:color_onprimary)
                          : null,
                        ),
                        // Gaming
                        PieChartSectionData(
                          color: color_primary,
                          value: time_breakdown["Gaming"],
                          title: "",
                          badgeWidget: (time_breakdown["Gaming"] ?? 0.0) > 0.01 ?
                          Icon(Symbols.sports_esports, color:color_onprimary)
                          : null,
                        ),
                        // Outing
                        PieChartSectionData(
                          color: color_primary,
                          value: time_breakdown["Outing"],
                          title: "",
                          badgeWidget: (time_breakdown["Outing"] ?? 0.0) > 0.01 ?
                          Icon(Symbols.tour, color:color_onprimary)
                          : null,
                        ),
                        // Commute
                        PieChartSectionData(
                          color: color_primary,
                          value: time_breakdown["Commute"],
                          title: "",
                          badgeWidget: (time_breakdown["Commute"] ?? 0.0) > 0.01 ?
                          Icon(Symbols.commute, color:color_onprimary)
                          : null,
                        ),
                        // Entertainment
                        PieChartSectionData(
                          color: color_primary,
                          value: time_breakdown["Entertainment"],
                          title: "",
                          badgeWidget: (time_breakdown["Entertainment"] ?? 0.0) > 0.01 ?
                          Icon(Symbols.comedy_mask, color:color_onprimary)
                          : null,
                        ),
                      ]
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
                      visible: time_breakdown.isEmpty,
                      child: Text("Data unavailable for current day")
                    ),
                    Visibility(
                      visible: time_breakdown.isNotEmpty,
                      child: Column(
                        children: [
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Symbols.bedtime, color: color_primary),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text("Sleep", style: TextStyle(color: color_primary))
                              ),
                              SizedBox(width: 8),
                              Text("${helper_get_duration(time_breakdown["Sleep"]?.toInt() ?? 0)}")
                            ]
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Symbols.book, color: color_primary),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text("Study", style: TextStyle(color: color_primary))
                              ),
                              SizedBox(width: 8),
                              Text("${helper_get_duration(time_breakdown["Study"]?.toInt() ?? 0)}")
                            ]
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Symbols.flatware, color: color_primary),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text("Eating", style: TextStyle(color: color_primary))
                              ),
                              SizedBox(width: 8),
                              Text("${helper_get_duration(time_breakdown["Eating"]?.toInt() ?? 0)}")
                            ]
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Symbols.construction, color: color_primary),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text("Hobby", style: TextStyle(color: color_primary))
                              ),
                              SizedBox(width: 8),
                              Text("${helper_get_duration(time_breakdown["Hobby"]?.toInt() ?? 0)}")
                            ]
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Symbols.sports_esports, color: color_primary),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text("Gaming", style: TextStyle(color: color_primary))
                              ),
                              SizedBox(width: 8),
                              Text("${helper_get_duration(time_breakdown["Gaming"]?.toInt() ?? 0)}")
                            ]
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Symbols.tour, color: color_primary),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text("Outing", style: TextStyle(color: color_primary))
                              ),
                              SizedBox(width: 8),
                              Text("${helper_get_duration(time_breakdown["Outing"]?.toInt() ?? 0)}")
                            ]
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Symbols.commute, color: color_primary),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text("Commute", style: TextStyle(color: color_primary))
                              ),
                              SizedBox(width: 8),
                              Text("${helper_get_duration(time_breakdown["Commute"]?.toInt() ?? 0)}")
                            ]
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Symbols.comedy_mask, color: color_primary),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text("Entertainment", style: TextStyle(color: color_primary))
                              ),
                              SizedBox(width: 8),
                              Text("${helper_get_duration(time_breakdown["Entertainment"]?.toInt() ?? 0)}")
                            ]
                          ),
                        ]
                      )
                    )
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
