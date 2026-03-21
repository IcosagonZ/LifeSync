part of '../add_data.dart';

extension AcademicsAssignmentWidget on Page_AddData_State{
  Widget getAcademicsAssignmentWidget(){
    return Visibility(
      visible: academics_dropdown_chosen=="Assignment",
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
                child: Text("Assignment Type")
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
                child: Text("Assignment Topic")
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 100,
                ),
                child: IntrinsicWidth(
                  child: TextField(
                    controller: academics_assignment_topic_controller,
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
          Divider(),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Text("Due Date")
              ),

              ActionChip(
                label: Text(academics_assignment_due_date == null
                ? "Select date"
                : "${academics_assignment_due_date!.toLocal()}".split(" ")[0],
                ),
                onPressed: () async{
                  final date_chosen = await data_date_select(context);
                  setState(()
                  {
                    if(date_chosen!=null)
                    {
                      academics_assignment_due_date = date_chosen;
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
                child: Text("Submission Date")
              ),
              ActionChip(
                label: Text(academics_assignment_submission_date == null
                ? "Select date"
                : "${academics_assignment_submission_date!.toLocal()}".split(" ")[0],
                ),
                onPressed: () async{
                  final date_chosen = await data_date_select(context);
                  setState(()
                  {
                    if(date_chosen!=null)
                    {
                      academics_assignment_submission_date = date_chosen;
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
                child: Text("Submitted")
              ),
              Checkbox(
                tristate: true,
                value: academics_assignment_submitted,
                onChanged: (bool? value){
                  setState(() {
                    academics_assignment_submitted = value;
                  });
                },
              )
            ]
          ),
        ]
      )
    );
  }
}
