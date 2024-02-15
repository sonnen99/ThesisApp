import 'package:flutter/material.dart';
import 'color_schemes.g.dart';

class MyTheme {
  static ThemeData lightThemeData(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: lightColorScheme,
      iconTheme: const IconThemeData(
        fill: 0,
        weight: 200,
        opticalSize: 48,
        grade: 200,
        size: 40,
      ),
      fontFamily: 'Inter',
      appBarTheme: const AppBarTheme(elevation: 5.0),
    );
  }

  static ThemeData darkThemeData() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: darkColorScheme,
      iconTheme: const IconThemeData(
        fill: 0,
        weight: 200,
        opticalSize: 48,
        grade: 2000,
        size: 40,
      ),
      fontFamily: 'Inter',
      appBarTheme: const AppBarTheme(elevation: 5.0),
    );
  }
}
