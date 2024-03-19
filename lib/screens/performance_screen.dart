import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:thesisapp/models/communication_handler.dart';
import 'package:permission_handler/permission_handler.dart';

class PerformanceScreen2 extends StatefulWidget {


  @override
  State<PerformanceScreen2> createState() => _PerformanceScreen2State();
}

class _PerformanceScreen2State extends State<PerformanceScreen2> {
  CommunicationHandler? communicationHandler;
  bool isScanStarted = false;
  bool isConnected = false;
  List<DiscoveredDevice> discoveredDevices = List<DiscoveredDevice>.empty(growable: true);
  String connectedDeviceDetails = "";

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
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 4.0,
                  ),
                  onPressed: () {
                    isScanStarted ? stopScan() : startScan();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Symbols.bluetooth,
                        size: 32.0,
                      ),
                      Text(
                        isScanStarted ? 'Stop scanning' : 'Start scaning for sensors',
                        style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20.0),
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(connectedDeviceDetails),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    checkPermissions();
    super.initState();
  }

  void checkPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.bluetooth,
      Permission.bluetoothConnect,
      Permission.bluetoothScan,
      Permission.location,
      Permission.bluetoothAdvertise,
    ].request();
  }

  void startScan() {
    communicationHandler ??= CommunicationHandler();
    communicationHandler?.startScan((scanDevice) {
      if (discoveredDevices.firstWhere((val) => val.id == scanDevice.id) == null) {
        setState(() {
          discoveredDevices.add(scanDevice);
        });
      }
    });

    setState(() {
      isScanStarted = true;
      discoveredDevices.clear();
    });
  }

  Future<void> stopScan() async {
    await communicationHandler?.stopScan();
    setState(() {
      isScanStarted = false;
    });
  }

  Future<void> connectToDevice(DiscoveredDevice selectedDevice) async {
    await stopScan();
    communicationHandler?.connectToDevice(selectedDevice, (isConnected) {
      this.isConnected = isConnected;
      if (isConnected) {
        connectedDeviceDetails = "Connected Device Details\n\n$selectedDevice";
      } else {
        connectedDeviceDetails = "";
      }
      setState(() {
        connectedDeviceDetails;
      });
    });
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
