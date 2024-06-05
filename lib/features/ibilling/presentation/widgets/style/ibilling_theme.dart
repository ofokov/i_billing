import 'package:flutter/material.dart';

class IBillingTheme {
  static TextTheme textTheme = const TextTheme(
    titleMedium: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: Colors.white,
      fontFamily: "Ubuntu",
    ),
    headlineMedium: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      color: Colors.white,
      fontFamily: "Ubuntu",
    ),
    headlineSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: Colors.white,
        fontFamily: "Ubuntu",
        height: 2),
    bodyLarge: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      color: Colors.white,
      fontFamily: "Ubuntu",
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Colors.white,
      fontFamily: "Ubuntu",
    ),
    labelMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Color(0xFF999999),
      fontFamily: "Ubuntu",
    ),
  );

  static ThemeData theme() {
    return ThemeData(
      primaryColor: const Color(0xFF2A2A2D),
      secondaryHeaderColor: Colors.black,
      textTheme: textTheme,
      textSelectionTheme: const TextSelectionThemeData(
        selectionColor: Color(0xFF00A795),
      ),
    );
  }
}
