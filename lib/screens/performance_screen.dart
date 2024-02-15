import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class PerformanceScreen extends StatelessWidget {
  static const String id = 'performance_screen';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 16.0,
              ),
              child: Hero(
                tag: 'performance',
                child: MaterialButton(
                  shape: CircleBorder(),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Symbols.keyboard_arrow_left_rounded,
                    color: Theme.of(context).colorScheme.onPrimary,
                    size: 48.0,
                  ),
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
//
// GestureDetector(
// child: CircleAvatar(
// child: Icon(
// Symbols.keyboard_arrow_left_rounded,size: 64.0,
// ),
// radius: 32.0,
// ),
// onTap: () {
// Navigator.pop(context);
// },
// )
