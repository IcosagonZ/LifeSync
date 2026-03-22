import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import '../data/database.dart';

import '../components/dialog_confirmation.dart';

class Page_Settings extends StatefulWidget
{
  const Page_Settings({super.key});

  @override
  State<Page_Settings> createState() => Page_Settings_State();
}

class Page_Settings_State extends State<Page_Settings>
{
  TextEditingController settings_backendurl_controller = TextEditingController();

  @override
  void initState()
  {
    super.initState();

    updateData();
  }

  void updateData() async
  {
    String backend_url = await database_get_settings_backendurl();

    setState(()
    {
      settings_backendurl_controller.text = backend_url;
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

    // Widget size variables

    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children:[
            Row(
              children: [
                Expanded(
                  child: Text("Backend URL"),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 100,
                  ),
                  child: IntrinsicWidth(
                    child: TextField(
                      controller: settings_backendurl_controller,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        isDense: true,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Symbols.save),
                  onPressed: () async
                  {
                    if(settings_backendurl_controller.text.isNotEmpty)
                    {
                      final result = await database_update_settings("backend_url", settings_backendurl_controller.text);
                    }
                  },
                )
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text("Delete database"),
                ),
                IconButton(
                  icon: Icon(Symbols.delete),
                  onPressed: () async {
                    final confirm = await dialog_confirmation_show(context, "Delete database", "Are you sure ?");
                    if(confirm==true)
                    {
                      database_delete();
                    }
                  },
                )
              ],
            ),
          ]
        )
      ),
    );
  }
}
