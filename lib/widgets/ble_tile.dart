import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:thesisapp/utilities/color_schemes.g.dart';

class BLETile extends StatelessWidget {
  final String bleTitle;
  final void Function() onPress;
  final DeviceConnectionState isConnected;
  final Widget leading;

  BLETile({required this.bleTitle, required this.onPress, required this.isConnected, required this.leading});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        title: Text(
          bleTitle,
          style: TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 20.0,
            color: getTextColor(context, isConnected),
          ),
        ),
        onTap: onPress,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        tileColor: getConnectionStateColor(context, isConnected),
        iconColor: getTextColor(context, isConnected),
        leading: leading,
      ),
    );
  }

  Color getConnectionStateColor(BuildContext context, DeviceConnectionState connectionState) {
    switch (connectionState) {
      case DeviceConnectionState.connected:
        return Theme.of(context).colorScheme.tertiary;
      case DeviceConnectionState.disconnected:
        return Theme.of(context).colorScheme.error;
      default:
        return Theme.of(context).colorScheme.secondaryContainer;
    }
  }

  Color getTextColor(BuildContext context, DeviceConnectionState connectionState) {
    switch (connectionState) {
      case DeviceConnectionState.connected:
        return Theme.of(context).colorScheme.onTertiary;
      case DeviceConnectionState.disconnected:
        return Theme.of(context).colorScheme.onError;
      default:
        return Theme.of(context).colorScheme.onSecondaryContainer;
    }
  }
}
