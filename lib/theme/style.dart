//https://flutter.dev/docs/cookbook/design/themes
//https://api.flutter.dev/flutter/material/TextTheme-class.html

import 'package:flutter/material.dart';


appTheme() {
  return ThemeData(
    // Define the default brightness and colors.
    brightness: Brightness.light,
    primaryColor: Colors.white,
    accentColor: Colors.white,

    // Define the default font family.
    fontFamily: 'RobotoMono',

    // Define the default TextTheme. Use this to specify the default
    // text styling for headlines, titles, bodies of text, and more.
    textTheme: TextTheme(
      title: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
      headline: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
//      body1: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
    ),
  );

}