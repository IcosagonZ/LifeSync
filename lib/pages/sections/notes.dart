import 'package:flutter/material.dart';
//import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import '../../data/database.dart';

import '../../components/recents_listtile_multiline.dart';

import '../add_note.dart';

class Page_Notes extends StatefulWidget
{
  const Page_Notes({super.key});

  @override
  State<Page_Notes> createState() => Page_Notes_State();
}

class Page_Notes_State extends State<Page_Notes>
{
  // Widget variables
  List<NoteData> note_data = [];

  @override
  void initState()
  {
    initData();

    super.initState();
  }

  Future<void> initData() async{
    List<NoteData> note_data_result = await database_get_note();

    setState(()
    {
      note_data = note_data_result;
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
        title: Text("Notes"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children:[
            //Text("Notes"),
            Card.outlined(
              child: Padding(
                padding: EdgeInsets.all(2),
                child: Stack(
                  children: [
                    Visibility(
                      visible: note_data.isEmpty,
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(
                          child: Text("No data available")
                        ),
                      )
                    ),
                    Visibility(
                      visible: note_data.isNotEmpty,
                      child: Center(
                        child: Column(
                          spacing: 2,
                          children: List.generate(note_data.length, (index){
                            final data = note_data[index];
                            final tile = RecentsListTileMultiline(
                              list_icon: Icon(Symbols.notes),
                              list_title: data.title,
                              list_subtitle: "${data.content.length} chars",
                              list_date: data.entry_date,
                            );

                            if(index>0)
                            {
                              return Column(
                                children: [
                                  Divider(height: 1),
                                  tile,
                                ]
                              );
                            }
                            else
                            {
                              return tile;
                            }
                          }),
                        )
                      )
                    ),
                  ]
                )
              )
            )
          ]
        )
      ),
      floatingActionButton: IconButton(
        icon: Icon(Icons.add),
        tooltip: "Add data",
        onPressed: () async {
          print("Add data pressed");
          final result = await Navigator.push(context, MaterialPageRoute(builder: (context)
          {
            return const Page_AddNote();
          }
          ));
          if(result!=null) // when returning
          {
            initData();
          }
        },
      ),
    );
  }
}
