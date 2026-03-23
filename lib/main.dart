import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import 'pages/overview.dart';
import 'data/database.dart';
import 'pages/login.dart';

import 'themes/theme_red.dart';
import 'components/provider_theme.dart';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';

final RouteObserver<ModalRoute<void>> routeObserver = RouteObserver<ModalRoute<void>>();

void printDatabasePath() async
{
  var path = await getDatabasesPath();
  print("Path is $path");
}

void main()
{
  // Database setup only for desktop
  if(Platform.isLinux || Platform.isWindows)
  {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  printDatabasePath();

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MainApp(),
    )
  );
}

class MainApp extends StatelessWidget
{
  const MainApp({super.key});

  @override
  Widget build(BuildContext context)
  {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: "LifeSync",
      theme: ThemeRed.light,
      darkTheme: ThemeRed.dark,//ThemeData.dark(),
      themeMode: themeProvider.themeMode,
      debugShowCheckedModeBanner: false,
      home: Page_Login(),
      navigatorObservers: [
        routeObserver
      ],
    );
  }
}
