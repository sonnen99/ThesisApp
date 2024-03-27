import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'raw_data.dart';

class RawDataHandler extends ChangeNotifier {

  List<RawData> _rawData = [];

  int get taskCount {
    return _rawData.length;
  }

  void addData(int force, int time) {
    _rawData.add(RawData(force: force, timestamp: time));
    notifyListeners();
  }

  RawData getData(int index) {
    return _rawData[index];
  }

  UnmodifiableListView<RawData> get rawData {
    return UnmodifiableListView(_rawData);
  }

}