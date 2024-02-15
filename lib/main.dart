import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:thesisapp/screens/performance_screen.dart';
import 'package:thesisapp/screens/profile_screen.dart';
import 'package:thesisapp/screens/settings_screen.dart';
import 'package:thesisapp/screens/start_screen.dart';
import 'package:thesisapp/screens/teams_screen.dart';
import 'package:thesisapp/utilities/theme_data.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: MyTheme.lightThemeData(context),
      darkTheme: MyTheme.darkThemeData(),
      themeMode: ThemeMode.dark,
      initialRoute: StartScreen.id,
      routes: {
        StartScreen.id: (context) => StartScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        PerformanceScreen.id: (context) => PerformanceScreen(),
        TeamsScreen.id: (context) => TeamsScreen(),
        SettingsScreen.id: (context) => SettingsScreen(),
        ProfileScreen.id: (context) => ProfileScreen(),
      },
    );
  }
}
