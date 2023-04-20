

import 'package:flutter/material.dart';

class InputDecorations{

  static InputDecoration textFormFieldDecoration({ required String hintText }){
    return InputDecoration(
      hintText: hintText,
      labelText: hintText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular( 15 )
      )
    );
  }

}