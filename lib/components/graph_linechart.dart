import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

import '../data/database.dart';

Widget linechart_side_widgets(double value, TitleMeta meta)
{
  if(value==meta.max || value==meta.min)
  {
    return const SizedBox.shrink();
  }

  TextStyle style = TextStyle(
    fontSize: 12,
    //color: color_primary,
  );
  return SideTitleWidget(
    meta: meta,
    child: Text((value.toInt()).toString(), style: style),
  );
}

LineChartData linechartdata_widget(List<LineChartBarData> chartdata, List<dynamic> valuedata){
  return LineChartData(
    gridData: FlGridData(
      show: false,
      drawHorizontalLine: true,
      drawVerticalLine: true,
      horizontalInterval: 5,
      verticalInterval: 1,
      getDrawingHorizontalLine: (value) {
        return FlLine(
          //color: color_onprimary,
          strokeWidth: 1,
        );
      },
      getDrawingVerticalLine: (value) {
        return FlLine(
          //color: color_onprimary,
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
          getTitlesWidget: (double value, TitleMeta meta)
          {
            DateTime entry_date = valuedata[value.toInt()].entry_date;
            final String text = DateFormat('dd/MM').format(entry_date);

            return SideTitleWidget(
              meta: meta,
              child: Text(text, style: TextStyle(fontSize: 10)),
            );
          },
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 32,
          getTitlesWidget: linechart_side_widgets,
        ),
      )
    ),
    minX: 0,
    maxX: valuedata.length.toDouble()-1,
    lineBarsData: chartdata,
    //backgroundColor: color_onsecondary,
  );
}

class GraphLineChart extends StatefulWidget
{
  String table_name;
  String column_name;
  String where_column;
  String where_value;

  DateTime date_start;
  DateTime date_end;

  GraphLineChart({
    Key? key,
    required this.table_name,
    required this.column_name,
    required this.where_column,
    required this.where_value,
    required this.date_start,
    required this.date_end,
  }) : super (key: key);

  @override
  State<GraphLineChart> createState() => GraphLineChart_State();
}

class GraphLineChart_State extends State<GraphLineChart>
{
  // Dummy data
  List<GraphData> data_chart = [];

  // Widget variables
  DateTime data_timenow = DateTime.now();

  @override
  void initState()
  {
    initData();

    super.initState();
  }

  Future<void> initData() async
  {
    List<GraphData> data_chart_result = await database_graphdata_retrive(widget.table_name, widget.column_name, widget.where_column, widget.where_value, widget.date_start, widget.date_end);

    setState(()
    {
      data_chart = data_chart_result;
    });
  }

  List<FlSpot> chart_spot_retrive(List<GraphData> data_chart, int line_index)
  {
    return List.generate(data_chart.length, (index)
    {
      final data = data_chart[index];
      final value = data.value;

      // To process blood pressure 120/80
      if(value.contains("/"))
      {
        final parts = value.split("/").map((s) => s.trim()).toList();
        if(parts.length==2 && line_index<2)
        {
          try
          {
            return FlSpot(index.toDouble(), double.parse(parts[line_index]));
          }
          catch (e)
          {
            return FlSpot(index.toDouble(), 0.0);
          }
        }
      }
      return FlSpot(index.toDouble(), double.parse(data.value));
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



    List<LineChartBarData> linechartbardata_retrive(List<GraphData> data_chart)
    {
      List<LineChartBarData> linechartbardata_list = [];

      linechartbardata_list.add(LineChartBarData
      (
        spots: chart_spot_retrive(data_chart, 0),
        isCurved: true,
        color: color_primary,
      ));

      if(widget.where_value=="Blood Pressure")
      {
        linechartbardata_list.add(LineChartBarData
        (
          spots: chart_spot_retrive(data_chart, 1),
          isCurved: true,
          color: color_primary,
        ));
      }

      return linechartbardata_list;
    }

    return Card(
      child: Column(
        children: [
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: (){
                  print("Back");
                  setState((){
                    widget.date_start = widget.date_start.subtract(Duration(days: 7));
                    widget.date_end = widget.date_end.subtract(Duration(days: 7));
                  });
                  initState();
                },
                child: Text("<"),
              ),
              Text("${DateFormat('dd/MM').format(widget.date_end)} - ${DateFormat('dd/MM').format(widget.date_start)}", textAlign: TextAlign.center),
              TextButton(
                onPressed: (){
                  print("Forward");
                  setState((){
                    widget.date_start = widget.date_start.add(Duration(days: 7));
                    widget.date_end = widget.date_end.add(Duration(days: 7));
                  });

                  initState();
                },
                child: Text(">"),
              ),
            ]
          ),
          SizedBox(height: 8),
          Stack(
            children: [
              Visibility(
                visible: data_chart.length>=2,
                child: Padding
                (
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      AspectRatio(
                        aspectRatio: 2,
                        child: Padding(
                          padding: EdgeInsets.all(2),
                          child: LineChart(
                            linechartdata_widget(
                              linechartbardata_retrive(data_chart),
                              data_chart
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                )
              ),
              Visibility(
                visible: data_chart.length<2,
                child: AspectRatio(
                  aspectRatio: 2,
                  child: Padding
                  (
                    padding: EdgeInsets.all(32),
                    child: Center
                    (
                      child: Text("Not enough data available to plot graph")
                    ),
                  )
                )
              )
            ]
          )
        ]
      )
    );
  }
}
