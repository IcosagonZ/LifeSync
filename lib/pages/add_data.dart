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

  // Controllers
  final TextEditingController academics_subject_controller = TextEditingController();
  final TextEditingController academics_marks_type_controller = TextEditingController();
  final TextEditingController academics_marks_controller = TextEditingController();
  final TextEditingController academics_marks_total_controller = TextEditingController();

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
            SizedBox(height: 16),

            Divider(),

            SizedBox(height: 16),

            // Academics data entry
            Visibility(
              visible: true,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text("Subject")
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 100,
                        ),
                        child: IntrinsicWidth(
                          child: TextField(
                            controller: academics_subject_controller,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              isDense: true,
                            ),
                          ),
                        ),
                      ),
                    ]
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Text("Mark type")
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 100,
                        ),
                        child: IntrinsicWidth(
                          child: TextField(
                            controller: academics_marks_type_controller,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              isDense: true,
                            ),
                          ),
                        ),
                      ),
                    ]
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Text("Marks received")
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 50,
                        ),
                        child: IntrinsicWidth(
                          child: TextField(
                            controller: academics_marks_controller,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              isDense: true,
                            ),
                          ),
                        ),
                      ),
                    ]
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Text("Marks total")
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 50,
                        ),
                        child: IntrinsicWidth(
                          child: TextField(
                            controller: academics_marks_total_controller,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              isDense: true,
                            ),
                          ),
                        ),
                      ),
                    ]
                  ),
                  SizedBox(height: 16),
                  Divider(),
                ]
              )
            )
          ]
        )
      ),

      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          child: ElevatedButton(
            child: Text("Add data"),
            onPressed: (){
              print("Add data pressed");
            },
          )
        )
      ),
    );
  }
}
