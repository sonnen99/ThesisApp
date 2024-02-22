import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:thesisapp/utilities/color_schemes.g.dart';

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
    await Future.delayed(const Duration(seconds: 1));

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
        'Endurance': 6.4,
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
      padding: EdgeInsets.only(top: 8.0),
      child: Echarts(option: '''{
            color: [${getColor(context, 'blue')}, ${getColor(context, 'green')}, ${getColor(context, 'brown')}, ${getColor(context, 'red')}, ${getColor(context, 'turquoise')}, ${getColor(context, 'yellow')}],
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
              pageIconColor: ${jsonEncode('#${Theme.of(context).colorScheme.primary.value.toRadixString(16).substring(2)}')},
              pageIconInactiveColor: ${jsonEncode('#${Theme.of(context).colorScheme.surfaceVariant.value.toRadixString(16).substring(2)}')},
              pageIconSize: 18,
              pageTextStyle: {
                color: ${jsonEncode('#${Theme.of(context).colorScheme.onSurfaceVariant.value.toRadixString(16).substring(2)}')},
                fontWeight: 200,
              },
              animationDurationUpdate: 500,
              bottom: '13%',
              padding: [0,10,0,10],
              itemGap: 10,
              itemWidth: 16,
              itemHeight: 16,
              textStyle: {
                color: ${jsonEncode('#${Theme.of(context).colorScheme.onSurface.value.toRadixString(16).substring(2)}')},
                fontWeight: 200,
                fontSize: 14,
              },
              selectedMode: 'multiple',
              inactiveColor: ${jsonEncode('#${Theme.of(context).colorScheme.surfaceVariant.value.toRadixString(16).substring(2)}')},
              icon: 'roundRect',
            },
            grid: {
              left: '5%',
              right: '7%',
              top: '5.1%',
              height: '78%',
              containLabel: true,          
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
              position: 'bottom',
              backgroundColor: ${jsonEncode('#${Theme.of(context).colorScheme.surfaceVariant.value.toRadixString(16).substring(2)}')},
              textStyle: {
                fontWeight: 300,
                fontSize: 16,
                color: ${jsonEncode('#${Theme.of(context).colorScheme.onSurfaceVariant.value.toRadixString(16).substring(2)}')},
              },
            },
            animationEasing: 'elasticOut',
            animationDelayUpdate: function (idx) {
              return idx * 5;
            },
            xAxis: [
              {
                type: 'category',
                position: 'bottom',
                name: 'Date',
                nameLocation: 'middle',
                inverse: false,
                boundaryGap: true,
                axisLine: {
                  show: true,
                  lineStyle: {
                    cap: 'round',
                    join: 'round',
                  },
                },
                axisTick: {
                  show: true,
                  alignWithLabel: false,
                  inside: false,
                  length: 8,
                  lineStyle: {
                    cap: 'round',
                    join: 'round',
                  },
                },
                axisLabel: {
                  hideOverlap: true,
                },
                splitLine: {
                  show: false,
                },
              }
            ],
            yAxis: [
              {
                type: 'value',
                position: 'left',
                scale: false,
                minInterval: 0.5,
                axisLine: {
                  show: false,
                  lineStyle: {
                    cap: 'round',
                    join: 'round',
                  },
                },
                axisTick: {
                  show: false,
                },
                splitLine: {
                  show: true,
                  lineStyle: {
                    color: ${jsonEncode('#${Theme.of(context).colorScheme.onSurfaceVariant.value.toRadixString(16).substring(2)}')},
                    width: 0.7,
                    cap: 'round',
                    join: 'round',
                  },
                },
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
                  distance: 8,
                  align: 'left',
                  verticalAlign: 'middle',
                  rotate: 90,
                  formatter: '{@Jump height}  {name|{a}}',
                  fontSize: 16,
                  fontWeight: 300,
                  rich: {
                    name: {},
                  }
                },
                itemStyle: {
                  borderRadius: [8,8,0,0],
                },
                emphasis: {
                  focus: 'series',
                },
                blur: {
                  label: {
                    show: false,
                  },
                },
                clip: true,
                animationDelay: function (idx) {
                  return idx * 10 + 100;
                },
                markPoint: {
                  symbol: 'pin',
                  symbolSize: 60,
                  label: {
                    show: true,
                    position: 'inside',
                    offset: [0,-2],
                    fontWeight: 300,
                    fontSize: 13,
                  },
                  data: [
                    {type: 'max', name: 'Best',},
                  ],
                  
                },
              },
              {
                name: 'Jump distance',
                type: 'bar',
                barGap: 0,
                label: {
                  show: true,
                  position: 'insideBottom',
                  distance: 8,
                  align: 'left',
                  verticalAlign: 'middle',
                  rotate: 90,
                  formatter: '{@Jump distance}  {name|{a}}',
                  fontSize: 16,
                  fontWeight: 300,
                  rich: {
                    name: {},
                  }
                },
                itemStyle: {
                  borderRadius: [8,8,0,0],
                },
                emphasis: {focus: 'series'},
                blur: {
                  label: {
                    show: false,
                  },
                },
                clip: true,
                animationDelay: function (idx) {
                  return idx * 10 + 100;
                },
                markPoint: {
                  symbol: 'pin',
                  symbolSize: 60,
                  label: {
                    show: true,
                    position: 'inside',
                    offset: [0,-2],
                    fontWeight: 300,
                    fontSize: 13,
                  },
                  data: [
                    {type: 'max', name: 'Best',},
                  ],
                },
              },
              {
                name: 'Agility',
                type: 'bar',
                barGap: 0,
                label: {
                  show: true,
                  position: 'insideBottom',
                  distance: 8,
                  align: 'left',
                  verticalAlign: 'middle',
                  rotate: 90,
                  formatter: '{@Agility}  {name|{a}}',
                  fontSize: 16,
                  fontWeight: 300,
                  rich: {
                    name: {},
                  }
                },
                itemStyle: {
                  borderRadius: [8,8,0,0],
                },
                emphasis: {focus: 'series'},
                blur: {
                  label: {
                    show: false,
                  },
                },
                clip: true,
                animationDelay: function (idx) {
                  return idx * 10 + 100;
                },
                markPoint: {
                  symbol: 'pin',
                  symbolSize: 60,
                  label: {
                    show: true,
                    position: 'inside',
                    offset: [0,-2],
                    fontWeight: 300,
                    fontSize: 13,
                  },
                  data: [
                    {type: 'min', name: 'Best',},
                  ],
                },
              },
              {
                name: 'Explosiveness',
                type: 'bar',
                barGap: 0,
                label: {
                  show: true,
                  position: 'insideBottom',
                  distance: 8,
                  align: 'left',
                  verticalAlign: 'middle',
                  rotate: 90,
                  formatter: '{@Explosiveness}  {name|{a}}',
                  fontSize: 16,
                  fontWeight: 300,
                  rich: {
                    name: {},
                  }
                },
                itemStyle: {
                  borderRadius: [8,8,0,0],
                },
                emphasis: {focus: 'series'},
                blur: {
                  label: {
                    show: false,
                  },
                },
                animationDelay: function (idx) {
                  return idx * 10 + 100;
                },
                markPoint: {
                  symbol: 'pin',
                  symbolSize: 60,
                  label: {
                    show: true,
                    position: 'inside',
                    offset: [0,-2],
                    fontWeight: 300,
                    fontSize: 13,
                  },
                  data: [
                    {type: 'min', name: 'Best',},
                  ],
                },
              },
              {
                name: 'Speed',
                type: 'bar',
                barGap: 0,
                label: {
                  show: true,
                  position: 'insideBottom',
                  distance: 8,
                  align: 'left',
                  verticalAlign: 'middle',
                  rotate: 90,
                  formatter: '{@Speed}  {name|{a}}',
                  fontSize: 16,
                  fontWeight: 300,
                  rich: {
                    name: {},
                  }
                },
                itemStyle: {
                  borderRadius: [8,8,0,0],
                },
                emphasis: {focus: 'series'},
                blur: {
                  label: {
                    show: false,
                  },
                },
                clip: true,
                animationDelay: function (idx) {
                  return idx * 10 + 100;
                },
                markPoint: {
                  symbol: 'pin',
                  symbolSize: 60,
                  label: {
                    show: true,
                    position: 'inside',
                    offset: [0,-2],
                    fontWeight: 300,
                    fontSize: 13,
                  },
                  data: [
                    {type: 'min', name: 'Best',},
                  ],
                },
              },
              {
                name: 'Endurance',
                type: 'bar',
                barGap: 0,
                label: {
                  show: true,
                  position: 'insideBottom',
                  distance: 8,
                  align: 'left',
                  verticalAlign: 'middle',
                  rotate: 90,
                  formatter: '{@Endurance}  {name|{a}}',
                  fontSize: 16,
                  fontWeight: 300,
                  rich: {
                    name: {},
                  }
                },
                itemStyle: {
                  borderRadius: [8,8,0,0],
                },
                emphasis: {focus: 'series'},
                blur: {
                  label: {
                    show: false,
                  },
                },
                clip: true,
                animationDelay: function (idx) {
                  return idx * 10 + 100;
                },
                markPoint: {
                  symbol: 'pin',
                  symbolSize: 60,
                  label: {
                    show: true,
                    position: 'inside',
                    offset: [0,-2],
                    fontWeight: 300,
                    fontSize: 13,
                  },
                  data: [
                    {type: 'max', name: 'Best',},
                  ],
                },
              }
            ]
          }'''),
    );
  }
}
