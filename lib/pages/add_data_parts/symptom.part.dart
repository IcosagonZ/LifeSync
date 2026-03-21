part of '../add_data.dart';

// Symptoms
final TextEditingController symptoms_name_controller = TextEditingController();
bool? symptoms_resolved;
DateTime? symptoms_end_date;

final List<String> symptoms_intensity_dropdown_options = [
  "Light",
  "Moderate",
  "Severe",
];
String? symptoms_intensity_dropdown_chosen;

extension SymptomWidget on Page_AddData_State{
  Widget getSymptomWidget(){
    return Visibility(
      visible: datatype_dropdown_chosen=="Symptom",
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text("Symptom")
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 100,
                ),
                child: IntrinsicWidth(
                  child: TextField(
                    controller: symptoms_name_controller,
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
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Text("Intensity")
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 100,
                ),
                child: DropdownButton<String>(
                  hint: Text("Select..."),
                  value: symptoms_intensity_dropdown_chosen,
                  onChanged: (String? newValue)
                  {
                    setState(()
                    {
                      symptoms_intensity_dropdown_chosen = newValue;
                      print(symptoms_intensity_dropdown_chosen);
                    });
                  },
                  items: symptoms_intensity_dropdown_options.map<DropdownMenuItem<String>>((String dropdown_item)
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
          Divider(),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Text("Resolved")
              ),
              Checkbox(
                tristate: true,
                value: symptoms_resolved,
                onChanged: (bool? value){
                  setState(() {
                    symptoms_resolved = value;
                  });
                },
              )
            ]
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Text("End date")
              ),

              ActionChip(
                label: Text(symptoms_end_date == null
                ? "Select date"
                : "${symptoms_end_date!.toLocal()}".split(" ")[0],
                ),
                onPressed: () async{
                  final date_chosen = await data_date_select(context);
                  setState(()
                  {
                    if(date_chosen!=null)
                    {
                      symptoms_end_date = date_chosen;
                    }
                  });
                },
              ),
            ]
          ),
          SizedBox(height: 16),
          Divider(),
        ]
      )
    );
  }
}
