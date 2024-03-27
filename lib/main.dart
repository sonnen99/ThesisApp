import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thesisapp/models/communication_handler.dart';
import 'package:thesisapp/models/raw_data.dart';
import 'package:thesisapp/models/raw_data_handler.dart';
import 'package:thesisapp/screens/sensor_screen.dart';
import 'package:thesisapp/screens/performance_screen.dart';
import 'package:thesisapp/screens/profile_screen.dart';
import 'package:thesisapp/screens/settings_screen.dart';
import 'package:thesisapp/screens/start_screen.dart';
import 'package:thesisapp/screens/teams_screen.dart';
import 'package:thesisapp/utilities/theme_data.dart';
import 'screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'utilities/firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RawDataHandler(),
      child: MaterialApp(
        theme: MyTheme.lightThemeData(context),
        darkTheme: MyTheme.darkThemeData(),
        themeMode: ThemeMode.dark,
        initialRoute: StartScreen.id,
        routes: {
          StartScreen.id: (context) => StartScreen(),
          HomeScreen.id: (context) => HomeScreen(),
          TeamsScreen.id: (context) => TeamsScreen(),
          SettingsScreen.id: (context) => SettingsScreen(),
          ProfileScreen.id: (context) => ProfileScreen(),
          SensorScreen.id: (context) => SensorScreen(),
        },
      ),
    );
  }
}
