import 'package:flutter/material.dart';

class AppTheme with ChangeNotifier{
  bool isDark = false;

  void changeMode(){
    isDark = !isDark;
    print(isDark);
    notifyListeners();
  }
  
  static final ThemeData lightTheme = ThemeData.light();
  static final ThemeData darkTheme = ThemeData.dark();
}