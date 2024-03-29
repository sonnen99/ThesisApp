import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'raw_data.dart';

class RawDataHandler extends ChangeNotifier {
  List<RawData> _rawData = [];
  List<List<Map<String, Object>>> _markAreas = [];
  bool _lastTimestamp = true;

  int get dataCount {
    return _rawData.length;
  }

  int get areaCount {
    return _markAreas.length;
  }

  void addData(int force, int time) {
    _rawData.add(RawData(force: force, timestamp: time));
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

  void deleteAll() {
    _markAreas.clear();
    _rawData.clear();
    _lastTimestamp = true;
    notifyListeners();
  }
}
