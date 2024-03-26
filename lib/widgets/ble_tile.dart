import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class BLETile extends StatelessWidget {
  final String bleTitle;
  final void Function() onPress;

  BLETile({required this.bleTitle, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        bleTitle,
        style: TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: 20.0,
          color: Theme.of(context).colorScheme.onSecondaryContainer,
        ),
      ),
      onTap: onPress,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      tileColor: Theme.of(context).colorScheme.secondaryContainer,
      iconColor: Theme.of(context).colorScheme.onSecondaryContainer,
      leading: const Icon(
        Symbols.bluetooth,
        size: 24.0,
      ),
    );
  }
}
