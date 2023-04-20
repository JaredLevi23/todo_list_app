
import 'package:flutter/material.dart';

class TodoListAppTheme{
  
  static ThemeData getTheme () {
    return ThemeData.light().copyWith(
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black
      )
    );
  }
}