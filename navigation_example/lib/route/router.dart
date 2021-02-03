import 'package:flutter/material.dart';
import 'package:navigation_example/constant/constant.dart';
import 'package:navigation_example/main.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SecondScreenView:
      final args = settings.arguments;
      return MaterialPageRoute(
        builder: (context) => SecondPage(
          argument: args,
        ),
      );
      break;

    default:
      return MaterialPageRoute(builder: (context) => MyHomePage());
  }
}
