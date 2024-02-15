import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


class HomeScreen extends StatelessWidget {
  static const String id = 'home_screen';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Image.network(
        "https://images.pexels.com/photos/1671325/pexels-photo-1671325.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
        fit: BoxFit.fitHeight,
      ),
    );
  }
}
