import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../data/backend.dart';
import '../../components/snackbar_notify.dart';
import '../../components/dialog_information.dart';

class Page_NutritionImageRecognition extends StatefulWidget
{
  const Page_NutritionImageRecognition({super.key});

  @override
  State<Page_NutritionImageRecognition> createState() => Page_NutritionImageRecognition_State();
}

class Page_NutritionImageRecognition_State extends State<Page_NutritionImageRecognition>
{
  // Widget variables
  TextEditingController nutrition_name = TextEditingController();
  TextEditingController nutrition_calories = TextEditingController();

  List<NutritionPredictions> nutrition_predictions = [];
  bool nutrition_loading = false;

  bool nutrition_data_received = false;
  String nutrition_name_text = "-1";
  String nutrition_calories_text = "-1";

  // Nutrition image picker
  final ImagePicker nutrition_imagepicker = ImagePicker();
  XFile? image_path;

  Future<void> nutrition_pickimage() async
  {
    final XFile? image = await nutrition_imagepicker.pickImage(
      source: ImageSource.gallery
    );

    setState(() {
      image_path = image;
    });
    print("Image picked");
  }

  Future<NutritionImageResponse> nutrition_upload() async
  {
    NutritionImageResponse nutrition_response =
    await backend_send_nutrition_image(File(image_path!.path));;
    setState(()
    {
      //nutrition_name_text = nutrition_response.name;
      //nutrition_calories_text = nutrition_response.calories;
      if(nutrition_response.status=="OK")
      {
        nutrition_data_received = true;
      }
      else
      {
        nutrition_data_received = false;
      }
    });

    return nutrition_response;
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

    return Scaffold(
      appBar: AppBar(
        title: Text("Image Recognition"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children:[
            AspectRatio(
              aspectRatio: 1,
              child: Card(
                child: InkWell(
                  onTap: (){
                    nutrition_pickimage();
                  },
                  child: image_path==null
                  ? const Center(
                    child: Text("Pick image")
                  )
                  : Image.file(
                    File(image_path!.path),
                    fit: BoxFit.cover,
                  )
                )
              )
            ),
            SizedBox(height: 32),
            Visibility(
              visible: nutrition_predictions.isEmpty && !nutrition_loading,
              child: Card(
                child: Padding(
                  padding: EdgeInsetsGeometry.all(32),
                  child: Center(
                    child: Text("No predictions available")
                  )
                )
              )
            ),
            Visibility(
              visible: nutrition_loading,
              child: Card(
                child: Padding(
                  padding: EdgeInsetsGeometry.all(32),
                  child: Center(
                    child: CircularProgressIndicator()
                  )
                )
              )
            ),
            Visibility(
              visible: nutrition_predictions.isNotEmpty && !nutrition_loading,
              child: Card(
                child: Padding(
                  padding: EdgeInsetsGeometry.all(8),
                  child: Column(
                    children: List.generate(nutrition_predictions.length, (index)
                    {
                      final item = nutrition_predictions[index];
                      final calories = item.calories;
                      String calories_string = "N/A";
                      if(calories!=-1)
                      {
                        calories_string = "${calories} cal";
                      }

                      return InkWell(
                        onTap: (){
                          Navigator.pop(context, {
                            "name" : item.name,
                            "calories" : item.calories
                          });
                        },
                        child: Padding(
                          padding: EdgeInsetsGeometry.all(8),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(item.name),
                              ),
                              Text(calories_string),
                              SizedBox(width: 8),
                              Text("${item.confidence.toStringAsFixed(2)}%"),
                            ],
                          ),
                        )
                      );
                    }),
                  )
                )
              )
            ),
          ]
        )
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsetsGeometry.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              child: Text("Upload image"),
              onPressed: () async
              {
                if(image_path!=null)
                {
                  if(mounted)
                  {
                    setState(() {
                      nutrition_loading = true;
                    });
                  }

                  final result = await nutrition_upload();
                  if(result.status=="OK")
                  {
                    if(mounted)
                    {
                      ScaffoldMessenger.of(context).showSnackBar(notify_snackbar("Received data from server"));
                      setState(() {
                        nutrition_predictions = result.result;
                      });
                    }
                  }
                  else
                  {
                    if(mounted)
                    {
                      dialog_information_show(context, "Error ${result.status}", result.message);
                    }
                  }

                  if(mounted)
                  {
                    setState(() {
                      nutrition_loading = false;
                    });
                  }
                }
              },
            ),
            SizedBox(height: 16),
          ]
        ),
      ),
    );
  }
}
