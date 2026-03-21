part of '../add_data.dart';

extension TimeWidget on Page_AddData_State{
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
                      print(time_type_dropdown_chosen);
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
