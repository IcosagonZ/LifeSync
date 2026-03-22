import 'package:flutter/material.dart';

// Move to seperate file
SnackBar notify_snackbar(String message)
{
  return SnackBar(
    content: Text(
      message,
      style: TextStyle(
        color:Color.fromRGBO(250, 250, 250, 1)
      ),
    ),
    behavior: SnackBarBehavior.floating,
    showCloseIcon: true,
    backgroundColor: Color.fromRGBO(33, 33, 33, 1),
    closeIconColor: Color.fromRGBO(250, 250, 250, 1),
  );
}
