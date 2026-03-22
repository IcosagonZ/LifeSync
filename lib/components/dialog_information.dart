import 'package:flutter/material.dart';

Future<void> dialog_information_show(BuildContext context, String title, String description)
{
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(title),
      content: Text(description),
      actions: <Widget>[
        TextButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          child: Text("Close")
        ),
      ]
    ),
  );
}
