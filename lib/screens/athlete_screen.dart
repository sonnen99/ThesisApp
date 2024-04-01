import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:thesisapp/models/chart_handler.dart';
import 'package:thesisapp/models/raw_data.dart';
import 'package:thesisapp/utilities/firebase_tags.dart';

import '../models/raw_data_list.dart';
import '../utilities/constants.dart';
import '../widgets/pb_icon_button.dart';

final _firestore = FirebaseFirestore.instance;

class AthleteScreen extends StatefulWidget {
  final String athleteID;
  final String athleteName;

  const AthleteScreen({required this.athleteID, required this.athleteName});

  @override
  State<AthleteScreen> createState() => _AthleteScreenState();
}

class _AthleteScreenState extends State<AthleteScreen> {
  List<Map<String, dynamic>> performances = [];
  List<String> dates = [];
  int selectedPerformance = 0;

  @override
  void initState() {
    super.initState();
    getPerformanceData(widget.athleteID);
  }

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
          widget.athleteName,
          style: kTitleStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            buildChart(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PBIconButton(
                    icon: Symbols.keyboard_arrow_left_rounded,
                    onPressed: () {
                      setState(() {
                        if (selectedPerformance > 0) selectedPerformance--;
                      });
                    },
                    size: 48.0),
                dates.isNotEmpty
                    ? Text(dates[selectedPerformance])
                    : const SizedBox(
                        width: 1.0,
                      ),
                PBIconButton(
                    icon: Symbols.keyboard_arrow_right_rounded,
                    onPressed: () {
                      setState(() {
                        if (selectedPerformance < performances.length - 1) selectedPerformance++;
                      });
                    },
                    size: 48.0),
              ],
            ),
            // RealTimeGraph(stream: dataStream(),),
          ],
        ),
      ),
    );
  }

  void getPerformanceData(String id) {
    _firestore.collection(fbAthletes).doc(id).collection(fbPerformances).get().then((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        for (var snapshot in querySnapshot.docs) {
          performances.add(snapshot.data()[snapshot.id]);
          dates.add(snapshot.id);
        }
        setState(() {
          performances;
          dates;
        });
      }
    });
  }

  List<RawData> convertData(Map<String, dynamic> performances) {
    List<RawData> rawDataList = [];
    performances.forEach((key, value) {
      rawDataList.add(RawData(force: value, timestamp: int.parse(key)));
    });
    rawDataList.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    return rawDataList;
  }

  List<List<Map<String, Object>>> getMarkAreas(Map<String, dynamic> performances) {
    List<RawData> rawDataList = [];
    List<List<Map<String, Object>>> areaList = [];

    performances.forEach((key, value) {
      rawDataList.add(RawData(force: value, timestamp: int.parse(key)));
    });
    rawDataList.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    bool start = true;
    int startValue = 0;
    int endValue = 0;
    for (var rawData in rawDataList) {
      if (rawData.force == 0 && start) {
        startValue = rawData.timestamp;
        int difference = startValue - endValue;
        areaList.add([
          {'name': '$difference sec', 'xAxis': startValue},
          {'xAxis': endValue}
        ]);
        start = false;
      }
      if (rawData.force > 0 && !start) {
        endValue = rawData.timestamp;
        int difference = startValue - endValue;
        areaList.add([
          {'name': '$difference sec', 'xAxis': startValue},
          {'xAxis': endValue}
        ]);
        start = true;
      }
    }
    startValue = endValue;
    endValue = rawDataList.last.timestamp;
    int difference = startValue - endValue;
    areaList.add([
      {'name': '$difference sec', 'xAxis': startValue},
      {'xAxis': endValue}
    ]);
    return areaList;
  }

  Widget buildChart() {
    if (performances.isNotEmpty) {
      return Expanded(
        child: Echarts(
          option: getLineOption(context, convertData(performances[selectedPerformance]), getMarkAreas(performances[selectedPerformance])),
        ),
      );
    } else {
      return const Center(
        child: SpinKitPulsingGrid(
          size: 40.0,
          color: Colors.blueAccent,
        ),
      );
    }
  }
}
