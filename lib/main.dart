import 'package:flutter/material.dart';

import 'pages/overview.dart';
import 'data/database.dart';
import 'pages/login.dart';

import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void printDatabasePath() async
{
  var path = await getDatabasesPath();
  print("Path is $path");
}

void main()
{
  // Database setup
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

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
    );
  }
}
