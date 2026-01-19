import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class Page_AddData extends StatefulWidget
{
  const Page_AddData({super.key});

  @override
  State<Page_AddData> createState() => Page_AddData_State();
}

class Page_AddData_State extends State<Page_AddData>
{
  // Widget variables
  final List<String> datatype_dropdown_options = [
    "Academics",
    "Activity",
    "Body Measurements",
    "Nutrition",
    "Time",
    "Vitals",
    "Workout",
  ];

  String? datatype_dropdown_chosen;

  DateTime data_datetime = DateTime.now();

  TimeOfDay? data_time_chosen;
  DateTime? _data_time_chosen;
  DateTime? data_date_chosen;

  @override
  void initState()
  {
    super.initState();

    data_time_chosen = TimeOfDay.now();
    data_date_chosen = DateTime.now();
  }

  Future<void> data_time_select(BuildContext context) async
  {
    final TimeOfDay? picked_time = await showTimePicker
    (
      context: context,
     initialTime: data_time_chosen ?? TimeOfDay.now(),
     builder: (BuildContext context, Widget? child)
     {
       return MediaQuery(
         data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
         child: child!,
       );
     }
    );

    if(picked_time != null && picked_time != data_time_chosen)
    {
      setState(()
      {
        data_time_chosen = picked_time;
        _data_time_chosen = DateTime(2025, 5, 15, picked_time.hour, picked_time.minute);
      }
      );
    }
  }

  Future<void> data_date_select(BuildContext context) async
  {
    final DateTime? picked_date = await showDatePicker
    (
      context: context,
     initialDate: data_date_chosen ?? DateTime.now(),
     firstDate: DateTime(2010),
     lastDate: DateTime.now(),
    );

    if(picked_date != null && picked_date != data_date_chosen)
    {
      setState(()
      {
        data_date_chosen = picked_date;
      }
      );
    }
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
        title: Text("Add data"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children:[
            // Data type choser
            Row(
              children: [
                Expanded(
                  child: Text("Data type")
                ),
                DropdownButton<String>(
                  hint: Text("Select data type"),
                  value: datatype_dropdown_chosen,
                  onChanged: (String? newValue)
                  {
                    setState(()
                    {
                      datatype_dropdown_chosen = newValue;
                      print(datatype_dropdown_chosen);
                    });
                  },
                  items: datatype_dropdown_options.map<DropdownMenuItem<String>>((String dropdown_item)
                  {
                    return DropdownMenuItem<String>(
                      value: dropdown_item,
                      child: Text(dropdown_item)
                    );
                  }
                  ).toList(),
                )
              ],
            ),
            SizedBox(height: 16),
            // Time choser
            Row(
              children: [
                Expanded(
                  child: Text("Time")
                ),
                ActionChip(
                  label: Text(data_time_chosen == null
                    ? "Select time"
                    : "${data_time_chosen!.format(context)}"
                  ),
                  onPressed: (){
                    data_time_select(context);
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            // Date choser
            Row(
              children: [
                Expanded(
                  child: Text("Date")
                ),
                ActionChip(
                  label: Text(data_date_chosen == null
                  ? "Select date"
                  : "${data_date_chosen!.toLocal()}".split(" ")[0],
                  ),
                  onPressed: (){
                    data_date_select(context);
                  },
                ),
              ],
            ),
          ]
        )
      ),
    );
  }
}
