import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:thesisapp/models/communication_handler.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:collection/collection.dart';
import 'package:simple_logger/simple_logger.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:thesisapp/screens/performance_screen.dart';
import 'package:thesisapp/utilities/constants.dart';
import 'package:thesisapp/widgets/ble_tile.dart';
import 'package:thesisapp/widgets/pb_elevated_button.dart';
import 'package:thesisapp/widgets/pb_icon_button.dart';

class SensorScreen extends StatefulWidget {
  static const String id = 'ble_screen';

  @override
  State<SensorScreen> createState() => _SensorScreenState();
}

class _SensorScreenState extends State<SensorScreen> {
  SimpleLogger logger = SimpleLogger();
  CommunicationHandler? communicationHandler;
  bool isScanStarted = false;
  bool isConnected = false;
  List<DiscoveredDevice> discoveredDevices = List<DiscoveredDevice>.empty(growable: true);
  String connectedDeviceDetails = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: PBIconButton(
            icon: Symbols.keyboard_arrow_left_rounded,
            size: 32.0,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Performance collection',
            style: kTitleStyle,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: discoveredDevices.length,
                    itemBuilder: (BuildContext context, int index) {
                      return BLETile(
                        bleTitle: discoveredDevices[index].name,
                        onPress: () {
                          DiscoveredDevice selectedDevice = discoveredDevices[index];
                          stopScan();
                          discoveredDevices.clear();
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return PerformanceScreen(device: selectedDevice);
                          }));
                        },
                        isConnected: DeviceConnectionState.disconnecting,
                        leading: const Icon(
                          Symbols.bluetooth,
                          size: 24.0,
                        ),
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: isScanStarted
                    ? SpinKitWaveSpinner(
                        trackColor: Theme.of(context).colorScheme.secondaryContainer,
                        waveColor: Theme.of(context).colorScheme.primary,
                        curve: Curves.fastOutSlowIn,
                        color: Theme.of(context).colorScheme.primary,
                        size: 120.0,
                        duration: Duration(milliseconds: 1400),
                        child: PBIconButton(
                            icon: Symbols.bluetooth_searching_rounded,
                            onPressed: () {
                              isScanStarted ? stopScan() : startScan();
                            },
                            size: 38.0),
                      )
                    : Padding(
                      padding: const EdgeInsets.only(bottom: 18.0),
                      child: PBIconButton(
                          icon: Symbols.bluetooth_rounded,
                          onPressed: () {
                            isScanStarted ? stopScan() : startScan();
                          },
                          size: 60.0),
                    ),
              ),
            ],
          ),
        ));
  }

  @override
  void initState() {
    checkPermissions();
    startScan();
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

    logger.info("PermissionStatus -- $statuses");
  }

  void startScan() {
    isConnected = false;
    communicationHandler ??= CommunicationHandler(context);
    communicationHandler?.startScan((scanDevice) {
      logger.info("Scan device: ${scanDevice.name}");
      if (discoveredDevices.firstWhereOrNull((val) => val.id == scanDevice.id) == null) {
        logger.info("Added new device to list: ${scanDevice.name}");
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
}
