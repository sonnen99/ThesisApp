import 'package:flutter/material.dart';
import 'package:thesisapp/utilities/constants.dart';
import 'color_schemes.g.dart';

class MyTheme {
  static ThemeData lightThemeData(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: lightColorScheme,
      iconTheme: kIconData,
      fontFamily: 'Inter',
      appBarTheme: const AppBarTheme(elevation: 5.0),
    );
  }

  static ThemeData darkThemeData() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: darkColorScheme,
      iconTheme: kIconData,
      fontFamily: 'Inter',
      appBarTheme: const AppBarTheme(elevation: 5.0),
    );
  }
}
