import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:thesisapp/models/chart_handler.dart';
import 'package:thesisapp/models/parameter_radar.dart';

//TODO select date range?

class TeamsScreen extends StatefulWidget {
  static const String id = 'teams_screen';

  @override
  State<TeamsScreen> createState() => _TeamsScreenState();
}

class _TeamsScreenState extends State<TeamsScreen> {

  final List<RadarParameter> _data = [];


  getData1() async {
    //TODO: Fetch data from firestore
    await Future.delayed(const Duration(seconds: 1));

    const dates = [
      'Jan 24',
      'Mar 24',
    ];

    const dataObj = [
      214 / 220 * 100,
      234 / 240 * 100,
      4.8 / 5.21 * 100,
      1.60 / 1.62 * 100,
    ];
    const dataObj2 = [
      238 / 220 * 100,
      232 / 240 * 100,
      4.8 / 5.34 * 100,
      1.60 / 1.62 * 100,
    ];

    setState(() {
      _data.add(RadarParameter(dates[0], dataObj));
      _data.add(RadarParameter(dates[1], dataObj2));
    });
  }

  @override
  void initState() {
    super.initState();
    getData1();
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Jonathan'.toUpperCase(),
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w300,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 4),
          Expanded(
            child: Echarts(option: getRadarOption(context, _data)),
          ),
        ],
      ),
    );
  }
}
