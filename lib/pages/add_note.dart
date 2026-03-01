import 'package:flutter/material.dart';
//import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import 'sections/notes.dart';

import '../data/database.dart';

class Page_AddNote extends StatefulWidget
{
  const Page_AddNote({super.key});

  @override
  State<Page_AddNote> createState() => Page_AddNote_State();
}

class Page_AddNote_State extends State<Page_AddNote>
{
  // Time and date variables
  DateTime data_datetime = DateTime.now();

  TimeOfDay? data_time_chosen;
  DateTime? _data_time_chosen;
  DateTime? data_date_chosen;

  // Controllers
  final TextEditingController title_controller = TextEditingController();
  final TextEditingController content_controller = TextEditingController();

  @override
  void initState()
  {
    super.initState();

    data_time_chosen = TimeOfDay.now();
    data_date_chosen = DateTime.now();
  }

  // Move to seperate file
  SnackBar notify_snackbar(String message)
  {
    return SnackBar(
      content: Text(
        message,
        style: TextStyle(
          color:Color.fromRGBO(250, 250, 250, 1)
        ),
      ),
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      backgroundColor: Color.fromRGBO(33, 33, 33, 1),
      closeIconColor: Color.fromRGBO(250, 250, 250, 1),
    );
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

  Future<DateTime?> data_date_select(BuildContext context) async
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
      return picked_date;
    }

    return null;
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
        title: Text("Add note"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children:[
            Column(
              children: [
                TextField(
                  controller: title_controller,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    hintText: "Title",
                    border: InputBorder.none,
                  ),
                ),
              ]
            ),
            TextField(
              controller: content_controller,
              decoration: InputDecoration(
                hintText: "Type...",
                border:InputBorder.none,
              ),
              maxLines: null,
            ),
            /* DateTime not required for now I guess
            SizedBox(height: 8),
            Row(
              children: [
                TextButton(
                  onPressed: (){
                    data_time_select(context);
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(data_time_chosen == null
                  ? "Select time"
                  : "${data_time_chosen!.format(context)}"
                  ),
                ),
                SizedBox(width: 2),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: () async{
                    final date_chosen = await data_date_select(context);
                    setState(()
                    {
                      if(date_chosen!=null)
                      {
                        data_date_chosen = date_chosen;
                      }
                    });
                  },
                  child: Text(data_date_chosen == null
                  ? "Select date"
                  : "${data_date_chosen!.toLocal()}".split(" ")[0],
                  ),
                ),
              ],
            ),
            */
          ]
        )
      ),
      floatingActionButton: IconButton(
        icon: Icon(Icons.save),
        tooltip: "Save note",
        onPressed: (){
          print("Save note data pressed");
          if(title_controller.text.isEmpty || content_controller.text.isEmpty)
          {
            ScaffoldMessenger.of(context).showSnackBar(notify_snackbar("Empty field not allowed!"));
          }
          else
          {
            database_insert_note(
              title_controller.text,
              content_controller.text,
              "Manual",
              data_datetime.toIso8601String(),
            ).then((int row_index)
            {
              if(row_index==0)
              {
                ScaffoldMessenger.of(context).showSnackBar(notify_snackbar("Data entry failed"));
              }
              else
              {
                ScaffoldMessenger.of(context).showSnackBar(notify_snackbar("Data entry success"));
                /*Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)
                {
                  return const Page_Notes();
                }
                ));*/
                Navigator.pop(context, true);
              }
            });
          }
        },
      ),
    );
  }
}
