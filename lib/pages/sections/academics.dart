import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:material_symbols_icons/material_symbols_icons.dart';

import '../../data/database.dart';

import '../../components/recents_listtile_single_text.dart';
import '../../components/recents_listtile_multiline.dart';

class Page_Academics extends StatefulWidget
{
  const Page_Academics({super.key});

  @override
  State<Page_Academics> createState() => Page_Academics_State();
}

class Page_Academics_State extends State<Page_Academics>
{
    // Widget variables
  List<AcademicsAbsentData> academics_absent_data = [];
  List<AcademicsAssignmentData> academics_assignment_data = [];
  List<AcademicsExamData> academics_exam_data = [];
  List<AcademicsMarkData> academics_mark_data = [];

  @override
  void initState()
  {
    initData();

    super.initState();
  }

  Future<void> initData() async{
    List<AcademicsAbsentData> academics_absent_data_result = await database_get_academics_absent();
    List<AcademicsAssignmentData> academics_assignment_data_result = await database_get_academics_assignment();
    List<AcademicsExamData> academics_exam_data_result = await database_get_academics_exam();
    List<AcademicsMarkData> academics_mark_data_result = await database_get_academics_mark();

    setState(()
    {
      academics_absent_data = academics_absent_data_result;
      academics_assignment_data = academics_assignment_data_result;
      academics_exam_data = academics_exam_data_result;
      academics_mark_data = academics_mark_data_result;
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
        title: Text("Academics"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children:[
            Text("Overview", style: style_titlelarge),
            SizedBox(height: 16),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text("Performance", style: TextStyle(color: color_primary))
                              ),
                              Text("Suboptimal")
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: Text("Assignments", style: TextStyle(color: color_primary)),
                              ),
                              Text("2/3"),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: Text("Absent", style: TextStyle(color: color_primary)),
                              ),
                              Text("3 days"),
                            ],
                          ),
                        ]
                      )
                    ),
                    SizedBox(width: 32),
                    CircleAvatar(
                      radius: 32,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("25"),
                          Text("Score", style: TextStyle(fontSize: 10)),
                        ]
                      ),
                    ),
                  ],
                )
              )
            ),
            SizedBox(height: 16),
            Text("Exams", style: style_titlelarge),
            SizedBox(height: 16),
            Card.outlined(
              child: Padding(
                padding: EdgeInsets.all(2),
                child: Stack(
                  children: [
                    Visibility(
                      visible: academics_exam_data.isEmpty,
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(
                          child: Text("No data available")
                        ),
                      )
                    ),
                    Visibility(
                      visible: academics_exam_data.isNotEmpty,
                      child: Center(
                        child: Column(
                          spacing: 2,
                          children: List.generate(academics_exam_data.length, (index){
                            final data = academics_exam_data[index];
                            final tile = RecentsListTileSingleText(
                              //list_icon: Icon(Symbols.cognition_2),
                              list_title: data.subject,
                              list_subtitle: "${data.exam_type} ${DateFormat('dd/M/yy').format(data.exam_date)}",
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
            ),
            SizedBox(height: 16),
            Text("Assignments", style: style_titlelarge),
            SizedBox(height: 16),
            Card.outlined(
              child: Padding(
                padding: EdgeInsets.all(2),
                child: Stack(
                  children: [
                    Visibility(
                      visible: academics_assignment_data.isEmpty,
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(
                          child: Text("No data available")
                        ),
                      )
                    ),
                    Visibility(
                      visible: academics_assignment_data.isNotEmpty,
                      child: Center(
                        child: Column(
                          spacing: 2,
                          children: List.generate(academics_assignment_data.length, (index){
                            final data = academics_assignment_data[index];
                            final tile = RecentsListTileSingleText(
                              list_title: data.subject,
                              list_subtitle: "${data.type}, ${data.topic} ${DateFormat('dd/M/yy').format(data.due_date)}",
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
            ),

            SizedBox(height: 16),
            Text("Marks", style: style_titlelarge),
            SizedBox(height: 16),
            Card.outlined(
              child: Padding(
                padding: EdgeInsets.all(2),
                child: Stack(
                  children: [
                    Visibility(
                      visible: academics_mark_data.isEmpty,
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(
                          child: Text("No data available")
                        ),
                      )
                    ),
                    Visibility(
                      visible: academics_mark_data.isNotEmpty,
                      child: Center(
                        child: Column(
                          spacing: 2,
                          children: List.generate(academics_mark_data.length, (index){
                            final data = academics_mark_data[index];
                            final tile = RecentsListTileSingleText(
                              list_title: data.subject,
                              list_subtitle: "${data.type} ${data.marks}/${data.marks_total}",
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
            ),

            SizedBox(height: 16),
            Text("Absent", style: style_titlelarge),
            SizedBox(height: 16),
            Card.outlined(
              child: Padding(
                padding: EdgeInsets.all(2),
                child: Stack(
                  children: [
                    Visibility(
                      visible: academics_absent_data.isEmpty,
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(
                          child: Text("No data available")
                        ),
                      )
                    ),
                    Visibility(
                      visible: academics_absent_data.isNotEmpty,
                      child: Center(
                        child: Column(
                          spacing: 2,
                          children: List.generate(academics_absent_data.length, (index){
                            final data = academics_absent_data[index];
                            final tile = RecentsListTileSingleText(
                              list_title: data.reason,
                              list_subtitle: "${data.entry_note} ${DateFormat('dd/M/yy').format(data.absent_date)}",
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
            ),
          ]
        )
      ),
    );
  }
}
