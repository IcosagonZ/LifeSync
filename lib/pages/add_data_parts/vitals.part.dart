part of '../add_data.dart';

// Vital widgets
final TextEditingController vital_bodytemperature_controller = TextEditingController();
final TextEditingController vital_bloodoxygen_controller = TextEditingController();
final TextEditingController vital_bloodsugar_controller = TextEditingController();

final TextEditingController vital_bloodpressure_systolic_controller = TextEditingController();
final TextEditingController vital_bloodpressure_diastolic_controller = TextEditingController();

final TextEditingController vital_heartrate_controller = TextEditingController();

final List<String> vital_name_options = [
  "Body Temperature",
  "Blood Oxygen",
  "Blood Pressure",
  "Blood Sugar",
  "Heartrate"
];
String? vital_name_dropdown_chosen;

extension VitalsWidget on Page_AddData_State{
  Widget getVitalsWidget(){
    return Visibility(
      visible: datatype_dropdown_chosen=="Vitals",
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text("Type")
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 100,
                ),
                child: DropdownButton<String>(
                  hint: Text("Select..."),
                  value: vital_name_dropdown_chosen,
                  onChanged: (String? newValue)
                  {
                    setState(()
                    {
                      vital_name_dropdown_chosen = newValue;
                      //print(vital_name_dropdown_chosen);
                    });
                  },
                  items: vital_name_options.map<DropdownMenuItem<String>>((String dropdown_item)
                  {
                    return DropdownMenuItem<String>(
                      value: dropdown_item,
                      child: Text(dropdown_item)
                    );
                  }
                  ).toList(),
                ),
              ),
            ]
          ),
          SizedBox(height: 16),
          Visibility(
            visible: vital_name_dropdown_chosen=="Blood Oxygen",
            child: Column(
              children: [
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Text("Blood Oxygen Percentage")
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: 30,
                      ),
                      child: IntrinsicWidth(
                        child: TextField(
                          controller: vital_bloodoxygen_controller,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            isDense: true,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Text("%"),
                  ]
                ),
              ]
            )
          ),
          Visibility(
            visible: vital_name_dropdown_chosen=="Body Temperature",
            child: Column(
              children: [
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Text("Body Temperature")
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: 30,
                      ),
                      child: IntrinsicWidth(
                        child: TextField(
                          controller: vital_bodytemperature_controller,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            isDense: true,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Text("°C"),
                  ]
                ),
              ]
            )
          ),
          Visibility(
            visible: vital_name_dropdown_chosen=="Blood Pressure",
            child: Column(
              children: [
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Text("Blood Pressure")
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: 30,
                      ),
                      child: IntrinsicWidth(
                        child: TextField(
                          controller: vital_bloodpressure_systolic_controller,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            isDense: true,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Text("/"),
                    SizedBox(width: 16),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: 30,
                      ),
                      child: IntrinsicWidth(
                        child: TextField(
                          controller: vital_bloodpressure_diastolic_controller,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            isDense: true,
                          ),
                        ),
                      ),
                    ),
                  ]
                ),
              ]
            )
          ),
          Visibility(
            visible: vital_name_dropdown_chosen=="Blood Sugar",
            child: Column(
              children: [
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Text("Blood Sugar")
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: 30,
                      ),
                      child: IntrinsicWidth(
                        child: TextField(
                          controller: vital_bloodsugar_controller,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            isDense: true,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Text("mmol/L"),
                  ]
                ),
              ]
            )
          ),
          Visibility(
            visible: vital_name_dropdown_chosen=="Heartrate",
            child: Column(
              children: [
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Text("Heartrate")
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: 30,
                      ),
                      child: IntrinsicWidth(
                        child: TextField(
                          controller: vital_heartrate_controller,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            isDense: true,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Text("bpm"),
                  ]
                ),
              ]
            )
          ),
          SizedBox(height: 16),
          Divider(),
        ],
      ),
    );
  }
}
