
import 'package:flutter/material.dart';

final kThemePrimary = lightTheme.colorScheme.primary;

ThemeData lightTheme = ThemeData(
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xff0277bd),
    onPrimary: Colors.white,
    secondary: Color(0xff0277bd),
    onSecondary: Colors.white,
    background: Colors.white,
    onBackground: Colors.white,
    surface: Colors.green,
    onSurface: Colors.black,
    error: Colors.redAccent,
    onError: Colors.redAccent,
  ),
  scaffoldBackgroundColor: Colors.white,
  
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark
);