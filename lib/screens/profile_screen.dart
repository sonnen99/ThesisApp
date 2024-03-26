import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import '../models/chart_handler.dart';

class ProfileScreen extends StatefulWidget {
  static const String id = 'profile_screen';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<Map<String, Object>> _data1 = [
    {
      'name': 'Please wait',
      'Clean high pull': 0,
      'Push press': 0,
      'Pump squat': 0,
      'Dead lift': 0,
    },
  ];

  getData1() async {
    //TODO: Fetch data from firestore
    await Future.delayed(const Duration(seconds: 1));

    const dataObj = [
      {
        'name': '15 Jan 24',
        'Clean high pull': 720,
        'Push press': 780,
        'Pump squat': 3240,
        'Dead lift': 1080,
      },
      {
        'name': '23 Feb 24',
        'Clean high pull': 1120,
        'Push press': 660,
        'Pump squat': 3600,
        'Dead lift': 1160,
      },
      {
        'name': '04 Mar 24',
        'Clean high pull': 960,
        'Push press': 640,
        'Pump squat': 2880,
        'Dead lift': 1730,
      },
    ];

    setState(() {
      _data1 = dataObj;
    });
  }

  @override
  void initState() {
    super.initState();
    getData1();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8.0),
      child: Echarts(option: getBarOption(context, _data1),),
    );
  }
}
