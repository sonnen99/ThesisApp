import 'package:flutter/material.dart';
import 'package:thesisapp/screens/home_screen.dart';
import 'package:thesisapp/screens/ble_screen.dart';
import 'package:thesisapp/screens/profile_screen.dart';
import 'package:thesisapp/screens/settings_screen.dart';
import 'package:thesisapp/screens/teams_screen.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:thesisapp/utilities/constants.dart';
import 'dart:ui';

class StartScreen extends StatefulWidget {
  static const String id = 'start_screen';

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  var currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              screenList[currentIndex],
              style: kTitleStyle,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).colorScheme.primary,
            heroTag: 'performance',
            onPressed: () {
              Navigator.pushNamed(context, BLEScreen.id);
            },
            shape: const CircleBorder(),
            child: Icon(
              Symbols.keyboard_arrow_up_rounded,
              size: 48.0,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          extendBody: true,
          body: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              children: <Widget>[
                HomeScreen(),
                TeamsScreen(),
                SettingsScreen(),
                ProfileScreen(),
              ]),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
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
                      _pageController.animateToPage(currentIndex,
                          duration: const Duration(milliseconds: 800),
                          curve: Curves.fastOutSlowIn);
                    });
                  },
                  gapLocation: GapLocation.center,
                  notchSmoothness: NotchSmoothness.softEdge,
                  backgroundColor: Theme.of(context)
                      .colorScheme
                      .surfaceVariant
                      .withOpacity(0.2),
                  activeColor: Theme.of(context).colorScheme.tertiary,
                  inactiveColor: Theme.of(context).colorScheme.onSurfaceVariant,
                  elevation: 4.0,
                  splashColor: Theme.of(context).colorScheme.tertiary,
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
