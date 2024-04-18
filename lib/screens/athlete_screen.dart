import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:thesisapp/models/chart_handler.dart';
import 'package:thesisapp/models/raw_data.dart';
import 'package:thesisapp/screens/add_comment_screen.dart';
import 'package:thesisapp/utilities/firebase_tags.dart';
import 'package:thesisapp/widgets/pb_delete_alert.dart';
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
  List<String> comments = [];
  int selectedPerformance = 0;
  bool forwardDisabled = true;
  bool backwardDisabled = false;

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
        actions: [
          MaterialButton(
            elevation: 0,
            shape: const CircleBorder(),
            onPressed: () async {
              final result = await showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: AddCommentScreen(
                      athleteID: widget.athleteID,
                      date: dates[selectedPerformance],
                      comment: comments[selectedPerformance],
                    ),
                  ),
                ),
              );
              if (result != null) {
                setState(() {
                  comments[selectedPerformance] = result;
                });
              }
            },
            padding: const EdgeInsets.all(6.0),
            color: Colors.transparent,
            disabledColor: Theme.of(context).colorScheme.surfaceVariant,
            disabledElevation: 0,
            child: Icon(
              Symbols.maps_ugc_rounded,
              color: Theme.of(context).colorScheme.primary,
              size: 32.0,
            ),
          ),
        ],
        title: Text(
          widget.athleteName,
          style: kTitleStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                comments.isNotEmpty && comments[selectedPerformance].isNotEmpty && comments[selectedPerformance] != ''
                    ? Expanded(
                        child: Text(
                           'Note: ${comments[selectedPerformance]}',
                          textAlign: TextAlign.start,
                        ),
                      )
                    : const SizedBox(
                        height: 1.0,
                      ),
                comments.isNotEmpty && comments[selectedPerformance].isNotEmpty && comments[selectedPerformance] != ''
                    ? MaterialButton(
                        elevation: 0,
                        shape: const CircleBorder(),
                        onPressed: () {
                          showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (_) => PBDeleteAlert(
                                  title: 'Delete comment?',
                                  onYes: () {
                                    final delete = <String, dynamic>{
                                      'comment': FieldValue.delete(),
                                    };
                                    _firestore.collection(fbAthletes).doc(widget.athleteID).collection(fbPerformances).doc(dates[selectedPerformance]).update(delete);
                                    setState(() {
                                      comments[selectedPerformance] = '';
                                    });
                                    Navigator.pop(context);
                                  },
                                  content: comments[selectedPerformance]));
                        },
                        padding: const EdgeInsets.all(6.0),
                        color: Colors.transparent,
                        disabledColor: Theme.of(context).colorScheme.surfaceVariant,
                        disabledElevation: 0,
                        child: Icon(
                          Symbols.scan_delete_rounded,
                          color: Theme.of(context).colorScheme.primary,
                          size: 24.0,
                        ),
                      )
                    : const SizedBox(
                        height: 1.0,
                      ),
              ],
            ),
            getParameters(),
            const SizedBox(height: 4.0,),
            buildChart(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PBIconButton(
                    icon: Symbols.keyboard_arrow_left_rounded,
                    onPressed: backwardDisabled
                        ? null
                        : () {
                            setState(() {
                              if (selectedPerformance > 0) selectedPerformance--;
                              backwardDisabled = selectedPerformance == 0;
                              forwardDisabled = false;
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
                  onPressed: forwardDisabled
                      ? null
                      : () {
                          setState(() {
                            if (selectedPerformance < performances.length - 1) selectedPerformance++;
                            forwardDisabled = selectedPerformance == performances.length - 1;
                            backwardDisabled = false;
                          });
                        },
                  size: 48.0,
                ),
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
          if (snapshot.data()[fbComment] == null) {
            comments.add('');
          } else {
            comments.add(snapshot.data()[fbComment]);
          }
        }
        setState(() {
          if (performances.length == 1) {
            forwardDisabled = true;
            backwardDisabled = true;
          }
          performances;
          dates;
          comments;
          selectedPerformance = performances.length - 1;
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
    // get distribution of swimming phases
    List<RawData> rawDataList = [];
    List<List<Map<String, Object>>> areaList = [];

    performances.forEach((key, value) {
      // performance data from firebase
      rawDataList.add(RawData(force: value, timestamp: int.parse(key)));
    });
    rawDataList.sort((a, b) => a.timestamp.compareTo(b.timestamp)); // sort the data by time
    bool start = true;
    bool first = true;
    int startValue = 0;
    int endValue = 0;

    for (var rawData in rawDataList) {
      if (rawData.force == 0 && start) {
        // record the start of above water phase
        if (first) {
          endValue = rawData.timestamp;
          int difference = (endValue - startValue) * 10;
          areaList.add([
            {'name': '$difference sec', 'xAxis': startValue},
            {'xAxis': endValue}
          ]);
          first = false;
          startValue = rawData.timestamp;
        } else {
          startValue = rawData.timestamp;
          int difference = (startValue - endValue) * 10; // compare to start of under water area
          areaList.add([
            // add under water area to areaList for the graph
            {'name': '$difference sec', 'xAxis': startValue},
            {'xAxis': endValue}
          ]);
        }
        start = false;
      }
      if (rawData.force > 0 && !start) {
        // record the start of under water phase
        endValue = rawData.timestamp;
        int difference = (endValue - startValue) * 10; // compare to start of above water area or 0
        areaList.add([
          {'name': '$difference sec', 'xAxis': startValue},
          {'xAxis': endValue}
        ]);
        start = true;
      }
    }

    startValue = endValue;
    endValue = rawDataList.last.timestamp;
    int difference = (endValue - startValue) * 10; // record last area
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

  Widget getParameters() {
    String strokeTime = '0';
    String strokeMin = '0';
    String distribution = '50/50';
    if (performances.isNotEmpty) {
      int strokes = 0;
      List<RawData> rawDataList = [];

      performances[selectedPerformance].forEach((key, value) {
        rawDataList.add(RawData(force: value, timestamp: int.parse(key)));
      });
      rawDataList.sort((a, b) => a.timestamp.compareTo(b.timestamp));
      bool start = true;
      bool first = true;
      int startValue = 0;
      int endValue = 0;
      int lastValue = 0;
      int difference = 0;
      double underDis = 0;
      double aboveDis = 0;
      for (var rawData in rawDataList) {
        if (rawData.force == 0 && start) {
          if (first) {
            endValue = rawData.timestamp;
            first = false;
            startValue = rawData.timestamp;
          } else {
            startValue = rawData.timestamp;
          }
          start = false;
        }
        if (rawData.force > 0 && !start) {
          endValue = rawData.timestamp;
          difference += (endValue - startValue) * 10;
          lastValue = endValue;
          start = true;
          strokes++;
        }
      }
      aboveDis = (difference / lastValue * 10).roundToDouble();
      underDis = 100 - aboveDis;
      setState(() {
        strokeTime = (rawDataList.last.timestamp / strokes / 100).toStringAsFixed(4);
        strokeMin = (strokes / rawDataList.last.timestamp * 6000).toStringAsFixed(4);
        distribution = '$aboveDis / $underDis';
      });
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Time/stroke: $strokeTime sec'),
        Text('Strokes/min: $strokeMin'),
        Text('Above/under: $distribution'),
      ],
    );
  }

}
