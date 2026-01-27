import 'package:flutter/material.dart';
//import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class Page_Academics extends StatefulWidget
{
  const Page_Academics({super.key});

  @override
  State<Page_Academics> createState() => Page_Academics_State();
}

class Page_Academics_State extends State<Page_Academics>
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
        title: Text("Academics"),
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
                                child: Text("Performance", style: TextStyle(color: color_primary))
                              ),
                              Text("Suboptimal")
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: Text("Assignments", style: TextStyle(color: color_primary)),
                              ),
                              Text("2/3"),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: Text("Absent", style: TextStyle(color: color_primary)),
                              ),
                              Text("3 days"),
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
                          Text("25"),
                          Text("Score", style: TextStyle(fontSize: 10)),
                        ]
                      ),
                    ),
                  ],
                )
              )
            ),
            SizedBox(height: 16),
            Text("Exams", style: style_titlelarge),
            SizedBox(height: 16),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Center(
                  child: Text("No data available")
                ),
              )
            ),
            SizedBox(height: 16),
            Text("Assignments", style: style_titlelarge),
            SizedBox(height: 16),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Center(
                  child: Text("No data available")
                ),
              )
            ),

            SizedBox(height: 16),
            Text("Marks", style: style_titlelarge),
            SizedBox(height: 16),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Center(
                  child: Text("No data available")
                ),
              )
            ),

            SizedBox(height: 16),
            Text("Absent", style: style_titlelarge),
            SizedBox(height: 16),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Center(
                  child: Text("No data available")
                ),
              )
            )
          ]
        )
      ),
    );
  }
}
