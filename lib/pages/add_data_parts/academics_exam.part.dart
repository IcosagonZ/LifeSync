part of '../add_data.dart';

extension AcademicsExamWidget on Page_AddData_State{
  Widget getAcademicsExamWidget(){
    return
    Visibility(
      visible: academics_dropdown_chosen=="Exam",
      child: Column(
        children: [
          SizedBox(height: 16),
          Divider(),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Text("Subject")
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 100,
                ),
                child: IntrinsicWidth(
                  child: TextField(
                    controller: academics_subject_controller,
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
                child: Text("Exam type")
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 100,
                ),
                child: IntrinsicWidth(
                  child: TextField(
                    controller: academics_type_controller,
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
                child: Text("Exam date")
              ),
              ActionChip(
                label: Text(academics_exam_date == null
                ? "Select date"
                : "${academics_exam_date!.toLocal()}".split(" ")[0],
                ),
                onPressed: () async{
                  final date_chosen = await data_date_select(context);
                  setState(()
                  {
                    if(date_chosen!=null)
                    {
                      academics_exam_date = date_chosen;
                    }
                  });
                },
              ),
            ]
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Text("Exam duration")
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 20,
                ),
                child: IntrinsicWidth(
                  child: TextField(
                    controller: academics_exam_duration_hours_controller,
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
                    controller: academics_exam_duration_mins_controller,
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
        ]
      )
    );
  }
}
