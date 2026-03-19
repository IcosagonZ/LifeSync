import 'package:flutter/material.dart';
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

class Page_Recommendations extends StatefulWidget
{
  const Page_Recommendations({super.key});

  @override
  State<Page_Recommendations> createState() => Page_Recommendations_State();
}

class Page_Recommendations_State extends State<Page_Recommendations>
{
  List recommendation_list = [];
  List insight_list = [];

  var section_scores = {
    "academics_absent":-1,
    //"academics_assignment":-1,
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

  Future<void> updateData() async
  {
    List<AcademicsAbsentData> academics_absent_data = await database_get_academics_absent();
    BackendMLData academics_absent_response = await backend_send_data(academics_absent_data, "academics/absent");
    section_scores["academics_absent"] = academics_absent_response.score;

    List<AcademicsMarkData> academics_mark_data = await database_get_academics_mark();
    BackendMLData academics_mark_response = await backend_send_data(academics_absent_data, "academics/mark");
    section_scores["academics_mark"] = academics_mark_response.score;

    List<ActivityData> activity_data = await database_get_activity();
    BackendMLData activity_response = await backend_send_data(activity_data, "activity");
    section_scores["activity"] = activity_response.score;

    List<BodyMeasurementData> bodymeasurement_data = await database_get_bodymeasurement();
    BackendMLData bodymeasurement_response = await backend_send_data(activity_data, "bodymeasurement");
    section_scores["bodymeasurement"] = bodymeasurement_response.score;

    List<MindMoodData> mind_mood_data = await database_get_mind_mood();
    BackendMLData mind_mood_response = await backend_send_data(activity_data, "mind/mood");
    section_scores["mind_mood"] = mind_mood_response.score;

    List<NutritionData> nutrition_data = await database_get_nutrition();
    BackendMLData nutrition_response = await backend_send_data(nutrition_data, "nutrition");
    section_scores["nutrition"] = nutrition_response.score;

    List<SymptomData> symptom_data = await database_get_symptom();
    BackendMLData symptom_response = await backend_send_data(activity_data, "symptom");
    section_scores["symptom"] = symptom_response.score;

    List<TimeData> time_data = await database_get_time();
    BackendMLData time_response = await backend_send_data(activity_data, "time");
    section_scores["time"] = time_response.score;

    List<VitalsData> vitals_data = await database_get_vitals();
    BackendMLData vitals_response = await backend_send_data(activity_data, "vitals");
    section_scores["vitals"] = vitals_response.score;

    List<WorkoutData> workout_data = await database_get_workout();
    BackendMLData workout_response = await backend_send_data(activity_data, "workout");
    section_scores["workout"] = workout_response.score;

    setState(()
    {
      recommendation_list.clear();
      insight_list.clear();

      recommendation_list.addAll(academics_absent_response.recommendations);
      recommendation_list.addAll(academics_mark_response.recommendations);
      recommendation_list.addAll(activity_response.recommendations);
      recommendation_list.addAll(bodymeasurement_response.recommendations);
      recommendation_list.addAll(mind_mood_response.recommendations);
      recommendation_list.addAll(nutrition_response.recommendations);
      recommendation_list.addAll(symptom_response.recommendations);
      recommendation_list.addAll(time_response.recommendations);
      recommendation_list.addAll(vitals_response.recommendations);
      recommendation_list.addAll(workout_response.recommendations);

      insight_list.addAll(academics_absent_response.insights);
      insight_list.addAll(academics_mark_response.insights);
      insight_list.addAll(activity_response.insights);
      insight_list.addAll(bodymeasurement_response.insights);
      insight_list.addAll(mind_mood_response.insights);
      insight_list.addAll(nutrition_response.insights);
      insight_list.addAll(symptom_response.insights);
      insight_list.addAll(time_response.insights);
      insight_list.addAll(vitals_response.insights);
      insight_list.addAll(workout_response.insights);
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
        title: Text("Recommendations"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            tooltip: "Refresh",
            onPressed: (){
              print("Refresh pressed");
              updateData();
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
                    CircleAvatar(
                      radius: 32,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("N/A"),
                          Text("Score", style: TextStyle(fontSize: 10)),
                        ]
                      ),
                    ),
                  ],
                ),
              )
            ),
            SizedBox(height: 16),
            Text("Recommendations", style: style_titlelarge),
            SizedBox(height: 16),
            Card.outlined(
              child: Padding(
                padding: EdgeInsets.all(2),
                child: Stack(
                  children: [
                    Visibility(
                      visible: recommendation_list.isEmpty,
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(
                          child: Text("No data available")
                        ),
                      )
                    ),
                    Visibility(
                      visible: recommendation_list.isNotEmpty,
                      child: Center(
                        child: Column(
                          spacing: 2,
                          children: List.generate(recommendation_list.length, (index){
                            final data = recommendation_list[index];
                            final tile = RecentsListTileSingleText(
                              list_title: data.title,
                              list_subtitle: data.subtitle,
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
            Text("Insights", style: style_titlelarge),
            SizedBox(height: 16),
            Card.outlined(
              child: Padding(
                padding: EdgeInsets.all(2),
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
                          spacing: 2,
                          children: List.generate(insight_list.length, (index){
                            final data = insight_list[index];
                            final tile = RecentsListTileSingleText(
                              list_title: data.title,
                              list_subtitle: data.subtitle,
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
