import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class Page_Overview extends StatefulWidget
{
  const Page_Overview({super.key});

  @override
  State<Page_Overview> createState() => Page_Overview_State();
}

class Page_Overview_State extends State<Page_Overview>
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
    const double spacing_quickaction = 8;
    const double iconsize_quickaction = 24;

    return Scaffold(
      appBar: AppBar(
        title: Text("Overview"),
        actions: [
          IconButton(
            icon: Icon(Icons.timeline),
            tooltip: "Timeline",
            onPressed: (){
              print("Timeline pressed");
            },
          ),
          IconButton(
            icon: Icon(Icons.settings),
            tooltip: "Settings",
            onPressed: (){
              print("Settings pressed");
            },
          ),
        ]
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children:[
            Row(
              children:
              [
                // Left quick action buttons
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                  [
                    IconButton(
                      icon: Padding(
                        padding: EdgeInsets.all(2),
                        child: Icon(Symbols.schedule, size: iconsize_quickaction),
                      ),
                      tooltip: "Time",
                      onPressed: (){
                        print("Time pressed");
                      },
                    ),
                    SizedBox(height: spacing_quickaction),
                    IconButton(
                      icon: Padding(
                        padding: EdgeInsets.all(2),
                        child: Icon(Symbols.grading, size: iconsize_quickaction),
                      ),
                      tooltip: "Academics",
                      onPressed: (){
                        print("Academics pressed");
                      },
                    ),
                    SizedBox(height: spacing_quickaction),
                    IconButton(
                      icon: Padding(
                        padding: EdgeInsets.all(2),
                        child: Icon(Symbols.directions_run, size: iconsize_quickaction),
                      ),
                      tooltip: "Activity",
                      onPressed: (){
                        print("Activity pressed");
                      },
                    ),
                    SizedBox(height: spacing_quickaction),
                    IconButton(
                      icon: Padding(
                        padding: EdgeInsets.all(2),
                        child: Icon(Symbols.cognition_2, size: iconsize_quickaction),
                      ),
                      tooltip: "Mind",
                      onPressed: (){
                        print("Mind pressed");
                      },
                    ),
                    SizedBox(height: spacing_quickaction),
                    IconButton(
                      icon: Padding(
                        padding: EdgeInsets.all(2),
                        child: Icon(Symbols.ecg_heart, size: iconsize_quickaction),
                      ),
                      tooltip: "Vitals",
                      onPressed: (){
                        print("Vitals pressed");
                      },
                    ),
                  ]
                ),
                // Avatar
                Expanded(
                  child: SvgPicture.asset(
                    "assets/avatar.svg",
                    fit: BoxFit.contain,
                    height: MediaQuery.of(context).size.height * 0.45,
                  ),
                ),
                // Right quick action buttons
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                  [
                    IconButton(
                      icon: Padding(
                        padding: EdgeInsets.all(2),
                        child: Icon(Symbols.bedtime, size: iconsize_quickaction),
                      ),
                      tooltip: "Sleep",
                      onPressed: (){
                        print("Sleep pressed");
                      },
                    ),
                    SizedBox(height: spacing_quickaction),
                    IconButton(
                      icon: Padding(
                        padding: EdgeInsets.all(2),
                        child: Icon(Symbols.exercise, size: iconsize_quickaction),
                      ),
                      tooltip: "Workout",
                      onPressed: (){
                        print("Workout pressed");
                      },
                    ),
                    SizedBox(height: spacing_quickaction),
                    IconButton(
                      icon: Padding(
                        padding: EdgeInsets.all(2),
                        child: Icon(Symbols.fastfood, size: iconsize_quickaction),
                      ),
                      tooltip: "Nutrition",
                      onPressed: (){
                        print("Nutrition pressed");
                      },
                    ),
                    SizedBox(height: spacing_quickaction),
                    IconButton(
                      icon: Padding(
                        padding: EdgeInsets.all(2),
                        child: Icon(Symbols.sick, size: iconsize_quickaction),
                      ),
                      tooltip: "Symptoms",
                      onPressed: (){
                        print("Symptoms pressed");
                      },
                    ),
                    SizedBox(height: spacing_quickaction),
                    IconButton(
                      icon: Padding(
                        padding: EdgeInsets.all(2),
                        child: Icon(Symbols.weight, size: iconsize_quickaction),
                      ),
                      tooltip: "Body",
                      onPressed: (){
                        print("Body pressed");
                      },
                    ),
                  ]
                ),
              ]
            ),
            SizedBox(
              height: 32
            ),
            // Summary
            Center(
              child: Text("Summary", style:style_headlinemedium),
            ),
            SizedBox(
              height: 8
            ),
            Center(
              child: Text("All good", style:style_titlelarge),
            ),
            SizedBox(
              height: 16
            ),

            // Time
            // Time label
            Row(
              children: [
                Expanded(
                  child: Divider(),
                ),
                SizedBox(
                  width: 16,
                ),
                Text("Time", style:style_titlesmall),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Divider(),
                )
              ]
            ),
            SizedBox(
              height: 8
            ),

            // Time details
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text("8 hrs", style:style_headlinesmall),
                      SizedBox(height: 8),
                      Text("Slept", style:style_titlesmall),
                    ]
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text("2 hrs", style:style_headlinesmall),
                      SizedBox(height: 8),
                      Text("Studied", style:style_titlesmall),
                    ]
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text("3 hrs", style:style_headlinesmall),
                      SizedBox(height: 8),
                      Text("Free", style:style_titlesmall),
                    ]
                  ),
                ),
              ]
            ),
            SizedBox(
              height: 16
            ),

            // Activity
            // Activity label
            Row(
              children: [
                Expanded(
                  child: Divider(),
                ),
                SizedBox(
                  width: 16,
                ),
                Text("Activity", style:style_titlesmall),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Divider(),
                )
              ]
            ),
            SizedBox(
              height: 8
            ),

            // Activity details
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text("3124", style:style_headlinesmall),
                      SizedBox(height: 8),
                      Text("Steps", style:style_titlesmall),
                    ]
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text("3.25 km", style:style_headlinesmall),
                      SizedBox(height: 8),
                      Text("Moved", style:style_titlesmall),
                    ]
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text("54 mins", style:style_headlinesmall),
                      SizedBox(height: 8),
                      Text("Active", style:style_titlesmall),
                    ]
                  ),
                ),
              ]
            ),
            SizedBox(
              height: 16
            ),

            // Calorie
            // Calorie label
            Row(
              children: [
                Expanded(
                  child: Divider(),
                ),
                SizedBox(
                  width: 16,
                ),
                Text("Calories", style:style_titlesmall),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Divider(),
                )
              ]
            ),
            SizedBox(
              height: 8
            ),

            // Calorie details
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text("2103 cal", style:style_headlinesmall),
                      SizedBox(height: 8),
                      Text("Consumed", style:style_titlesmall),
                    ]
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text("2512 cal", style:style_headlinesmall),
                      SizedBox(height: 8),
                      Text("Burned", style:style_titlesmall),
                    ]
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text("409 cal", style:style_headlinesmall),
                      SizedBox(height: 8),
                      Text("Deficit", style:style_titlesmall),
                    ]
                  ),
                ),
              ]
            ),
            SizedBox(
              height: 16
            ),

            // Body
            // Body label
            Row(
              children: [
                Expanded(
                  child: Divider(),
                ),
                SizedBox(
                  width: 16,
                ),
                Text("Body", style:style_titlesmall),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Divider(),
                )
              ]
            ),
            SizedBox(
              height: 8
            ),

            // Body details
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text("170 cm", style:style_headlinesmall),
                      SizedBox(height: 8),
                      Text("Height", style:style_titlesmall),
                    ]
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text("20", style:style_headlinesmall),
                      SizedBox(height: 8),
                      Text("BMI", style:style_titlesmall),
                    ]
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text("62 kg", style:style_headlinesmall),
                      SizedBox(height: 8),
                      Text("Weight", style:style_titlesmall),
                    ]
                  ),
                ),
              ]
            ),
            SizedBox(
              height: 16
            ),
          ]
        )
      ),
    );
  }
}
