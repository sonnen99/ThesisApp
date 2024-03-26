import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:thesisapp/models/ble_data.dart';
import 'package:simple_logger/simple_logger.dart';
import 'package:sprintf/sprintf.dart';

class CommunicationHandler {
  SimpleLogger logger = SimpleLogger();
  late final BLEData bleConnectionHandler;

  static const String uuidFormat = "0000%s-0000-1000-8000-00805f9b34fb";

  static final Uuid deviceInformationService = Platform.isAndroid ? Uuid.parse(sprintf(uuidFormat, ["180a"])) : Uuid.parse("180a");
  static final Uuid deviceModelNumberCharacteristic = Platform.isAndroid ? Uuid.parse(sprintf(uuidFormat, ["2a24"])) : Uuid.parse("2a24");

  static final Uuid temperatureService = Platform.isAndroid ? Uuid.parse("49535343-fe7d-4ae5-8fa9-9fafd205e455") : Uuid.parse("0072");
  static final Uuid temperatureMeasurement = Platform.isAndroid ? Uuid.parse("49535343-1e4d-4bd9-ba61-23c647249616") : Uuid.parse("0073");

  String deviceId = "";

  CommunicationHandler() {
    bleConnectionHandler = BLEData();
  }

  void startScan(Function(DiscoveredDevice) scanDevice) {
    bleConnectionHandler.startBluetoothScan((discoveredDevice) => {scanDevice(discoveredDevice)});
  }

  Future<void> stopScan() async {
    await bleConnectionHandler.stopScan();
  }

  void connectToDevice(DiscoveredDevice discoveredDevice, Function(bool) connectionStatus) {
    bleConnectionHandler.connectToDevice(discoveredDevice, (isConnected) {
      deviceId = discoveredDevice.id;
      connectionStatus(isConnected);
      if (isConnected) {
        readDeviceInformation(deviceInformationService, deviceModelNumberCharacteristic);
      }
    });
  }

  Future<void> readDeviceInformation(Uuid service, Uuid characteristicToRead) async {
    final characteristic = QualifiedCharacteristic(serviceId: service, characteristicId: characteristicToRead, deviceId: deviceId);
    final response = await bleConnectionHandler.flutterReactiveBle.readCharacteristic(characteristic);
    receivedCharacteristicValue(characteristic: characteristic, values: response);
  }

  Future<void> subscribeToMeasurement(Uuid service, Uuid characteristicToNotify) async {
    final characteristic = QualifiedCharacteristic(serviceId: service, characteristicId: characteristicToNotify, deviceId: deviceId);
    bleConnectionHandler.flutterReactiveBle.subscribeToCharacteristic(characteristic).listen((data) {
      if (data.isNotEmpty) {
        receivedCharacteristicValue(characteristic: characteristic, values: data);
      }
    }, onError: (dynamic error) {
      logger.info('Error with read measurement : $error');
    });
  }

  void receivedCharacteristicValue({required QualifiedCharacteristic characteristic, required List<int> values}) {
    if (characteristic.characteristicId == deviceModelNumberCharacteristic) {
      String value = utf8.decode(values);
      logger.info('Device model: $value');
      subscribeToMeasurement(temperatureService, temperatureMeasurement);
    } else if (characteristic.characteristicId == temperatureMeasurement) {
      List<String> timestamps = [];
      List<>
      if (values.isNotEmpty) {
        timestamps = convertDataToTimestamps(values);
        logger.info('Data: $timestamps');

      }
      //TODO parse data
      
    }
  }

  List<String> convertDataToTimestamps(List<int> data) {
    List<String> timestamps = [];
    String currentTimestamp = '';

    for (int byte in data) {
      if (byte == 10 || byte == 13) {
        if (currentTimestamp.isNotEmpty) {
          timestamps.add(currentTimestamp.trim());
          currentTimestamp = '';
        }
      } else {
        currentTimestamp += String.fromCharCode(byte);
      }
    }
    return timestamps;
  }

}
