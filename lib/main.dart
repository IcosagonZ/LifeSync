import 'package:flutter/material.dart';
import 'pages/overview.dart';

void main()
{
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
