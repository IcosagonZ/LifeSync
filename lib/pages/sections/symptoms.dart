import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../main.dart';

import '../../data/database.dart';
import '../../data/models/symptom.dart';

import '../../data/iconmapper.dart';

import '../../components/recents_listtile_multiline.dart';
import '../../components/listtile_2_line_icon_check.dart';
import '../../components/avatar_gradient.dart';

class Page_Symptoms extends StatefulWidget
{
  const Page_Symptoms({super.key});

  @override
  State<Page_Symptoms> createState() => Page_Symptoms_State();
}

class Page_Symptoms_State extends State<Page_Symptoms> with RouteAware
{
  // Widget variables
  DateTime data_timenow = DateTime.now();

  List<SymptomData> symptom_data = [];
  List<SymptomData> symptom_unresolved_data = [];

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
    List<SymptomData> symptom_data_result = await database_get_symptom_for_date(data_timenow);
    List<SymptomData> symptom_unresolved_data_result = await database_get_symptom_unresolved();

    setState(()
    {
      symptom_data = symptom_data_result;
      symptom_unresolved_data = symptom_unresolved_data_result;
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

    final color_primary = color_scheme.primary;//Theme.of(context).extension<ColorsOverviewButtons>()?.symptoms;
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
    //List<TimelineData> recents_data = get_symptoms_data();

    return Scaffold(
      appBar: AppBar(
        title: Text("Symptoms"),
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
                                child: Text("Currently tracking", style: style_cardlabel)
                              ),
                              Text("N/A")
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: Text("Severity", style: style_cardlabel),
                              ),
                              Text("N/A"),
                            ],
                          ),
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
            Text("Tracking", style: style_titlelarge),
            SizedBox(height: 16),
            Card.outlined(
              child: Padding(
                padding: EdgeInsets.all(2),
                child: Stack(
                  children: [
                    Visibility(
                      visible: symptom_unresolved_data.isEmpty,
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(
                          child: Text("No data available")
                        ),
                      )
                    ),
                    Visibility(
                      visible: symptom_unresolved_data.isNotEmpty,
                      child: Center(
                        child: Column(
                          spacing: 2,
                          children: List.generate(symptom_unresolved_data.length, (index){
                            final data = symptom_unresolved_data[index];
                            final tile = ListTile2LineIconCheck(
                              list_icon: Icon(iconmapper_geticon("Symptom")),
                              list_title: data.name,
                              list_subtitle: "${data.intensity}",
                              list_trail: DateFormat('h:mm a').format(data.entry_date),
                              id: data.id,
                              datatype: "symptom",
                              onUpdate: (){
                                initData();
                              }
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
            Text("Today", style: style_titlelarge),
            SizedBox(height: 16),
            Card.outlined(
              child: Padding(
                padding: EdgeInsets.all(2),
                child: Stack(
                  children: [
                    Visibility(
                      visible: symptom_data.isEmpty,
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(
                          child: Text("No data available")
                        ),
                      )
                    ),
                    Visibility(
                      visible: symptom_data.isNotEmpty,
                      child: Center(
                        child: Column(
                          spacing: 2,
                          children: List.generate(symptom_data.length, (index){
                            final data = symptom_data[index];
                            final tile = RecentsListTileMultiline(
                              list_icon: Icon(iconmapper_geticon("Symptom")),
                              list_title: data.name,
                              list_subtitle: "${data.intensity}",
                              list_trail: DateFormat('h:mm a').format(data.entry_date),
                              id: data.id,
                              datatype: "symptom",
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
