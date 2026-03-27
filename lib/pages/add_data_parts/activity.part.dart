part of '../add_data.dart';

// Activity controllers
//final TextEditingController activity_name_controller = TextEditingController();
final TextEditingController activity_type_controller = TextEditingController();
final TextEditingController activity_duration_hours_controller = TextEditingController();
final TextEditingController activity_duration_minutes_controller = TextEditingController();
final TextEditingController activity_calories_controller = TextEditingController();
final TextEditingController activity_distance_controller = TextEditingController(text: "0");

final List<String> activity_dropdown_options = [
  "Badminton",
  "Baseball",
  "Basketball",
  "Cricket",
  "Cycling",
  "Downhill Skiing",
  "Electric Bike",
  "Football",
  "Golf",
  "Handball",
  "Hiking",
  "Hockey",
  "Ice Skating",
  "Kabbadi",
  "Kayaking",
  "Kite Surfing",
  "Martial Arts",
  "Mixed Martial Arts",
  "Motorsports",
  "Pickleball",
  "Pool",
  "Roller Skating",
  "Rugby",
  "Running",
  "Sailing",
  "Skateboarding",
  "Sprint",
  "Surfing",
  "Volleyball",
  "Custom"
];
String? activity_dropdown_chosen;

extension ActivityWidget on Page_AddData_State{
  Widget getActivityWidget(){
    return
    Visibility(
      visible: datatype_dropdown_chosen=="Activity",
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text("Name")
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 100,
                ),
                child:  DropdownButton<String>(
                  hint: Text("Select..."),
                  value: activity_dropdown_chosen,
                  onChanged: (String? newValue)
                  {
                    setState(()
                    {
                      activity_dropdown_chosen = newValue;
                      //print(activity_dropdown_chosen);
                    });
                  },
                  items: activity_dropdown_options.map<DropdownMenuItem<String>>((String dropdown_item)
                  {
                    return DropdownMenuItem<String>(
                      value: dropdown_item,
                      child: Text(dropdown_item)
                    );
                  }
                  ).toList(),
                )
              ),
            ]
          ),
          SizedBox(height: 16),
          /*
           *    Row(
           *      children: [
           *        Expanded(
           *          child: Text("Type")
      ),
      ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 100,
      ),
      child: IntrinsicWidth(
        child: TextField(
          controller: activity_type_controller,
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
      */
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
                    controller: activity_duration_hours_controller,
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
                    controller: activity_duration_minutes_controller,
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
          Row(
            children: [
              Expanded(
                child: Text("Calories")
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 50,
                ),
                child: IntrinsicWidth(
                  child: TextField(
                    controller: activity_calories_controller,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Text("cal"),
            ]
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Text("Distance")
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 50,
                ),
                child: IntrinsicWidth(
                  child: TextField(
                    controller: activity_distance_controller,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Text("km"),
            ]
          ),
          SizedBox(height: 16),
          Divider(),
        ]
      )
    );
  }
}
