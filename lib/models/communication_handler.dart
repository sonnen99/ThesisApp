import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:provider/provider.dart';
import 'package:thesisapp/models/connection_handler.dart';
import 'package:simple_logger/simple_logger.dart';
import 'package:sprintf/sprintf.dart';
import 'package:thesisapp/models/raw_data.dart';
import 'package:thesisapp/models/raw_data_handler.dart';

class CommunicationHandler extends ChangeNotifier {
  SimpleLogger logger = SimpleLogger();
  late final BLEConnection bleConnectionHandler;

  static const String uuidFormat = "0000%s-0000-1000-8000-00805f9b34fb";

  static final Uuid deviceInformationService = Platform.isAndroid ? Uuid.parse(sprintf(uuidFormat, ["180a"])) : Uuid.parse("180a");
  static final Uuid deviceModelNumberCharacteristic = Platform.isAndroid ? Uuid.parse(sprintf(uuidFormat, ["2a24"])) : Uuid.parse("2a24");

  static final Uuid temperatureService = Platform.isAndroid ? Uuid.parse("49535343-fe7d-4ae5-8fa9-9fafd205e455") : Uuid.parse("0072");
  static final Uuid temperatureMeasurement = Platform.isAndroid ? Uuid.parse("49535343-1e4d-4bd9-ba61-23c647249616") : Uuid.parse("0073");

  String deviceId = "";
  int firstTimeStamp = 0;
  int lastTimestamp = 0;
  int newTimestamp = 0;
  int nullTime = 0;
  int start = 0;
  int end = 0;
  bool area = false;
  final BuildContext context;

  CommunicationHandler(this.context) {
    bleConnectionHandler = BLEConnection();
  }

  void startScan(Function(DiscoveredDevice) scanDevice) {
    bleConnectionHandler.startBluetoothScan((discoveredDevice) => {scanDevice(discoveredDevice)});
  }

  Future<void> stopScan() async {
    await bleConnectionHandler.stopScan();
  }

  void connectToDevice(DiscoveredDevice discoveredDevice, Function(bool, DeviceConnectionState) connectionStatus) {
    bleConnectionHandler.connectToDevice(discoveredDevice, (isConnected, status) {
      deviceId = discoveredDevice.id;
      connectionStatus(isConnected, status);
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

  void receivedCharacteristicValue({required QualifiedCharacteristic characteristic, required List<int> values}) {
    if (characteristic.characteristicId == deviceModelNumberCharacteristic) {
      subscribeToMeasurement(temperatureService, temperatureMeasurement);
    } else if (characteristic.characteristicId == temperatureMeasurement) {
      List<String> timestamps = [];
      if (values.isNotEmpty) {
        timestamps = convertBytesToTimestamps(values);
        convertRawDataToNewtons(timestamps);
      }
    }
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

  List<String> convertBytesToTimestamps(List<int> data) {
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

  void convertRawDataToNewtons(List<String> timestamps) {                                             // triggered when data is available
    List<RawData> rawData = [];
    for (String timestamp in timestamps) {                                                            // for every timestamp in the new data
      String force = '';
      String time = '';
      String currentNumber = '';
      var timestampList = [];
      if (timestamp.contains('at') && !timestamp[0].contains(' ') && !timestamp[0].contains('a')) {   // filter incomplete data
        timestampList = timestamp.split('');
      }
      for (int i = 0; i < timestampList.length; i++) {                                                // move through every character of one timestamp
        if (timestampList[i] == ' ') {
          force = currentNumber;                                                                      // save the force of the timestamp
          currentNumber = '';
          i += 3;
        } else if (timestampList[i] == 'm') {
          time = currentNumber;                                                                       // save the time of the timestamp
          if (Provider.of<RawDataHandler>(context, listen: false).isFirst()) {
            firstTimeStamp = int.parse(time);                                                         // record first timestamp for 0 adaption
            Provider.of<RawDataHandler>(context, listen: false).notFirst();
          }
          double dForce = double.parse((double.parse(force)).toStringAsFixed(4));                     //TODO might change constant 0.002826
          rawData.add(RawData(force: dForce, timestamp: int.parse(time) - firstTimeStamp)); // add force and time to list, next item
          break;
        } else {
          currentNumber += timestampList[i];                                                          // add character to the current force or time
        }
      }
    }

    if (lastTimestamp == 0) {
      lastTimestamp = rawData.last.timestamp;                                                         // record last timestamp of first data block
    } else {
      newTimestamp = rawData.first.timestamp;
      nullTime = newTimestamp - lastTimestamp;
      if (nullTime == 2) {                                                                            // when gap between timestamps is 1
        rawData.insert(0, RawData(force: rawData.first.force, timestamp: 1 + lastTimestamp));         // fill incomplete data points
      } else if (nullTime > 2) {                                                                      // fill data with 0 when sensor is above the water
        for (int i = 1; i < nullTime; i++) {
          rawData.insert(i - 1, RawData(force: 0, timestamp: i + lastTimestamp));
        }
      }
      lastTimestamp = rawData.last.timestamp;                                                         // new last timestamp of the current data block
    }

    for (RawData data in rawData) {
      Provider.of<RawDataHandler>(context, listen: false).addData(data.force, data.timestamp);        // add all new data points to the graph
    }

  }
}
