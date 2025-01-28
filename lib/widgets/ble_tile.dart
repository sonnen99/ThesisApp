import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

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
        title: Row(
          children: [
            Text(
              bleTitle.length > 9 ? bleTitle.substring(0, 10) : bleTitle,
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 20.0,
                color: getTextColor(context, isConnected),
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            Text(
              getConnectionText(isConnected),
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 20.0,
                color: getTextColor(context, isConnected),
              ),
            ),
          ],
        ),
        onTap: onPress,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        tileColor: getConnectionStateColor(context, isConnected),
        iconColor: getTextColor(context, isConnected),
        leading: leading,
      ),
    );
  }

  String getConnectionText(DeviceConnectionState connectionState) {
    switch (connectionState) {
      case DeviceConnectionState.connected:
        return 'Connected';
      case DeviceConnectionState.disconnected:
        return 'Disconnected';
      default:
        return 'Connecting';
    }
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
