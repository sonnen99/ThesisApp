import 'package:flutter/material.dart';

class PBElevatedButton extends StatelessWidget {

  final void Function()? onPressed;
  final Widget child;

  PBElevatedButton({required this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 2.0,
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}





