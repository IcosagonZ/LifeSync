import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
            SvgPicture.asset(
              "assets/avatar.svg",
              fit: BoxFit.contain,
              height: MediaQuery.of(context).size.height * 0.45,
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
