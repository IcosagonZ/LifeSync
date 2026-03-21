part of '../add_data.dart';

extension NutritionWidget on Page_AddData_State{
  Widget getNutritionWidget(){
    return Visibility(
      visible: datatype_dropdown_chosen=="Nutrition",
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
                    controller: nutrition_name_controller,
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
                child: Text("Form")
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 100,
                ),
                child:   DropdownButton<String>(
                  hint: Text("Select..."),
                  value: nutrition_form_dropdown_chosen,
                  onChanged: (String? newValue)
                  {
                    setState(()
                    {
                      nutrition_form_dropdown_chosen = newValue;
                      print(nutrition_form_dropdown_chosen);
                    });
                  },
                  items: nutrition_form_options.map<DropdownMenuItem<String>>((String dropdown_item)
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
          Row(
            children: [
              Expanded(
                child: Text("Type")
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 100,
                ),
                child:  DropdownButton<String>(
                  hint: Text("Select..."),
                  value: nutrition_type_dropdown_chosen,
                  onChanged: (String? newValue)
                  {
                    setState(()
                    {
                      nutrition_type_dropdown_chosen = newValue;
                      print(nutrition_type_dropdown_chosen);
                    });
                  },
                  items: nutrition_type_options.map<DropdownMenuItem<String>>((String dropdown_item)
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
          Divider(),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Text("Quantity")
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 20,
                ),
                child: IntrinsicWidth(
                  child: TextField(
                    controller: nutrition_qty_controller,
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
                child: Text("Calories")
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 30,
                ),
                child: IntrinsicWidth(
                  child: TextField(
                    controller: nutrition_calories_controller,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Text("cal"),
            ]
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Text("Mass")
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 30,
                ),
                child: IntrinsicWidth(
                  child: TextField(
                    controller: nutrition_mass_controller,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Text("g"),
            ]
          ),
          SizedBox(height: 16),
          Divider(),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Text("Carbohydrates")
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 30,
                ),
                child: IntrinsicWidth(
                  child: TextField(
                    controller: nutrition_carbs_controller,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Text("g"),
            ]
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Text("Proteins")
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 30,
                ),
                child: IntrinsicWidth(
                  child: TextField(
                    controller: nutrition_proteins_controller,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Text("g"),
            ]
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Text("Fats")
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 30,
                ),
                child: IntrinsicWidth(
                  child: TextField(
                    controller: nutrition_fats_controller,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Text("g"),
            ]
          ),
          SizedBox(height: 16),
          Divider(),
        ]
      )
    );
  }
}
