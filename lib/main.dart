
import 'package:contact_list_sqflite/theme/theme_constants.dart';
import 'package:contact_list_sqflite/utils/widget_functions.dart';
import 'package:contact_list_sqflite/views/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigationService.navigatorKey,
      theme: lightTheme,
      home: const Home(),
    ),
  );
}
