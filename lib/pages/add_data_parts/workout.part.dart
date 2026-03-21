part of '../add_data.dart';

extension WorkoutWidget on Page_AddData_State{
  Widget getWorkoutWidget(){
    return Visibility(
      visible: datatype_dropdown_chosen=="Workout",
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
                child: IntrinsicWidth(
                  child: TextField(
                    controller: workout_name_controller,
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
                child: Text("Type")
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 100,
                ),
                child: IntrinsicWidth(
                  child: TextField(
                    controller: workout_type_controller,
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
                child: Text("Duration")
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 20,
                ),
                child: IntrinsicWidth(
                  child: TextField(
                    controller: workout_duration_hours_controller,
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
                    controller: workout_duration_minutes_controller,
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
                    controller: workout_calories_controller,
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
          Divider(),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Text("Repetitions per set")
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 30,
                ),
                child: IntrinsicWidth(
                  child: TextField(
                    controller: workout_reps_controller,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Text("reps"),
            ]
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Text("Sets")
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 30,
                ),
                child: IntrinsicWidth(
                  child: TextField(
                    controller: workout_sets_controller,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Text("sets"),
            ]
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Text("Weight")
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 30,
                ),
                child: IntrinsicWidth(
                  child: TextField(
                    controller: workout_weight_controller,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Text("kg"),
            ]
          ),
          SizedBox(height: 16),
          Divider(),
        ]
      )
    );
  }
}
