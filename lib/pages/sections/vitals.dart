import 'package:flutter/material.dart';

import '../../data/backend.dart';
import '../../data/database.dart';
import '../../data/models/vitals.dart';

import '../../data/iconmapper.dart';

import '../../components/recents_listtile.dart';
import '../../components/graph_linechart.dart';

class Page_Vitals extends StatefulWidget
{
  const Page_Vitals({super.key});

  @override
  State<Page_Vitals> createState() => Page_Vitals_State();
}

class Page_Vitals_State extends State<Page_Vitals>
{
  DateTime date_start = DateTime.now().subtract(Duration(days: 7));
  DateTime date_end = DateTime.now();

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
    //List<VitalsData> vitals_data_all_result = await database_get_vitals();

    //backend_test();
   // backend_send(vitals_data_all_result);

    //List<GraphData> data_heartrates_result = await database_graphdata_retrive("vitals", "value", "type", "Heartrate", data_heartrate_date_start, data_heartrate_date_end);

    setState(()
    {
      vitals_data = vitals_data_result;

      //data_heartrates = data_heartrates_result;
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


            SizedBox(height: 16),

            Text("History", style: style_headlinesmall),
            SizedBox(height: 16),

            // Heartrate display
            Text("Heartrate", textAlign: TextAlign.start, style: style_titlelarge),
            SizedBox(height: 16),
            GraphLineChart(
              table_name: "vitals",
              column_name: "value",
              where_column: "type",
              where_value: "Heartrate",
              date_start: date_start,
              date_end: date_end,
            ),
            SizedBox(height: 16),

            // Blood pressure display
            Text("Blood Pressure", textAlign: TextAlign.start, style: style_titlelarge),
            SizedBox(height: 16),
            GraphLineChart(
              table_name: "vitals",
              column_name: "value",
              where_column: "type",
              where_value: "Blood Pressure",
              date_start: date_start,
              date_end: date_end,
            ),
            SizedBox(height: 16),

            // Body Temperature display
            Text("Body Temperature", textAlign: TextAlign.start, style: style_titlelarge),
            SizedBox(height: 16),
            GraphLineChart(
              table_name: "vitals",
              column_name: "value",
              where_column: "type",
              where_value: "Body Temperature",
              date_start: date_start,
              date_end: date_end,
            ),
            SizedBox(height: 16),

            // Blood Oxygen display
            Text("Blood Oxygen", textAlign: TextAlign.start, style: style_titlelarge),
            SizedBox(height: 16),
            GraphLineChart(
              table_name: "vitals",
              column_name: "value",
              where_column: "type",
              where_value: "Blood Oxygen",
              date_start: date_start,
              date_end: date_end,
            ),
            SizedBox(height: 16),

            // Blood Sugar display
            Text("Blood Sugar", textAlign: TextAlign.start, style: style_titlelarge),
            SizedBox(height: 16),
            GraphLineChart(
              table_name: "vitals",
              column_name: "value",
              where_column: "type",
              where_value: "Blood Sugar",
              date_start: date_start,
              date_end: date_end,
            ),
            SizedBox(height: 16),
          ]
        )
      ),
    );
  }
}
