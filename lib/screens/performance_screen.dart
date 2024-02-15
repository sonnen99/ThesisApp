import 'package:flutter/material.dart';
import 'package:thesisapp/utilities/color_schemes.g.dart';

class PerformanceScreen extends StatelessWidget {
  static const String id = 'performance_screen';

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'performance',
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Container(
          color: lightColorScheme.primary,
        ),
        // child: Image.network(
        //   "https://images.pexels.com/photos/1671325/pexels-photo-1671325.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
        //   fit: BoxFit.fitHeight,
        // ),
      ),
    );
  }
}
