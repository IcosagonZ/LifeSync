import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

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

    LineChartData linechartdata_widget(LineChartBarData chartdata){
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
        lineBarsData: [
          chartdata
        ],
        backgroundColor: color_onsecondary,
      );
    }

    Card linechart_card(LineChartBarData chartdata)
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
            Text("History", style: style_headlinesmall),
            SizedBox(height: 16),
            Text("Heartrate", textAlign: TextAlign.start, style: style_titlelarge),
            SizedBox(height: 16),
            linechart_card(
              LineChartBarData(
                spots: data_heartrates.map((data)
                {
                  return FlSpot(data[0], data[1]);
                }).toList(),
                isCurved: true,
                color: color_primary,
              )
            ),
            Text("Blood Sugar", textAlign: TextAlign.start, style: style_titlelarge),
            SizedBox(height: 16),
            linechart_card(
              LineChartBarData(
                spots: data_heartrates.map((data)
                {
                  return FlSpot(data[0], data[1]);
                }).toList(),
                isCurved: true,
                color: color_primary,
              )
            ),
            SizedBox(height: 16),
            Text("Blood Oxygen", textAlign: TextAlign.start, style: style_titlelarge),
            SizedBox(height: 16),
            linechart_card(
              LineChartBarData(
                spots: data_heartrates.map((data)
                {
                  return FlSpot(data[0], data[1]);
                }).toList(),
                isCurved: true,
                color: color_primary,
              )
            ),
            SizedBox(height: 16),
            Text("Body Temperature", textAlign: TextAlign.start, style: style_titlelarge),
            SizedBox(height: 16),
            linechart_card(
              LineChartBarData(
                spots: data_heartrates.map((data)
                {
                  return FlSpot(data[0], data[1]);
                }).toList(),
                isCurved: true,
                color: color_primary,
              )
            ),
          ]
        )
      ),
    );
  }
}
