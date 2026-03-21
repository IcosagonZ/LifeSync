part of '../add_data.dart';

// Absent
final TextEditingController academics_absent_reason_controller = TextEditingController();
DateTime academics_absent_date = DateTime.now();

extension AcademicsAbsentWidget on Page_AddData_State{
  Widget getAcademicsAbsentWidget(){
    return
    Visibility(
      visible: academics_dropdown_chosen=="Absent",
      child: Column(
        children: [
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Text("Reason")
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 100,
                ),
                child: IntrinsicWidth(
                  child: TextField(
                    controller: academics_absent_reason_controller,
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
                child: Text("Absent Date")
              ),

              ActionChip(
                label: Text(academics_absent_date == null
                ? "Select date"
                : "${academics_absent_date!.toLocal()}".split(" ")[0],
                ),
                onPressed: () async{
                  final date_chosen = await data_date_select(context);
                  setState(()
                  {
                    if(date_chosen!=null)
                    {
                      academics_absent_date = date_chosen;
                    }
                  });
                },
              ),
            ]
          ),
        ]
      )
    );
  }
}
