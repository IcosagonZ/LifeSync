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
        child: Column(
          children: [
            SvgPicture.asset(
              "assets/avatar.svg",
              fit: BoxFit.contain,
              height: MediaQuery.of(context).size.height * 0.5,
            ),
            Expanded(
              child: ListView(
                children:[
                  SizedBox(
                    height: 32
                  ),
                  Center(
                    child: Text("Summary", style:style_headlinemedium),
                  ),
                  SizedBox(
                    height: 8
                  ),
                  Center(
                    child: Text("All good", style:style_titlelarge),
                  )
                ]
              )
            )
          ]
        ),
      )
    );
  }
}
