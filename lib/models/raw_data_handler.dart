import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'raw_data.dart';

class RawDataHandler extends ChangeNotifier {
  List<RawData> _rawData = [];
  List<List<Map<String, Object>>> _markAreas = [];
  bool _lastTimestamp = true;
  ThemeMode _mode;
  ThemeMode get mode => _mode;
  RawDataHandler({ThemeMode mode = ThemeMode.dark}) : _mode = mode;

  void toggleMode() {
    _mode = _mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }


  int get dataCount {
    return _rawData.length;
  }

  int get areaCount {
    return _markAreas.length;
  }

  void addData(double force, int time) {                          // function is triggered for every data point available
    _rawData.add(RawData(force: force, timestamp: time));      // add data to the list
    bool start = true;
    bool first = true;
    int startValue = 0;
    int endValue = 0;
    String hello = 'Hello';
    _markAreas.clear();
    for (var rawData in _rawData) {
      if (rawData.force == 0 && start) {
        if (first) {
          endValue = rawData.timestamp;
          int difference = (endValue - startValue) * 10;
          _markAreas.add([
            {'name': '$difference sec', 'xAxis': startValue},
            {'xAxis': endValue}
          ]);
          first = false;
          startValue = rawData.timestamp;
        } else {
          startValue = rawData.timestamp;
          int difference = (startValue - endValue) * 10;
          _markAreas.add([
            {'name': '$difference sec', 'xAxis': startValue},
            {'xAxis': endValue}
          ]);
        }
        start = false;
      }
      if (rawData.force > 0 && !start) {
        endValue = rawData.timestamp;
        int difference = (endValue - startValue) * 10;
        _markAreas.add([
          {'name': '$difference sec', 'xAxis': startValue},
          {'xAxis': endValue}
        ]);
        start = true;
      }
    }
    startValue = endValue;
    endValue = _rawData.last.timestamp;
    int difference = (endValue - startValue) * 10;
    _markAreas.add([
      {'name': '$difference sec', 'xAxis': startValue},
      {'xAxis': endValue}
    ]);
    notifyListeners();
  }

  void addArea(int start, int end) {
    int difference = start - end;
    _markAreas.add([{'name': '$difference sec' , 'xAxis': start}, {'xAxis': end}]);
    notifyListeners();
  }

  RawData getData(int index) {
    return _rawData[index];
  }

  bool isFirst() {
    return _lastTimestamp;
  }

  void notFirst() {
    _lastTimestamp = false;
  }

  UnmodifiableListView<RawData> get rawData {
    return UnmodifiableListView(_rawData);
  }

  UnmodifiableListView<List<Map<String, Object>>> get markAreas {
    return UnmodifiableListView(_markAreas);
  }

  Map<String, Map<String, dynamic>> convertForFirestore (String date) {
    Map<String, dynamic> firestoreData = {};
    Map<String, Map<String, dynamic>> mapForFirestore = {};
    for (var element in _rawData) {
      firestoreData[element.timestamp.toString()] = element.force;
    }
    mapForFirestore[date] = firestoreData;
    return mapForFirestore;
  }

  void deleteAll() {
    _markAreas.clear();
    _rawData.clear();
    _lastTimestamp = true;
    notifyListeners();
  }
}
