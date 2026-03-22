import 'package:flutter/material.dart';
import 'dart:io';

import 'pages/overview.dart';
import 'data/database.dart';
import 'pages/login.dart';

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
  if(Platform.isWindows || Platform.isLinux)
  {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  printDatabasePath();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget
{
  const MainApp({super.key});

  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      title: "LifeSync",
      theme: ThemeData.dark(), // make it user changable
      debugShowCheckedModeBanner: false,
      home: Page_Overview(),
      navigatorObservers: [
        routeObserver
      ],
    );
  }
}
