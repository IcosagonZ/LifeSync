import 'package:flutter/material.dart';

import '../data/database.dart';
import '../themes/theme_red.dart';

class ThemeProvider extends ChangeNotifier
{
  final ThemeData themeDark = ThemeRed.dark;
  final ThemeData themeLight = ThemeRed.light;

  ThemeMode themeModeCurrent = ThemeMode.dark;
  ThemeMode get themeMode => themeModeCurrent;
  bool isDark = true;

  // Constructor
  ThemeProvider()
  {
    loadSettings();
  }

  // Get if theme stored in database
  Future<void> loadSettings() async
  {
    String theme_mode = "n/a";
    List<SettingsData> settings_list = await database_get_settings();

    for(var data in settings_list)
    {
      if(data.name=="theme_mode")
      {
        theme_mode = data.value;
      }
    }

    if(theme_mode=="n/a")
    {
      // add entry to database
      database_insert_settings("theme_mode","dark");
    }
    else if(theme_mode=="light")
    {
      themeModeCurrent = ThemeMode.light;
      isDark = false;
      notifyListeners();
    }
    else if(theme_mode=="dark")
    {
      themeModeCurrent = ThemeMode.dark;
      isDark = true;
      notifyListeners();
    }
    //print(theme_mode);
  }

  void toggleTheme()
  {
    //print("Toggled theme");
    if(!isDark)
    {
      database_update_settings("theme_mode","dark");
      themeModeCurrent = ThemeMode.dark;
      isDark = true;
    }
    else
    {
      database_update_settings("theme_mode","light");
      themeModeCurrent = ThemeMode.light;
      isDark = false;
    }
    notifyListeners();
  }
}
