part of '../add_data.dart';

// Time widgets
TimeOfDay? data_time_start_chosen;
TimeOfDay? data_time_end_chosen;

DateTime? data_time_start_date;
DateTime? data_time_end_date;

final TextEditingController time_duration_hours_controller = TextEditingController();
final TextEditingController time_duration_minutes_controller = TextEditingController();

final List<String> time_type_options = [
  "Sleep",
  "Study",
  "Food",
  "Hobby",
  "Gaming",
  "Outing",
  "Commute",
  "Entertainment",
];
String? time_type_dropdown_chosen;

extension TimeWidget on Page_AddData_State
{
  Widget getTimeWidget(){
    return Visibility(
      visible: datatype_dropdown_chosen=="Time",
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
                  value: time_type_dropdown_chosen,
                  onChanged: (String? newValue)
                  {
                    setState(()
                    {
                      time_type_dropdown_chosen = newValue;
                      //print(time_type_dropdown_chosen);
                    });
                  },
                  items: time_type_options.map<DropdownMenuItem<String>>((String dropdown_item)
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
                child: Text("Start")
              ),
              ActionChip(
                label: Text(data_time_start_chosen == null
                ? "Select time"
                : "${data_time_start_chosen!.format(context)}"
                ),
                onPressed: () async
                {
                  final time_chosen = await data_time_select(context);
                  if(time_chosen!=null)
                  {
                    setState(()
                    {
                      data_time_start_chosen = time_chosen;
                    });
                    time_calculate_duration();
                  }
                },
              ),
              SizedBox(width: 16),
              ActionChip(
                label: Text(data_time_start_date == null
                ? "Select date"
                : "${data_time_start_date!.toLocal()}".split(" ")[0],
                ),
                onPressed: () async{
                  final date_chosen = await data_date_select(context);
                  if(date_chosen!=null)
                  {
                    setState(()
                    {
                      data_time_start_date = date_chosen;
                    });
                    time_calculate_duration();
                  }
                },
              ),
            ]
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Text("End")
              ),
              ActionChip(
                label: Text(data_time_end_chosen == null
                ? "Select time"
                : "${data_time_end_chosen!.format(context)}"
                ),
                onPressed: () async
                {
                  final time_chosen = await data_time_select(context);;
                  if(time_chosen!=null)
                  {
                    setState(()
                    {
                      data_time_end_chosen = time_chosen;
                    });
                    time_calculate_duration();
                  }
                },
              ),
              SizedBox(width: 16),
              ActionChip(
                label: Text(data_time_end_date == null
                ? "Select date"
                : "${data_time_end_date!.toLocal()}".split(" ")[0],
                ),
                onPressed: () async{
                  final date_chosen = await data_date_select(context);
                  if(date_chosen!=null)
                  {
                    setState(()
                    {
                      data_time_end_date = date_chosen;
                    });
                    time_calculate_duration();
                  }
                },
              ),
            ]
          ),
          SizedBox(height: 16),
          Divider(),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Text("Duration")
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 20,
                ),
                child: IntrinsicWidth(
                  child: TextField(
                    controller: time_duration_hours_controller,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Text("hrs"),
              SizedBox(width: 16),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 20,
                ),
                child: IntrinsicWidth(
                  child: TextField(
                    controller: time_duration_minutes_controller,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Text("mins"),
            ]
          ),
          SizedBox(height: 16),
          Divider(),
        ]
      )
    );
  }
}
