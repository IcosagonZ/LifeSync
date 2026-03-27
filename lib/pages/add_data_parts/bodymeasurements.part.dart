part of '../add_data.dart';

// Body measurement widgets
final TextEditingController bodymeasurement_height_controller = TextEditingController();
final TextEditingController bodymeasurement_weight_controller = TextEditingController();

final List<String> bodymeasurement_dropdown_options = [
  "Height",
  "Weight",
];
String? bodymeasurement_dropdown_chosen;

extension BodyMeasurementsWidget on Page_AddData_State{
  Widget getBodyMeasurementsWidget(){
    return Visibility(
      visible: datatype_dropdown_chosen=="Body Measurements",
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text("Type")
              ),
              DropdownButton<String>(
                hint: Text("Select data type"),
                value: bodymeasurement_dropdown_chosen,
                onChanged: (String? newValue)
                {
                  setState(()
                  {
                    bodymeasurement_dropdown_chosen = newValue;
                    //print(bodymeasurement_dropdown_chosen);
                  });
                },
                items: bodymeasurement_dropdown_options.map<DropdownMenuItem<String>>((String dropdown_item)
                {
                  return DropdownMenuItem<String>(
                    value: dropdown_item,
                    child: Text(dropdown_item)
                  );
                }
                ).toList(),
              )
            ]
          ),
          Visibility(
            visible: bodymeasurement_dropdown_chosen=="Height",
            child: Column(
              children: [
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Text("Height")
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: 50,
                      ),
                      child: IntrinsicWidth(
                        child: TextField(
                          controller: bodymeasurement_height_controller,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            isDense: true,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Text("cm"),
                  ]
                ),
              ]
            )
          ),
          Visibility(
            visible: bodymeasurement_dropdown_chosen=="Weight",
            child: Column(
              children: [
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Text("Weight")
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: 50,
                      ),
                      child: IntrinsicWidth(
                        child: TextField(
                          controller: bodymeasurement_weight_controller,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            isDense: true,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Text("kg"),
                  ]
                ),
              ]
            )
          ),
          SizedBox(height: 16),
          Divider(),
        ]
      )
    );
  }
}
