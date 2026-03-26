import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../main.dart';

import '../../data/database.dart';
import '../../data/models/nutrition.dart';

import '../../data/iconmapper.dart';

import '../add_data.dart';

import '../../components/recents_listtile_multiline.dart';
import '../../components/avatar_gradient.dart';

import '../../helpers/helper_calculate.dart';

class Page_Nutrition extends StatefulWidget
{
  const Page_Nutrition({super.key});

  @override
  State<Page_Nutrition> createState() => Page_Nutrition_State();
}

class Page_Nutrition_State extends State<Page_Nutrition> with RouteAware
{
  // Widget variables
  DateTime data_timenow = DateTime.now();

  List<NutritionData> nutrition_data = [];

  int nutrition_data_total_calories = 0;
  String nutrition_data_required_calories = "N/A";

  String score = "N/A";

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

  // Route aware functions
  @override
  void didPopNext()
  {
    initData();
  }

  Future<void> initData() async
  {
    List<NutritionData> nutrition_data_result = await database_get_nutrition_for_date(data_timenow);
    int nutrition_data_total_calories_result = await database_aggregate_nutrition_calories(data_timenow);

    // Required calories calculation
    int height_result = await database_get_goal("height");
    int weight_result = await database_get_goal("weight");
    int age_result = await database_get_goal("age");
    int gender_result = await database_get_goal("gender");

    String gender_string = "F";
    if(gender_string==1)
    {
      gender_string = "M";
    }

    int nutrition_data_required_calories_result = await helper_get_calories_required(height_result, weight_result, age_result, gender_string);

    final score_result = await database_get_score("nutrition");

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

      if(nutrition_data_required_calories_result>1000)
      {
        nutrition_data_required_calories = nutrition_data_required_calories_result.toString();
      }
      else
      {
        nutrition_data_required_calories = "N/A";
      }

      nutrition_data = nutrition_data_result;
      nutrition_data_total_calories = nutrition_data_total_calories_result;
    });
  }

  @override
  Widget build(BuildContext context)
  {
    // Theming and text styles
    final color_scheme = Theme.of(context).colorScheme;
    final text_theme = Theme.of(context).textTheme;

    final color_primary = color_scheme.primary;//Theme.of(context).extension<ColorsOverviewButtons>()?.nutrition;
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
        title: Text("Nutrition"),
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
                arguments: "nutrition",
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
                          Row(
                            children: [
                              Expanded(
                                child: Text("Calories consumed", style: style_cardlabel)
                              ),
                              Text("$nutrition_data_total_calories cal")
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: Text("Calorie target", style: style_cardlabel),
                              ),
                              Text("${nutrition_data_required_calories} cal"),
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
            Text("Today", style: style_titlelarge),
            SizedBox(height: 16),
            Card.outlined(
              child: Padding(
                padding: EdgeInsets.all(2),
                child: Stack(
                  children: [
                    Visibility(
                      visible: nutrition_data.isEmpty,
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(
                          child: Text("No data available")
                        ),
                      )
                    ),
                    Visibility(
                      visible: nutrition_data.isNotEmpty,
                      child: Center(
                        child: Column(
                          spacing: 2,
                          children: List.generate(nutrition_data.length, (index){
                            final data = nutrition_data[index];
                            final tile = RecentsListTileMultiline(
                              list_icon: Icon(iconmapper_geticon("Nutrition")),
                              list_title: data.name,
                              list_subtitle: "${data.calories} cal",
                              list_trail: DateFormat('h:mm a').format(data.entry_date),
                              id: data.id,
                              datatype: "nutrition",
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
    );
  }
}
