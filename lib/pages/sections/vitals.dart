import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import '../../data/database.dart';
import '../../data/iconmapper.dart';

import '../../components/recents_listtile.dart';

class Page_Vitals extends StatefulWidget
{
  const Page_Vitals({super.key});

  @override
  State<Page_Vitals> createState() => Page_Vitals_State();
}

class Page_Vitals_State extends State<Page_Vitals>
{
  // Dummy data
  List<List<double>> data_heartrates = [[0, 90],[1, 93],[2, 91],[3, 84],[4, 97],[5, 85],[6, 87]];
  List<List<double>> data_bodytemperatures = [[0, 93],[1, 92],[2, 91],[3, 93],[4, 91],[5, 93],[6, 97]];
  List<List<double>> data_bloodpressure_systolic = [[0, 125],[1, 121],[2, 111],[3, 131],[4, 123],[5, 125],[6, 115]];
  List<List<double>> data_bloodpressure_diastolic = [[0, 75],[1, 77],[2, 74],[3, 84],[4, 73],[5, 73],[6, 78]];
  List<List<double>> data_bloodoxygen = [[0, 97],[1, 98],[2, 99],[3, 97],[4, 99],[5, 96],[6, 98]];
  List<List<double>> data_bloodsugar = [[0, 125],[1, 132],[2, 123],[3, 132],[4, 132],[5, 121],[6, 122]];


  // Widget variables
  DateTime data_timenow = DateTime.now();

  List<VitalsData> vitals_data = [];

  @override
  void initState()
  {
    initData();

    super.initState();
  }

  Future<void> initData() async{
    List<VitalsData> vitals_data_result = await database_get_vitals_for_date(data_timenow);

    setState(()
    {
      vitals_data = vitals_data_result;
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



    Widget linechart_bottom_widgets(double value, TitleMeta meta) {
      TextStyle style = TextStyle(
        fontSize: 12,
        color: color_primary,
      );
      String text = switch (value.toInt())
      {
        0 => 'MON',
        1 => 'TUE',
        2 => 'WED',
        3 => 'THU',
        4 => 'FRI',
        5 => 'SAT',
        6 => 'SUN',
        _ => '',
      };
      return SideTitleWidget(
        meta: meta,
        child: Transform.rotate(
          angle: -0.7854, // 45 degree
          child: Text(text, style: style),
        ),
      );
    }

    Widget linechart_side_widgets(double value, TitleMeta meta) {
      TextStyle style = TextStyle(
        fontSize: 12,
        color: color_primary,
      );
      return SideTitleWidget(
        meta: meta,
        child: Text((value.toInt()).toString(), style: style),
      );
    }

    LineChartData linechartdata_widget(List<LineChartBarData> chartdata){
      return LineChartData(
        gridData: FlGridData(
          show: false,
          drawHorizontalLine: true,
          drawVerticalLine: true,
          horizontalInterval: 5,
          verticalInterval: 1,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: color_onprimary,
              strokeWidth: 1,
            );
          },
          getDrawingVerticalLine: (value) {
            return FlLine(
              color: color_onprimary,
              strokeWidth: 1,
            );
          },
        ),
        borderData: FlBorderData(
          show: false,
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
              reservedSize: 32,
            ),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(
              showTitles: false,
              reservedSize: 22,
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 22,
              interval: 1,
              getTitlesWidget: linechart_bottom_widgets,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 32,
              interval: 2,
              getTitlesWidget: linechart_side_widgets,
            ),
          )
        ),
        minX: 0,
        maxX: 6,
        lineBarsData: chartdata,
        backgroundColor: color_onsecondary,
      );
    }

    Card linechart_card(List<LineChartBarData> chartdata)
    {
      return
      Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 2,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: LineChart(
                    linechartdata_widget(
                      chartdata
                    ),
                  ),
                ),
              ),
            ],
          )
        )
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Vitals"),
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
                                child: Text("Status", style: TextStyle(color: color_primary))
                              ),
                              Text("N/A")
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: Text("Stress", style: TextStyle(color: color_primary))
                              ),
                              Text("N/A")
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
                          Text("85"),
                          Text("Score", style: TextStyle(fontSize: 10)),
                        ]
                      ),
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
                      visible: vitals_data.isEmpty,
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(
                          child: Text("No data available")
                        ),
                      )
                    ),
                    Visibility(
                      visible: vitals_data.isNotEmpty,
                      child: Center(
                        child: Column(
                          spacing: 2,
                          children: List.generate(vitals_data.length, (index){
                            final data = vitals_data[index];
                            final tile = RecentsListTile(
                              list_icon: Icon(iconmapper_geticon("Vitals", data.type)),
                              list_title: data.type,
                              list_subtitle: "${data.value} ${data.unit}",
                              list_date: data.entry_date,
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
            ),

            /*
            SizedBox(height: 16),

            Text("History", style: style_headlinesmall),
            SizedBox(height: 16),
            Text("Heartrate", textAlign: TextAlign.start, style: style_titlelarge),
            SizedBox(height: 16),
            linechart_card(
              [
                LineChartBarData(
                  spots: data_heartrates.map((data)
                  {
                    return FlSpot(data[0], data[1]);
                  }).toList(),
                  isCurved: true,
                  color: color_primary,
                )
              ]
            ),
            Text("Blood Sugar", textAlign: TextAlign.start, style: style_titlelarge),
            SizedBox(height: 16),
            linechart_card(
              [
                LineChartBarData(
                  spots: data_bloodsugar.map((data)
                  {
                    return FlSpot(data[0], data[1]);
                  }).toList(),
                  isCurved: true,
                  color: color_primary,
                )
              ]
            ),
            SizedBox(height: 16),
            Text("Blood Oxygen", textAlign: TextAlign.start, style: style_titlelarge),
            SizedBox(height: 16),
            linechart_card(
              [
                LineChartBarData(
                  spots: data_bloodpressure_systolic.map((data)
                  {
                    return FlSpot(data[0], data[1]);
                  }).toList(),
                  isCurved: true,
                  color: color_primary,
                ),
                LineChartBarData(
                  spots: data_bloodpressure_diastolic.map((data)
                  {
                    return FlSpot(data[0], data[1]);
                  }).toList(),
                  isCurved: true,
                  color: color_primary,
                ),
              ]
            ),
            SizedBox(height: 16),
            Text("Body Temperature", textAlign: TextAlign.start, style: style_titlelarge),
            SizedBox(height: 16),
            linechart_card(
              [
                LineChartBarData(
                  spots: data_bodytemperatures.map((data)
                  {
                    return FlSpot(data[0], data[1]);
                  }).toList(),
                  isCurved: true,
                  color: color_primary,
                )
              ]
            ),
            */

          ]
        )
      ),
    );
  }
}
