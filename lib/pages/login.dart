import 'package:flutter/material.dart';
//import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import '../data/backend.dart';

class Page_Login extends StatefulWidget
{
  const Page_Login({super.key});

  @override
  State<Page_Login> createState() => Page_Login_State();
}

class Page_Login_State extends State<Page_Login>
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
        title: Text(""),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("LifeSyncAI", style:style_headlinelarge),
              SizedBox(height: 32),
              TextField(
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: "Username",
                  hintText: "Enter username",
                ),
                maxLines: null,
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: "Password",
                  hintText: "Enter password",
                ),
                maxLines: null,
              ),
              SizedBox(height: 32),
              ElevatedButton(
                child: Text("Login"),
                onPressed: ()
                {
                  print("Login pressed");
                  backend_test();
                }
              ),
              SizedBox(height: 16),
              Text("or"),
              SizedBox(height: 16),
              TextButton(
                child: Text("Create an account"),
                onPressed: ()
                {
                  print("Create account pressed");
                }
              ),
            ],
          )
        )
      ),
    );
  }
}
