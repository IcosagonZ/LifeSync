import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:provider/provider.dart';

import '../data/database.dart';
import '../components/provider_theme.dart';

import '../components/dialog_confirmation.dart';
import '../components/snackbar_notify.dart';

class Page_Settings extends StatefulWidget
{
  const Page_Settings({super.key});

  @override
  State<Page_Settings> createState() => Page_Settings_State();
}

class Page_Settings_State extends State<Page_Settings>
{
  TextEditingController settings_backendurl_controller = TextEditingController();
  TextEditingController database_command_controller = TextEditingController();
  TextEditingController database_result_controller = TextEditingController();

  bool settings_theme_toggle = false;

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
      settings_theme_toggle = context.read<ThemeProvider>().isDark;
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
                      if(result>0)
                      {
                        ScaffoldMessenger.of(context).showSnackBar(notify_snackbar("Changed backend url"));
                      }
                      else
                      {
                        ScaffoldMessenger.of(context).showSnackBar(notify_snackbar("Error changing backend url"));
                      }
                    }
                  },
                )
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text("Toggle dark mode"),
                ),
                Checkbox(
                  tristate: false,
                  value: settings_theme_toggle,
                  onChanged: (newBool){
                    setState(() {
                      if(newBool!=null)
                      {
                        settings_theme_toggle = newBool;
                      }
                      context.read<ThemeProvider>().toggleTheme();
                    });
                  },
                )
              ],
            ),
            SizedBox(height: 16),
            Divider(),
            SizedBox(height: 16),
            Text("Database", style: style_titlelarge),
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
            SizedBox(height: 16),
            ExpansionTile(
              tilePadding: EdgeInsetsDirectional.zero,
              title: Text("Execute commands"),
              subtitle: Text("Execute DBMS commands"),
              children: [
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child:
                      TextField(
                        controller: database_command_controller,
                        decoration: InputDecoration(
                          labelText: "Command",
                          hintText: "Enter command",
                        ),
                        maxLines: null,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Symbols.send),
                      onPressed: () async
                      {
                        if(database_command_controller.text.isNotEmpty)
                        {
                          final result = await database_rawQuery(database_command_controller.text);
                          if(mounted)
                          {
                            ScaffoldMessenger.of(context).showSnackBar(notify_snackbar("Executed command"));
                            setState(() {
                              database_result_controller.text = result;
                            });
                          }
                        }
                      },
                    )
                  ],
                ),
                SizedBox(height: 16),
                TextField(
                  controller: database_result_controller,
                  decoration: InputDecoration(
                    labelText: "Result",
                    hintText: "None",
                  ),
                  maxLines: null,
                ),
              ],
            )
          ]
        )
      ),
    );
  }
}
