import 'package:flutter/material.dart';

Future<bool?> dialog_confirmation_show(BuildContext context, String title, String description)
{
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
     title: Text(title),
     content: Text(description),
     actions: <Widget>[
       TextButton(
         onPressed: (){
           Navigator.of(context).pop(true);
        },
        child: Text("Yes")
       ),
       TextButton(
         onPressed: (){
           Navigator.of(context).pop(false);
         },
         child: Text("No")
       )
     ]
    ),
  );
}
