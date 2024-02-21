import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';

class ProfileScreen extends StatefulWidget {
  static const String id = 'profile_screen';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  List<Map<String, Object>> _data1 = [
    {
      'name': 'Please wait',
      'Jump height': 0,
      'Jump distance': 0,
      'Agility': 0,
      'Explosiveness': 0,
      'Speed': 0,
      'Endurance': 0,
    },
  ];

  getData1() async {
    //TODO: Fetch data from firestore
    await Future.delayed(Duration(seconds: 1));

    const dataObj = [
      {
        'name': 'Jan 24',
        'Jump height': 2.34,
        'Jump distance': 2.14,
        'Agility': 5.21,
        'Explosiveness': 1.6,
        'Speed': 3.3,
        'Endurance': 5.9,
      },
      {
        'name': 'Mar 24',
        'Jump height': 2.45,
        'Jump distance': 2.10,
        'Agility': 5.1,
        'Explosiveness': 1.4,
        'Speed': 3.5,
        'Endurance': 5.9,
      },
    ];

    this.setState(() {
      this._data1 = dataObj;
    });
  }

  @override
  void initState() {
    super.initState();
    this.getData1();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Echarts(
          option: '''{
            color: ['#395aae', '#80d996', '#ffb95f', '#ffb1c1', '#9acbff', '#026d36'],
            // baseOption: {
            //   timeline: {},
            // },
            // options: [],
            dataset: {
              source: ${jsonEncode(_data1)},
            },
            textStyle: {
              fontWeight: 400,
            },
            legend: {
              data: [
                'Jump height',
                'Jump distance',
                'Agility',
                'Explosiveness',
                'Speed',
                'Endurance'
              ],
              type: 'scroll',
              orient: 'horizontal',
              pageButtonItemGap: 6,
              pageButtonGap: 10,
              pageButtonPosition: 'end',
              pageIconColor: ${jsonEncode('#' + Theme.of(context).colorScheme.primary.value.toRadixString(16).substring(2))},
              pageIconInactiveColor: ${jsonEncode('#' + Theme.of(context).colorScheme.surfaceVariant.value.toRadixString(16).substring(2))},
              pageIconSize: 18,
              pageTextStyle: {
                color: ${jsonEncode('#' + Theme.of(context).colorScheme.onSurfaceVariant.value.toRadixString(16).substring(2))},
                fontWeight: 200,
              },
              animationDurationUpdate: 500,
              bottom: '13%',
              padding: [0,10,0,10],
              itemGap: 10,
              itemWidth: 16,
              itemHeight: 16,
              textStyle: {
                color: ${jsonEncode('#' + Theme.of(context).colorScheme.onSurface.value.toRadixString(16).substring(2))},
                fontWeight: 200,
                fontSize: 14,
              },
              
            },
            grid: {
              left: '5%',
              right: '7%',
              top: '4%',
              height: '78%',
              containLabel: true,
              z: 22,
            },
            toolbox: {
              show: true,
              orient: 'vertical',
              left: 'right',
              top: 'center',
              feature: {
                mark: {show: true},
                magicType: {
                  show: true,
                  type: ['line', 'bar']
                },
                saveAsImage: {},
              }
            },
            tooltip: {
              trigger: 'item',
              position: 'top',
              backgroundColor: ${jsonEncode('#' + Theme.of(context).colorScheme.surfaceVariant.value.toRadixString(16).substring(2))},
              textStyle: {
                fontWeight: 300,
                fontSize: 16,
                color: ${jsonEncode('#' + Theme.of(context).colorScheme.onSurfaceVariant.value.toRadixString(16).substring(2))},
              },
            },
            animationEasing: 'elasticOut',
            animationDelayUpdate: function (idx) {
              return idx * 5;
            },
            xAxis: [
              {
                type: 'category',
                axisTick: {show: false},
              }
            ],
            yAxis: [
              {
                type: 'value',
              }
            ],
            series: [
              {
                name: 'Jump height',
                type: 'bar',
                barGap: 0,
                label: {
                  show: true,
                  position: 'insideBottom',
                  distance: 10,
                  align: 'left',
                  verticalAlign: 'middle',
                  rotate: 90,
                  formatter: '{@Jump height}  {name|{a}}',
                  fontSize: 16,
                  rich: {
                    name: {},
                  }
                },
                itemStyle: {
                  borderRadius: [8,8,0,0],
                },
                emphasis: {focus: 'series'},
                animationDelay: function (idx) {
                  return idx * 10 + 100;
                },
                markPoint: {
                  data: [
                    {type: 'max', name: 'Max',},
                  ],
                },
              },
              {
                name: 'Jump distance',
                type: 'bar',
                label: {
                  show: true,
                  position: 'insideBottom',
                  distance: 10,
                  align: 'left',
                  verticalAlign: 'middle',
                  rotate: 90,
                  formatter: '{@Jump distance}  {name|{a}}',
                  fontSize: 16,
                  rich: {
                    name: {},
                  }
                },
                emphasis: {focus: 'series'},
                animationDelay: function (idx) {
                  return idx * 10 + 100;
                },
                markPoint: {
                  data: [
                    {type: 'max', name: 'Max',},
                  ],
                },
              },
              {
                name: 'Agility',
                type: 'bar',
                label: {
                  show: true,
                  position: 'insideBottom',
                  distance: 10,
                  align: 'left',
                  verticalAlign: 'middle',
                  rotate: 90,
                  formatter: '{@Agility}  {name|{a}}',
                  fontSize: 16,
                  rich: {
                    name: {},
                  }
                },
                emphasis: {focus: 'series'},
                animationDelay: function (idx) {
                  return idx * 10 + 100;
                },
                markPoint: {
                  data: [
                    {type: 'max', name: 'Max',},
                  ],
                },
              },
              {
                name: 'Explosiveness',
                type: 'bar',
                label: {
                  show: true,
                  position: 'insideBottom',
                  distance: 10,
                  align: 'left',
                  verticalAlign: 'middle',
                  rotate: 90,
                  formatter: '{@Explosiveness}  {name|{a}}',
                  fontSize: 16,
                  rich: {
                    name: {},
                  }
                },
                emphasis: {focus: 'series'},
                animationDelay: function (idx) {
                  return idx * 10 + 100;
                },
                markPoint: {
                  data: [
                    {type: 'max', name: 'Max',},
                  ],
                },
              },
              {
                name: 'Speed',
                type: 'bar',
                label: {
                  show: true,
                  position: 'insideBottom',
                  distance: 10,
                  align: 'left',
                  verticalAlign: 'middle',
                  rotate: 90,
                  formatter: '{@Speed}  {name|{a}}',
                  fontSize: 16,
                  rich: {
                    name: {},
                  }
                },
                emphasis: {focus: 'series'},
                animationDelay: function (idx) {
                  return idx * 10 + 100;
                },
                markPoint: {
                  data: [
                    {type: 'max', name: 'Max',},
                  ],
                },
              },
              {
                name: 'Endurance',
                type: 'bar',
                label: {
                  show: true,
                  position: 'insideBottom',
                  distance: 10,
                  align: 'left',
                  verticalAlign: 'middle',
                  rotate: 90,
                  formatter: '{@Endurance}  {name|{a}}',
                  fontSize: 16,
                  rich: {
                    name: {},
                  }
                },
                
                emphasis: {focus: 'series'},
                animationDelay: function (idx) {
                  return idx * 10 + 100;
                },
                markPoint: {
                  data: [
                    {type: 'max', name: 'Max',},
                  ],
                },
              }
            ]
          }'''
      ),
    );
  }
}
