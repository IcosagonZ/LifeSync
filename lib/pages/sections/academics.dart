import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../main.dart';

// Database and models
import '../../data/database.dart';
import '../../data/models/academics_absent.dart';
import '../../data/models/academics_assignment.dart';
import '../../data/models/academics_exam.dart';
import '../../data/models/academics_mark.dart';

import '../add_data.dart';

import '../../components/recents_listtile_single_text.dart';
import '../../components/avatar_gradient.dart';

// Misc
//import '../../colors/colors_overview_buttons.dart';

class Page_Academics extends StatefulWidget
{
  const Page_Academics({super.key});

  @override
  State<Page_Academics> createState() => Page_Academics_State();
}

class Page_Academics_State extends State<Page_Academics> with RouteAware
{
  // Widget variables
  List<AcademicsAbsentData> academics_absent_data = [];
  List<AcademicsAssignmentData> academics_assignment_data = [];
  List<AcademicsExamData> academics_exam_data = [];
  List<AcademicsMarkData> academics_mark_data = [];

  String score = "N/A";
  String assignments_pending = "N/A";
  String absent_total = "N/A";

  // Route aware initializers
  @override
  void didChangeDependencies()
  {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

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


    final assignments_pending_result = await database_get_assignments_not_submitted_total();
    final absent_result = await database_get_absent_total();
    final score_result = await database_get_score("academics");

    setState(()
    {
      if(score_result!=-1)
      {
        score = score_result.toString();
      }
      else
      {
        score = "N/A";
      }

      if(assignments_pending_result!=-1)
      {
        assignments_pending = assignments_pending_result.toString();
      }
      else
      {
        assignments_pending = "0";
      }

      if(absent_result!=-1)
      {
        absent_total = absent_result.toString();
      }
      else
      {
        absent_total = "0";
      }

      academics_absent_data = academics_absent_data_result;
      academics_assignment_data = academics_assignment_data_result;
      academics_exam_data = academics_exam_data_result;
      academics_mark_data = academics_mark_data_result;
    });
  }

  // Route aware functions
  @override
  void didPopNext()
  {
    initData();
  }

  @override
  Widget build(BuildContext context)
  {
    // Theming and text styles
    final color_scheme = Theme.of(context).colorScheme;
    final text_theme = Theme.of(context).textTheme;

    final color_primary = color_scheme.primary;//Theme.of(context).extension<ColorsOverviewButtons>()?.academics;
    final color_secondary = color_scheme.secondary;
    final color_onprimary = color_scheme.onPrimary;
    final color_onsecondary = color_scheme.onSecondary;
    final color_background = color_scheme.onBackground;
    final color_surface = color_scheme.onSurface;

    final style_displaylarge = text_theme.displayLarge;
    final style_displaymedium = text_theme.displayMedium;
    final style_displaysmall = text_theme.displaySmall;

    final style_headlinelarge = text_theme.headlineLarge;
    final style_headlinemedium = text_theme.headlineMedium;
    final style_headlinesmall = text_theme.headlineSmall;

    final style_titlelarge = text_theme.titleLarge;
    final style_titlemedium = text_theme.titleMedium;
    final style_titlesmall = text_theme.titleSmall;

    final style_cardlabel = TextStyle(fontWeight: FontWeight.w600);

    return Scaffold(
      appBar: AppBar(
        title: Text("Academics"),
        actions: [
          IconButton(
            icon: Icon(Icons.playlist_add),
            tooltip: "Add data",
            onPressed: () async {
              //print("Add data pressed");
              final result = await Navigator.push(context, MaterialPageRoute(builder: (context)
              {
                return const Page_AddData();
              },
              settings: RouteSettings(
                arguments: "academics",
              ),
              ));
              if(result!=null) // when returning
              {
                initData();
              }
            },
          ),
        ],
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
                          /*
                          Row(
                            children: [
                              Expanded(
                                child: Text("Performance", style: style_cardlabel)
                              ),
                              Text("N/A")
                            ],
                          ),
                          */
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: Text("Assignments pending", style: style_cardlabel)
                              ),
                              Text(assignments_pending),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: Text("Absent", style: style_cardlabel)
                              ),
                              Text(absent_total),
                            ],
                          ),
                        ]
                      )
                    ),
                    SizedBox(width: 32),
                    AvatarGradient(
                      "${score}",
                      "Score",
                      [
                        color_primary,
                        color_secondary
                      ]
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
                              id: data.id,
                              datatype: "academics_exam",
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
                              id: data.id,
                              datatype: "academics_assignment",
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
                              id: data.id,
                              datatype: "academics_mark",
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
                              id: data.id,
                              datatype: "academics_absent",
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
