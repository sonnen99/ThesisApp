import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'dart:async';
import 'package:simple_logger/simple_logger.dart';

class BLEConnection {
  SimpleLogger logger = SimpleLogger();

  final flutterReactiveBle = FlutterReactiveBle();
  StreamSubscription? streamSubscription;
  StreamSubscription<ConnectionStateUpdate>? connection;


  void startBluetoothScan(Function(DiscoveredDevice) discoveredDevice) async {
    if (flutterReactiveBle.status == BleStatus.ready) {
      logger.info("Start ble discovery");
      streamSubscription = flutterReactiveBle.scanForDevices(withServices: []).listen((device) async {
        if (device.name.isNotEmpty) discoveredDevice(device);
      }, onError: (Object e) => logger.info('Device scan fails with error: $e'));
    } else {
      logger.info("Device is not ready for communication");
      Future.delayed(const Duration(seconds: 2), () {
        startBluetoothScan(discoveredDevice);
      });
    }
  }

  Future<void> closeConnection() async {
    logger.info("Close Connection");
    await streamSubscription?.cancel();
    await connection?.cancel();
    streamSubscription = null;
  }

  Future<void> stopScan() async {
    logger.info("Stop ble discovery");
    await streamSubscription?.cancel();
    streamSubscription = null;
  }

  void connectToDevice(DiscoveredDevice discoveredDevice, Function(bool, DeviceConnectionState) connectionStatus) async {
    connection = flutterReactiveBle.connectToDevice(id: discoveredDevice.id).listen((connectionState) {
      logger.info("ConnectionState for device ${discoveredDevice.name} : ${connectionState.connectionState}");
      if (connectionState.connectionState == DeviceConnectionState.connected) {
        connectionStatus(true, connectionState.connectionState);
      } else if (connectionState.connectionState == DeviceConnectionState.disconnected) {
        connectionStatus(false, connectionState.connectionState);
        Future.delayed(const Duration(seconds: 2), () {
          connectToDevice(discoveredDevice, connectionStatus);
        });
      }
    }, onError: (Object error) {
      logger.info("Connecting to device resulted in error $error");
    });
  }

}
