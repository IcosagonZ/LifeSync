part of '../add_data.dart';

// Mind widgets
final TextEditingController mind_mood_name_controller = TextEditingController();
bool? mind_mood_resolved;
DateTime? mind_mood_end_date;

final List<String> mind_mood_intensity_dropdown_options = [
  "Light",
  "Moderate",
  "Severe",
];
String? mind_mood_intensity_dropdown_chosen;

extension MindWidget on Page_AddData_State{
  Widget getMindWidget(){
    return Visibility(
      visible: datatype_dropdown_chosen=="Mind",
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text("Mood")
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 100,
                ),
                child: IntrinsicWidth(
                  child: TextField(
                    controller: mind_mood_name_controller,
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
                  value: mind_mood_intensity_dropdown_chosen,
                  onChanged: (String? newValue)
                  {
                    setState(()
                    {
                      mind_mood_intensity_dropdown_chosen = newValue;
                      print(mind_mood_intensity_dropdown_chosen);
                    });
                  },
                  items: mind_mood_intensity_dropdown_options.map<DropdownMenuItem<String>>((String dropdown_item)
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
                value: mind_mood_resolved,
                onChanged: (bool? value){
                  setState(() {
                    mind_mood_resolved = value;
                    print(value);
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
                label: Text(mind_mood_end_date == null
                ? "Select date"
                : "${mind_mood_end_date!.toLocal()}".split(" ")[0],
                ),
                onPressed: () async{
                  final date_chosen = await data_date_select(context);
                  setState(()
                  {
                    if(date_chosen!=null)
                    {
                      mind_mood_end_date = date_chosen;
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
