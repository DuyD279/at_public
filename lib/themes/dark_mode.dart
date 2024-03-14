import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData darkMode = ThemeData(
  appBarTheme: AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle.light),
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: Colors.black,
    primary: Colors.black,
    secondary: Colors.grey.shade700,
    inversePrimary: Colors.grey.shade200,
    onBackground: Colors.white,
  ),
  textTheme: ThemeData.light().textTheme.apply(
        bodyColor: Colors.white,
        displayColor: Colors.white,
      ),
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,
  hoverColor: Colors.transparent,
);
