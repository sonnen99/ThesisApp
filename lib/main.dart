import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:thesisapp/color_schemes.g.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentIndex = 0;
  final iconList = <IconData>[
    Icons.home,
    Icons.brightness_4,
    Icons.brightness_6,
    Icons.brightness_7,
  ];


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
      ),
      themeMode: ThemeMode.dark,
      home: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          shape: CircleBorder(),
          child: Icon(
            CupertinoIcons.chevron_up,
            size: 32.0,
          ),
        ),
        extendBody: true,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          // child: Image.network(
          //   "https://images.pexels.com/photos/1671325/pexels-photo-1671325.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
          //   fit: BoxFit.fitHeight,
          // ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
              child: AnimatedBottomNavigationBar(
                icons: iconList,
                activeIndex: currentIndex,
                onTap: (value) {
                  setState(() {
                    currentIndex = value;
                  });
                },
                gapLocation: GapLocation.center,
                notchSmoothness: NotchSmoothness.softEdge,
                backgroundColor: darkColorScheme.surfaceVariant,
                activeColor: darkColorScheme.tertiary,
                inactiveColor: darkColorScheme.onSurfaceVariant,
                elevation: 4.0,
                splashColor: darkColorScheme.tertiary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//CrystalNavigationBar()
// currentIndex: _currentIndex,
// indicatorColor: Colors.green,
// unselectedItemColor: Colors.white70,
// backgroundColor: Colors.black.withOpacity(0.1),
// outlineBorderColor: Colors.white.withOpacity(0.1),
// onTap: (value) {
// setState(() {
// _currentIndex = value;
// });
// },
// items: [
// /// Home
// CrystalNavigationBarItem(
// icon: Icons.home,
// unselectedIcon: CupertinoIcons.home,
// selectedColor: Colors.white,
// ),
//
// /// Favourite
// CrystalNavigationBarItem(
// icon: CupertinoIcons.heart_fill,
// unselectedIcon: CupertinoIcons.heart,
// selectedColor: Colors.red,
// ),
//
// /// Add
// CrystalNavigationBarItem(
// icon: CupertinoIcons.plus_app_fill,
// unselectedIcon: CupertinoIcons.plus_app,
// selectedColor: Colors.white,
// ),
//
// /// Search
// CrystalNavigationBarItem(
// icon: CupertinoIcons.search_circle_fill,
// unselectedIcon: CupertinoIcons.search_circle,
// selectedColor: Colors.white),
//
// /// Profile
// CrystalNavigationBarItem(
// icon: Icons.supervised_user_circle,
// unselectedIcon: Icons.supervised_user_circle_outlined,
// selectedColor: Colors.white,
// ),
// ],
// ),
