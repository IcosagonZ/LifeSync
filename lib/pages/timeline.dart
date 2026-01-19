import 'package:flutter/material.dart';
//import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import '../components/timeline_listtile.dart';

class Page_Timeline extends StatefulWidget
{
  const Page_Timeline({super.key});

  @override
  State<Page_Timeline> createState() => Page_Timeline_State();
}

class Page_Timeline_State extends State<Page_Timeline>
{
  @override
  Widget build(BuildContext context)
  {
    // Widget size variables

    return Scaffold(
      appBar: AppBar(
        title: Text("Timeline"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView(
          children:[
            TimelineListTile(
              list_icon: Icon(Symbols.ecg_heart),
              list_title: "Heartrate",
              list_subtitle: "93 bpm",
              list_date: "Unknown",
            ),
          ]
        )
      ),
    );
  }
}
