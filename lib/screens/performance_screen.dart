import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

class PerformanceScreen extends StatefulWidget {
  static const String id = 'performance_screen';

  @override
  State<PerformanceScreen> createState() => _PerformanceScreenState();
}

class _PerformanceScreenState extends State<PerformanceScreen> {
  final reactiveBLE = FlutterReactiveBle();

  @override
  Widget build(BuildContext context) {


    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Hero(
            tag: 'performance',
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                shape: CircleBorder(),
                onPressed: () {
                  Navigator.pop(context);
                },
                padding: EdgeInsets.all(4.0),
                child: Icon(
                  Symbols.keyboard_arrow_left_rounded,
                  color: Theme.of(context).colorScheme.onPrimary,
                  size: 32.0,
                ),
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          title: Text(
            'Performance collection',
            style: TextStyle(
              fontWeight: FontWeight.w100,
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 16.0,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 4.0,
                  ),
                  onPressed: () {

                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Symbols.bluetooth,
                        size: 32.0,
                      ),
                      Text(
                        'Scan for sensors',
                        style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
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
