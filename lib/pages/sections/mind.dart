import 'package:flutter/material.dart';
//import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import '../../data/database.dart';

import '../../components/recents_listtile_multiline.dart';
import '../../components/recents_listtile_symptoms.dart';


class Page_Mind extends StatefulWidget
{
  const Page_Mind({super.key});

  @override
  State<Page_Mind> createState() => Page_Mind_State();
}

class Page_Mind_State extends State<Page_Mind>
{
  // Widget variables
  List<MindMoodData> mind_mood_data = [];

  @override
  void initState()
  {
    initData();

    super.initState();
  }

  Future<void> initData() async{
    List<MindMoodData> mind_mood_data_result = await database_get_mind_mood();

    setState(()
    {
      mind_mood_data = mind_mood_data_result;
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
    List<TimelineData> recents_data = get_mind_data();

    return Scaffold(
      appBar: AppBar(
        title: Text("Mind"),
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
                              Text("Slightly stressed")
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: Text("Severity", style: TextStyle(color: color_primary)),
                              ),
                              Text("Moderate"),
                            ],
                          ),
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
                          Text("72"),
                          Text("Score", style: TextStyle(fontSize: 10)),
                        ]
                      ),
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
                      visible: mind_mood_data.isEmpty,
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(
                          child: Text("No data available")
                        ),
                      )
                    ),
                    Visibility(
                      visible: mind_mood_data.isNotEmpty,
                      child: Center(
                        child: Column(
                          spacing: 2,
                          children: List.generate(mind_mood_data.length, (index){
                            final data = mind_mood_data[index];
                            int count = 0;

                            if(data.resolved==false)
                            {
                              print(data.resolved);
                              final tile = RecentsListTileSymptoms(
                                list_icon: Icon(Symbols.cognition_2),
                                list_title: data.name,
                                list_subtitle: data.intensity,
                                list_date: data.entry_date,
                              );

                              if(count>0)
                              {
                                count++;
                                return Column(
                                  children: [
                                    Divider(height: 1),
                                    tile,
                                  ]
                                );
                              }
                              else
                              {
                                count++;
                                return tile;
                              }
                            }
                            else
                            {
                              return SizedBox(height: 0,);
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
            Text("Recents", style: style_titlelarge),
            SizedBox(height: 16),
            Card.outlined(
              child: Padding(
                padding: EdgeInsets.all(2),
                child: Stack(
                  children: [
                    Visibility(
                      visible: mind_mood_data.isEmpty,
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(
                          child: Text("No data available")
                        ),
                      )
                    ),
                    Visibility(
                      visible: mind_mood_data.isNotEmpty,
                      child: Center(
                        child: Column(
                          spacing: 2,
                          children: List.generate(mind_mood_data.length, (index){
                            final data = mind_mood_data[index];
                            final tile = RecentsListTileMultiline(
                              list_icon: Icon(Symbols.cognition_2),
                              list_title: data.name,
                              list_subtitle: data.intensity,
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
            )
          ]
        )
      ),
    );
  }
}
