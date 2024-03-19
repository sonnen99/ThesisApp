import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:thesisapp/models/communication_handler.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:collection/collection.dart';
import 'package:simple_logger/simple_logger.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:thesisapp/widgets/ble_tile.dart';

class PerformanceScreen extends StatefulWidget {
  static const String id = 'performance_screen';

  @override
  State<PerformanceScreen> createState() => _PerformanceScreenState();
}

class _PerformanceScreenState extends State<PerformanceScreen> {
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
            children: [
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 4.0,
                  ),
                  onPressed: () {
                    isScanStarted ? stopScan() : startScan();
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Symbols.bluetooth,
                        size: 24.0,
                      ),
                      Text(
                        isScanStarted ? "Stop Scan" : "Start Scan",
                        style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20.0),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 400,
                child: ListView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: discoveredDevices.length,
                    itemBuilder: (BuildContext context, int index) {
                      return BLETile(
                        bleTitle: discoveredDevices[index].name,
                        onPress: () {
                          DiscoveredDevice selectedDevice = discoveredDevices[index];
                          connectToDevice(selectedDevice);
                        },
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(connectedDeviceDetails),
              )
            ],
          ),
        ));
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

    logger.info("PermissionStatus -- $statuses");
  }

  void startScan() {
    communicationHandler ??= CommunicationHandler();
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

  Future<void> connectToDevice(DiscoveredDevice selectedDevice) async {
    await stopScan();
    communicationHandler?.connectToDevice(selectedDevice, (isConnected) {
      this.isConnected = isConnected;
      if (isConnected) {
        connectedDeviceDetails = "Connected Device Details\n\n${selectedDevice}";
      } else {
        connectedDeviceDetails = "";
      }
      setState(() {
        connectedDeviceDetails;
      });
    });
  }


}
