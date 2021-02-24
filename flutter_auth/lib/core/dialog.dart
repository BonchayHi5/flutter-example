import 'package:flutter/material.dart';

Future<void> dialog(BuildContext context,String title, String alertText) async {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(alertText),
        actions: [
          FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}
