import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../main.dart';

import '../../data/database.dart';
import '../../data/models/body_measurement.dart';

import '../../data/iconmapper.dart';
import '../../helpers/helper_calculate.dart';

import '../../components/listtile_single_icon.dart';
import '../../components/graph_linechart.dart';


class Page_BodyMeasurements extends StatefulWidget
{
  const Page_BodyMeasurements({super.key});

  @override
  State<Page_BodyMeasurements> createState() => Page_BodyMeasurements_State();
}

class Page_BodyMeasurements_State extends State<Page_BodyMeasurements> with RouteAware
{
  // Widget variables
  DateTime data_timenow = DateTime.now();

  DateTime date_start = DateTime.now().subtract(Duration(days: 7));
  DateTime date_end = DateTime.now();

  List<BodyMeasurementData> bodymeasurements_data = [];

  int data_latest_height = 0;
  int data_latest_weight = 0;

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

  Future<void> initData() async{
    List<BodyMeasurementData> bodymeasurements_data_result = await database_get_bodymeasurement_for_date(data_timenow);

    int data_latest_height_result = await database_latest_body_height();
    int data_latest_weight_result = await database_latest_body_weight();

    setState(()
    {
      bodymeasurements_data = bodymeasurements_data_result;
      data_latest_height = data_latest_height_result;
      data_latest_weight = data_latest_weight_result;
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
        title: Text("Body measurements"),
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
                                child: Text("Height", style: TextStyle(color: color_primary))
                              ),
                              Text("$data_latest_height cm")
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: Text("Weight", style: TextStyle(color: color_primary))
                              ),
                              Text("$data_latest_weight kg")
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
                          Text("${helper_get_bmi(data_latest_height, data_latest_weight).toStringAsFixed(1)}"),
                          Text("BMI", style: TextStyle(fontSize: 10)),
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
            Card.outlined(
              child: Padding(
                padding: EdgeInsets.all(2),
                child: Stack(
                  children: [
                    Visibility(
                      visible: bodymeasurements_data.isEmpty,
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(
                          child: Text("No data available")
                        ),
                      )
                    ),
                    Visibility(
                      visible: bodymeasurements_data.isNotEmpty,
                      child: Center(
                        child: Column(
                          spacing: 2,
                          children: List.generate(bodymeasurements_data.length, (index){
                            final data = bodymeasurements_data[index];
                            final tile = ListTileSingleIcon(
                              list_icon: Icon(iconmapper_geticon("Body Measurements", data.measurement_type)),
                              list_title: data.measurement_type,
                              list_subtitle: "${data.value.toInt()} ${data.unit}",
                              list_trail: DateFormat('h:mm a').format(data.entry_date),
                              id: data.id,
                              datatype: "note",
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

            // Weight display
            Text("Weight", textAlign: TextAlign.start, style: style_titlelarge),
            SizedBox(height: 16),
            GraphLineChart(
              table_name: "body_measurement",
              column_name: "value",
              where_column: "type",
              where_value: "Weight",
              date_start: date_start,
              date_end: date_end,
            ),
            SizedBox(height: 16),

            // Height display
            Text("Height", textAlign: TextAlign.start, style: style_titlelarge),
            SizedBox(height: 16),
            GraphLineChart(
              table_name: "body_measurement",
              column_name: "value",
              where_column: "type",
              where_value: "Height",
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
