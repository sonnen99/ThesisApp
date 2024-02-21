import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:thesisapp/utilities/color_schemes.g.dart';

//TODO select date range?

class TeamsScreen extends StatefulWidget {
  static const String id = 'teams_screen';

  @override
  State<TeamsScreen> createState() => _TeamsScreenState();
}

class _TeamsScreenState extends State<TeamsScreen> {
  List<Object> _data1 = [];
  List<Object> _data2 = [];

  getData1() async {
    //TODO: Fetch data from firestore
    await Future.delayed(Duration(seconds: 1));

    const dataObj = [
      214 / 220 * 100,
      234 / 240 * 100,
      4.8 / 5.21 * 100,
      1.60 / 1.62 * 100,
      3.3 / 3.1 * 100,
      5.7 / 5.5 * 100,
    ];

    const dataObj2 = [
      238 / 220 * 100,
      232 / 240 * 100,
      4.8 / 5.34 * 100,
      1.60 / 1.62 * 100,
      3.3 / 3.29 * 100,
      3.7 / 5.5 * 100,
    ];

    this.setState(() {
      this._data1 = dataObj;
      this._data2 = dataObj2;
    });
  }

  @override
  void initState() {
    super.initState();
    this.getData1();
  }

  @override
  Widget build(BuildContext context) {
    var gridColor = Theme.of(context).colorScheme.primary;

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
            child: Echarts(option: '''{
              legend: {
                bottom: '25%',
                data: ['Jan 24', 'Mar 24',],
                itemGap: 10,
                textStyle: {
                  color: ${jsonEncode('#' + Theme.of(context).colorScheme.onSurface.value.toRadixString(16).substring(2))},
                  fontSize: 16,
                  fontWeight: 300,
                },
                itemStyle: {
                  borderColor: ${jsonEncode('#' + Theme.of(context).colorScheme.onTertiary.value.toRadixString(16).substring(2))},
                  borderWidth: 1,
                  shadowColor: ${jsonEncode('#' + Theme.of(context).colorScheme.onSurface.value.toRadixString(16).substring(2))},
                  shadowBlur: 4,
                },
                selectedMode: 'multiple',
                inactiveColor: ${jsonEncode('#' + Theme.of(context).colorScheme.surfaceVariant.value.toRadixString(16).substring(2))},
                selector: ['all', 'inverse'],
                selectorLabel: {
                  color: ${jsonEncode('#' + Theme.of(context).colorScheme.onPrimary.value.toRadixString(16).substring(2))},
                  fontWeight: 300,
                  fontSize: 14,
                  lineHeight: 16,
                  backgroundColor: ${jsonEncode('#' + Theme.of(context).colorScheme.primary.value.toRadixString(16).substring(2))},
                  borderColor: ${jsonEncode('#' + Theme.of(context).colorScheme.onPrimary.value.toRadixString(16).substring(2))},
                  borderWidth: 1, 
                  padding: [4,8,4,8],
                },
                selectorPosition: 'start',
                selectorItemGap: 10,
                selectorButtonGap: 20,
              },
              tooltip: {
                position: 'bottom',
                valueFormatter: (value) => value.toFixed(1),
                backgroundColor: ${jsonEncode('#' + Theme.of(context).colorScheme.surfaceVariant.value.toRadixString(16).substring(2))},
                textStyle: {
                  fontWeight: 300,
                  fontSize: 16,
                  color: ${jsonEncode('#' + Theme.of(context).colorScheme.onSurfaceVariant.value.toRadixString(16).substring(2))},
                },
                order: 'valueAsc',
              },
              radar: {
                indicator: [
                  { name: 'Jump distance', max: 110, min: 80},
                  { name: 'Jump height', max: 110, min: 80},
                  { name: 'Agility', max: 110, min: 80},
                  { name: 'Explosiveness', max: 110, min: 80},
                  { name: 'Speed', max: 110, min: 80},
                  { name: 'Endurance', max: 110, min: 80}
                ],
                center: ['50%', '30%'],
                radius: '70%',
                startAngle: 90,
                shape: 'polygon',
                splitNumber: 3,
                axisName: {
                  color: ${jsonEncode('#' + Theme.of(context).colorScheme.primary.value.toRadixString(16).substring(2))},
                  fontWeight: 300,
                  fontSize: 12,
                  width: 20,
                  overflow: 'break',
                },
                axisTick: {
                  show: true,
                  length: 4,
                  lineStyle: {
                    width: 0.75,
                  },
                },
                axisLabel: {
                  show: true,
                  margin: 0,
                  fontWeight: 300,
                  fontSize: 10,
                  formatter: '{value} %',
                  showMinLabel: false,
                  showMaxLabel: false,
                  hideOverlap: true,
                  color: ${jsonEncode('#' + Theme.of(context).colorScheme.primary.value.toRadixString(16).substring(2))},
                  align: 'left',
                  verticalAlign: 'bottom',
                  padding: [0,0,0,4],
                  overflow: 'breakAll',
                },
                splitLine: {
                  show: true,
                  lineStyle: {
                    width: 0.75,
                    color: [
                      'rgba(${Theme.of(context).colorScheme.primary.red}, ${Theme.of(context).colorScheme.primary.green}, ${Theme.of(context).colorScheme.primary.blue}, 0.25)',
                      'rgba(${Theme.of(context).colorScheme.primary.red}, ${Theme.of(context).colorScheme.primary.green}, ${Theme.of(context).colorScheme.primary.blue}, 0.5)',
                      'rgba(${Theme.of(context).colorScheme.primary.red}, ${Theme.of(context).colorScheme.primary.green}, ${Theme.of(context).colorScheme.primary.blue}, 0.75)',
                      'rgba(${Theme.of(context).colorScheme.primary.red}, ${Theme.of(context).colorScheme.primary.green}, ${Theme.of(context).colorScheme.primary.blue}, 1)',
                    ].reverse(),
                  }
                },
                splitArea: {
                  show: true,
                  areaStyle: {
                    color: [
                      ${jsonEncode('#' + red.value.toRadixString(16).substring(2))},
                      ${jsonEncode('#' + yellow.value.toRadixString(16).substring(2))},
                      ${jsonEncode('#' + green.value.toRadixString(16).substring(2))},
                    ],
                    opacity: 0.2,
                  },
                },
                axisLine: {
                  symbol: 'none',
                  lineStyle: {
                    color: ${jsonEncode('#' + Theme.of(context).colorScheme.primary.value.toRadixString(16).substring(2))},
                    width: 0.5,
                    cap: 'round',
                  }
                }
              },
              series: [
                {
                  name: 'Jan 24',
                  type: 'radar',
                  lineStyle: {
                    width: 1,
                    opacity: 0.7,
                  },
                  data: [${jsonEncode(_data1)}],
                  symbol: 'none',
                  itemStyle: {
                    color: ${jsonEncode('#' + Theme.of(context).colorScheme.tertiary.value.toRadixString(16).substring(2))},
                  },
                  areaStyle: {
                    opacity: 0.25
                  },
                  emphasis: {
                    disabled: false,
                    focus: 'self',
                    blurScope: 'coordinateSystem',
                    lineStyle: {
                      width: 1.5,
                      opacity: 0.9,
                    },
                    areaStyle: {
                      opacity: 0.4,
                    },
                  },
                  blur: {
                    lineStyle: {
                      color: ${jsonEncode('#' + Theme.of(context).colorScheme.surfaceVariant.value.toRadixString(16).substring(2))},
                      opacity: 0.5,
                    },
                    areaStyle: {
                      color: ${jsonEncode('#' + Theme.of(context).colorScheme.surfaceVariant.value.toRadixString(16).substring(2))},
                      opacity: 0.2,
                    },
                  },
                },
                {
                  name: 'Mar 24',
                  type: 'radar',
                  lineStyle: {
                    width: 1,
                    opacity: 0.7
                  },
                  data: [${jsonEncode(_data2)}],
                  symbol: 'none',
                  itemStyle: {
                    color: ${jsonEncode('#' + Theme.of(context).colorScheme.tertiary.value.toRadixString(16).substring(2))},
                  },
                  areaStyle: {
                    opacity: 0.25
                  },
                  emphasis: {
                    disabled: false,
                    focus: 'self',
                    blurScope: 'coordinateSystem',
                    lineStyle: {
                      width: 1.5,
                      opacity: 0.9,
                    },
                    areaStyle: {
                      opacity: 0.4,
                    },
                  },
                  blur: {
                    lineStyle: {
                      color: ${jsonEncode('#' + Theme.of(context).colorScheme.surfaceVariant.value.toRadixString(16).substring(2))},
                      opacity: 0.5,
                    },
                    areaStyle: {
                      color: ${jsonEncode('#' + Theme.of(context).colorScheme.surfaceVariant.value.toRadixString(16).substring(2))},
                      opacity: 0.2,
                    },
                  },
                  
                },

              ]
            }'''),
          ),
        ],
      ),
    );
  }
}
