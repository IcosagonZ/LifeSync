import 'package:flutter/material.dart';
//import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import '../../components/recents_listtile_single_text.dart';

class Page_Recommendations extends StatefulWidget
{
  const Page_Recommendations({super.key});

  @override
  State<Page_Recommendations> createState() => Page_Recommendations_State();
}

class Page_Recommendations_State extends State<Page_Recommendations>
{
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

    // Widget size variables

    return Scaffold(
      appBar: AppBar(
        title: Text("Recommendations"),
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
                                child: Text("Daily Goals", style: TextStyle(color: color_primary))
                              ),
                              Text("14/15")
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: Text("Weekly Goals", style: TextStyle(color: color_primary))
                              ),
                              Text("7/10")
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
                ),
              )
            ),
            SizedBox(height: 16),
            Text("Recommendations", style: style_titlelarge),
            SizedBox(height: 16),
            Card.outlined(
              child: Column(
                spacing: 2,
                children: [
                  RecentsListTileSingleText(
                    list_title: "Diet",
                    list_subtitle: "Reduce Sodium",
                  ),
                  Divider(height: 1),
                  RecentsListTileSingleText(
                    list_title: "Activity",
                    list_subtitle: "Walk more than 2 hrs",
                  ),
                  Divider(height: 1),
                  RecentsListTileSingleText(
                    list_title: "Diet",
                    list_subtitle: "Drink more water",
                  ),
                  Divider(height: 1),
                  RecentsListTileSingleText(
                    list_title: "Diet",
                    list_subtitle: "Eat more leafy vegetables",
                  ),
                ]
              ),
            ),
            SizedBox(height: 16),
            Text("Insights", style: style_titlelarge),
            SizedBox(height: 16),
            Card.outlined(
              child: Column(
                spacing: 2,
                children: [
                  RecentsListTileSingleText(
                    list_title: "Academics",
                    list_subtitle: "Better grades than last semester",
                  ),
                  Divider(height: 1),
                  RecentsListTileSingleText(
                    list_title: "Mood",
                    list_subtitle: "Lower stress than usual",
                  ),
                ]
              )
            )
          ]
        )
      ),
    );
  }
}
