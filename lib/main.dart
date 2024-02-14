import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'dart:ui';

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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return MaterialApp(
        home: Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(onPressed: () {}, shape: CircleBorder(),),
      extendBody: true,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Image.network(
          "https://images.pexels.com/photos/1671325/pexels-photo-1671325.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
          fit: BoxFit.fitHeight,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 20.0,
        shape: CircularNotchedRectangle(),
        color: Colors.transparent,
        padding: EdgeInsets.zero,
        elevation: 0,
        height: 105,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
              child: Container(
                padding: EdgeInsets.only(bottom: 5, top: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white24),
                  color: Colors.black.withOpacity(0.1),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Body(
                    items: [CrystalNavigationBarItem(
                      icon: Icons.home,
                      unselectedIcon: CupertinoIcons.home,
                      selectedColor: Colors.white,
                    ),CrystalNavigationBarItem(
                      icon: Icons.home,
                      unselectedIcon: CupertinoIcons.home,
                      selectedColor: Colors.white,
                    ),CrystalNavigationBarItem(
                      icon: Icons.home,
                      unselectedIcon: CupertinoIcons.home,
                      selectedColor: Colors.white,
                    ),CrystalNavigationBarItem(
                      icon: Icons.home,
                      unselectedIcon: CupertinoIcons.home,
                      selectedColor: Colors.white,
                    ),],
                    currentIndex: currentIndex,
                    curve: Curves.easeOutQuint,
                    duration: Duration(milliseconds: 500),
                    onTap: (value) {
                      setState(() {
                        currentIndex = value;
                      });
                    },
                    itemPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    indicatorColor: Colors.green,
                    selectedItemColor: Colors.white, theme: theme, unselectedItemColor: Colors.white70,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ));
  }
}

// CrystalNavigationBar(
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
