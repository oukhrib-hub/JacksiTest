import 'package:flutter/material.dart';

final ThemeData theme = ThemeData(
  primaryColor: const Color(0xFF3EB86F),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(fontFamily: "Montserrat-arabic"),
    bodyLarge: TextStyle(fontFamily: "Montserrat-arabic"),
    bodySmall: TextStyle(fontFamily: "Montserrat-arabic"),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey.shade300, width: 2)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFF3EB86F))),
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFFB8503E))),
    focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFFB8503E))),
  ),
  appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[50],
      elevation: 0,
      actionsIconTheme: IconThemeData(color: Colors.grey.shade900),
      iconTheme: IconThemeData(color: Colors.grey.shade900),
      titleTextStyle: TextStyle(
          color: Colors.grey.shade900,
          //fontWeight: FontWeight.bold,
          fontSize: 25,
          fontFamily: "Montserrat-arabic")),
);