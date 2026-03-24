import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import '../data/database.dart';
import '../data/backend.dart';

import '../data/models/academics_absent.dart';
import '../data/models/academics_assignment.dart';
import '../data/models/academics_exam.dart';
import '../data/models/academics_mark.dart';

import '../data/models/activity.dart';
import '../data/models/body_measurement.dart';
import '../data/models/mind_mood.dart';
import '../data/models/nutrition.dart';
import '../data/models/symptom.dart';
import '../data/models/time.dart';
import '../data/models/vitals.dart';
import '../data/models/workout.dart';

import '../../components/recents_listtile_single_text.dart';
import '../../components/listtile_3_line_expandable.dart';
import '../../components/avatar_gradient.dart';

import '../components/snackbar_notify.dart';
import '../components/dialog_information.dart';

class Page_Recommendations extends StatefulWidget
{
  const Page_Recommendations({super.key});

  @override
  State<Page_Recommendations> createState() => Page_Recommendations_State();
}

class Page_Recommendations_State extends State<Page_Recommendations>
{
  DateTime data_date = DateTime.now();

  String recommendation_text = "No recommendations available";

  List<RecommendationsData> recommendations_list = [];
  int recommendation_index = 0;
  int recommendation_max = 0;
  int recommendation_id = 0; // id in database
  DateTime recommendation_date = DateTime.now();

  List<InsightData> insight_list = [];

  String backend_response = "N/A"; // to store error messages

  var section_scores = {
    "academics_absent":-1,
    "academics_assignment":-1,
    //"academics_exam":-1,
    "academics_mark":-1,
    "activity":-1,
    "bodymeasurement":-1,
    "mind_mood":-1,
    "nutrition":-1,
    "symptom":-1,
    "time":-1,
    "vitals":-1,
    "workout":-1,
  };

  @override
  void initState()
  {
    super.initState();

    loadData();
  }

  void loadData() async
  {
    final recommendations_list_result = await database_get_recommendations();
    final insights_list_result = await database_get_insights();

    setState(()
    {
      // Recommendations list
      recommendations_list = recommendations_list_result;
      recommendation_max = recommendations_list.length;
      recommendation_index = recommendation_max;

      if(recommendations_list.isNotEmpty)
      {
        final data = recommendations_list.last;

        recommendation_text = data.content;
        recommendation_date = data.datetime;
      }

      // Insights list
      for(var data in insights_list_result)
      {
        insight_list.add(
          InsightData(
            data.title,
            data.subtitle,
            data.description,
            data.score
          )
        );
      }
    });
  }

  Future<int> updateData() async
  {
    List<AcademicsAbsentData> academics_absent_data = await database_get_academics_absent();
    List<AcademicsAssignmentData> academics_assignment_data = await database_get_academics_assignment();
    List<AcademicsMarkData> academics_mark_data = await database_get_academics_mark();
    List<BodyMeasurementData> bodymeasurement_data = await database_get_bodymeasurement_for_date(data_date);
    List<MindMoodData> mind_mood_data = await database_get_mind_mood_for_date(data_date);
    List<ActivityData> activity_data = await database_get_activity_for_date(data_date);
    List<NutritionData> nutrition_data = await database_get_nutrition_for_date(data_date);
    List<SymptomData> symptom_data = await database_get_symptom();
    List<TimeData> time_data = await database_get_time_for_date(data_date);
    List<VitalsData> vitals_data = await database_get_vitals_for_date(data_date);
    List<WorkoutData> workout_data = await database_get_workout_for_date(data_date);

    Map<String,dynamic> section_data = {
      "version":"0.1.1",
      "academics_absent_data":academics_absent_data,
      "academics_assignment_data":academics_assignment_data,
      "academics_mark_data":academics_mark_data,
      "bodymeasurement_data":bodymeasurement_data,
      "mind_mood_data":mind_mood_data,
      "activity_data":activity_data,
      "nutrition_data":nutrition_data,
      "symptom_data":symptom_data,
      "time_data":time_data,
      "vitals_data":vitals_data,
      "workout_data":workout_data,
    };

    BackendInsightData backend_data = await backend_send_map(section_data, "insights/all");

    if(backend_data.status==200)
    {
      setState(()
      {
        insight_list.clear();
        insight_list.addAll(backend_data.insights);
      });

      List<String> insight_headings = [];

      database_delete_insights();
      for(var data in insight_list)
      {
        insight_headings.add(data.subtitle);
        database_insert_insights(
          data.title,
          data.subtitle,
          data.description,
          data.score
        );
      }

      if(insight_headings.isNotEmpty)
      {
        setState(()
        {
          recommendation_text = "Loading...";
        });

        // Get recommendation from LLM
        LLMResponse llmresponse = await backend_send_llm("Give me health recommendations: ${insight_headings}");
        if(llmresponse.status=="OK")
        {
          final index = await database_insert_recommendation(llmresponse.message);
          setState(()
          {
            recommendation_text = llmresponse.message;
            recommendations_list.add(RecommendationsData(index, llmresponse.message, DateTime.now()));
            loadData();
          });
        }
        else
        {
          setState(()
          {
            recommendation_text = "Error getting recommendations";
          });
        }
      }
    }
    else if(backend_data.status!=200)
    {
      setState(()
      {
        backend_response = backend_data.body;
      });
    }
    return backend_data.status;
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
        title: Text("Recommendations"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            tooltip: "Refresh",
            onPressed: () async
            {
              print("Refresh pressed");
              final response = await updateData();
              if(response==200)
              {
                ScaffoldMessenger.of(context).showSnackBar(notify_snackbar("Retrieval success"));
              }
              else
              {
                dialog_information_show(context, "Error: ${response}", backend_response);
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
                          Row(
                            children: [
                              Expanded(
                                child: Text("Daily Goals", style: TextStyle(color: color_primary))
                              ),
                              Text("N/A")
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: Text("Weekly Goals", style: TextStyle(color: color_primary))
                              ),
                              Text("N/A")
                            ],
                          )
                        ]
                      )
                    ),
                    SizedBox(width: 32),
                    AvatarGradient(
                      "N/A",
                      "Score",
                      [
                        color_primary,
                        color_secondary
                      ]
                    ),
                  ],
                ),
              )
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text("Recommendations", style: style_titlelarge)
                ),
                if(recommendations_list.isNotEmpty)
                  TextButton(
                    onPressed: (){
                      // Previous recommendation
                      if(mounted && recommendation_index>0)
                      {
                        setState(()
                        {
                          recommendation_index -= 1;
                          final data = recommendations_list[recommendation_index];
                          recommendation_text = data.content;
                          recommendation_date = data.datetime;
                          recommendation_id = data.id;
                        });
                      }
                    },
                    child: Text("<"),
                  ),
                if(recommendations_list.isNotEmpty)
                  Text("${DateFormat('dd/MM').format(recommendation_date)}"),
                if(recommendations_list.isNotEmpty)
                  TextButton(
                    onPressed: (){
                      // New recommmendation
                      if(mounted && recommendation_index<recommendations_list.length-1)
                      {
                        setState(()
                        {
                          recommendation_index += 1;
                          final data = recommendations_list[recommendation_index];
                          recommendation_text = data.content;
                          recommendation_date = data.datetime;
                          recommendation_id = data.id;
                        });
                      }
                    },
                    child: Text(">"),
                  ),
                if(recommendations_list.isNotEmpty)
                  IconButton(
                    onPressed: () async
                    {
                      //print(recommendation_index);
                      final result = await database_delete_recommendation_from_id(recommendation_id);
                      if(result>0)
                      {
                        ScaffoldMessenger.of(context).showSnackBar(notify_snackbar("Deleted recommendation"));
                        loadData();
                      }
                      else
                      {
                        ScaffoldMessenger.of(context).showSnackBar(notify_snackbar("Deletion failed"));
                      }
                    },
                    icon: Icon(Symbols.delete)
                  )
              ],
            ),
            SizedBox(height: 16),
            Card.outlined(
              child: Stack(
                children: [
                  Visibility(
                    visible: recommendations_list.isEmpty,
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(32),
                        child: Center(
                          child: Text("No recommendations available")
                        ),
                      )
                    )
                  ),
                  Visibility(
                    visible: recommendations_list.isNotEmpty,
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(recommendation_text),
                      )
                    )
                  ),
                ]
              )
            ),
            SizedBox(height: 16),
            Text("Insights", style: style_titlelarge),
            SizedBox(height: 16),
            Card.outlined(
              child: Stack(
                children: [
                  Visibility(
                    visible: insight_list.isEmpty,
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(
                        child: Text("No data available")
                      ),
                    )
                  ),
                  Visibility(
                    visible: insight_list.isNotEmpty,
                    child: Center(
                      child: Column(
                        children: List.generate(insight_list.length, (index){
                          return ListTile3LineExpandable(
                            list_title: insight_list[index].title,
                            list_subtitle: insight_list[index].subtitle,
                            list_description: insight_list[index].description
                          );
                        }),
                      )
                    )
                  ),
                ]
              )
            ),
          ]
        )
      ),
    );
  }
}
