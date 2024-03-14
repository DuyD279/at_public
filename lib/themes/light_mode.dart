import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightMode = ThemeData(
  appBarTheme: AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle.dark),
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    //background: Color.fromARGB(255, 255, 255, 237),
    background: Colors.white,
    primary: Colors.grey.shade200,
    secondary: Colors.grey.shade400,
    inversePrimary: Colors.black,
    outline: Colors.black,
    onBackground: Colors.black,
  ),
  textTheme: ThemeData.light().textTheme.apply(
        bodyColor: Colors.black,
        displayColor: Colors.black,
      ),
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  hoverColor: Colors.transparent,
);
