import 'dart:convert';
import 'package:simple_logger/simple_logger.dart';
import 'package:thesisapp/models/parameter.dart';
import 'package:thesisapp/models/parameter_radar.dart';
import 'package:thesisapp/models/raw_data.dart';
import 'package:thesisapp/utilities/color_schemes.g.dart';
import 'package:flutter/material.dart';

final parameterList = <Parameter>[
  Parameter('Clean high pull', 'max', 110, 80),
  Parameter('Push press', 'max', 110, 80),
  Parameter('Pump squat', 'max', 110, 80),
  Parameter('Dead lift', 'min', 110, 80),
];

String getBarSeries() {
  List<Map<String, Object>> series = [];

  for (Parameter parameter in parameterList) {
    series.add({
      'name': parameter.name,
      'type': 'bar',
      'barGap': 0,
      'label': {
        'show': true,
        'position': 'insideBottom',
        'distance': 8,
        'align': 'left',
        'verticalAlign': 'middle',
        'rotate': 90,
        'formatter': '{@{a}}',
        'fontSize': 16,
        'fontWeight': 300,
        'rich': {
          'name': {},
        }
      },
      'itemStyle': {
        'borderRadius': [8, 8, 0, 0],
      },
      'emphasis': {
        'focus': 'series',
      },
      'blur': {
        'label': {
          'show': false,
        },
      },
      'clip': true,
      'markPoint': {
        'symbol': 'pin',
        'symbolSize': 60,
        'label': {
          'show': true,
          'position': 'inside',
          'offset': [0, -2],
          'fontWeight': 300,
          'fontSize': 13,
        },
        'data': [
          {
            'type': parameter.maxmin,
            'name': 'Best',
          },
        ],
      },
    });
  }

  return jsonEncode(series);
}

const String xValue = 'Date';
const String xValue2 = 'Time';
const String yValue = 'Force';

String getBarOption(BuildContext context, List<Map<String, Object>> data1) {
  return '''{
            color: [${getColor(context, 'blue')}, ${getColor(context, 'green')}, ${getColor(context, 'brown')}, ${getColor(context, 'red')}, ${getColor(context, 'turquoise')}, ${getColor(context, 'yellow')}],
            dataset: {
              source: ${jsonEncode(data1)},
            },
            textStyle: {
              fontWeight: 400,
            },
            legend: {
              data: ${jsonEncode(parameterList)},
              type: 'scroll',
              orient: 'horizontal',
              pageButtonItemGap: 6,
              pageButtonGap: 10,
              pageButtonPosition: 'end',
              pageIconColor: ${jsonEncode('#${Theme.of(context).colorScheme.primary.value.toRadixString(16).substring(2)}')},
              pageIconInactiveColor: ${jsonEncode('#${Theme.of(context).colorScheme.surfaceVariant.value.toRadixString(16).substring(2)}')},
              pageIconSize: 14,
              pageTextStyle: {
                color: ${jsonEncode('#${Theme.of(context).colorScheme.onSurfaceVariant.value.toRadixString(16).substring(2)}')},
                fontWeight: 200,
              },
              animationDurationUpdate: 500,
              bottom: '12.4%',
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
                name: ${jsonEncode(xValue)},
                nameLocation: 'middle',
                nameTextStyle: {
                  verticalAlign: 'top',
                  lineHeight: 32,
                },
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
            series: ${getBarSeries()},
          }''';
}

String getLineOption(BuildContext context, List<RawData> rawData, List<List<Map<String, Object>>> markAreas) {
  List<List<Object>> data = [];
  data = convertRawdataToMap(rawData);

  return '''{
            color: [${getColor(context, 'blue')}],
            textStyle: {
              fontWeight: 400,
            },
            grid: {
              left: '5%',
              right: '7%',
              top: '5.1%',
              height: '80%',
              containLabel: true,          
            },
            toolbox: {
              show: true,
              orient: 'vertical',
              left: 'right',
              top: 'center',
              feature: {
                dataView: {
                  iconStyle: {
                    borderColor: ${jsonEncode('#${Theme.of(context).colorScheme.onSurfaceVariant.value.toRadixString(16).substring(2)}')},
                    borderCap: 'round',
                    borderJoin: 'round',
                  },
                  readOnly: 'true',
                  backgroundColor: ${jsonEncode('#${Theme.of(context).colorScheme.surface.value.toRadixString(16).substring(2)}')},
                  textareaColor: ${jsonEncode('#${Theme.of(context).colorScheme.surfaceVariant.value.toRadixString(16).substring(2)}')},
                  textareaBorderColor: ${jsonEncode('#${Theme.of(context).colorScheme.onSurface.value.toRadixString(16).substring(2)}')},
                  textColor: ${jsonEncode('#${Theme.of(context).colorScheme.onSurface.value.toRadixString(16).substring(2)}')},
                  buttonColor: ${jsonEncode('#${Theme.of(context).colorScheme.primary.value.toRadixString(16).substring(2)}')},
                  buttonTextColor: ${jsonEncode('#${Theme.of(context).colorScheme.onPrimary.value.toRadixString(16).substring(2)}')},
                  emphasis: {
                    iconStyle: {
                      borderColor: ${jsonEncode('#${Theme.of(context).colorScheme.primary.value.toRadixString(16).substring(2)}')},
                      borderCap: 'round',
                      borderJoin: 'round',
                    },
                  },
                },
                dataZoom: {
                  yAxisIndex: 'none',
                  iconStyle: {
                    borderColor: ${jsonEncode('#${Theme.of(context).colorScheme.onSurfaceVariant.value.toRadixString(16).substring(2)}')},
                    borderCap: 'round',
                    borderJoin: 'round',
                  },
                  emphasis: {
                    iconStyle: {
                      borderColor: ${jsonEncode('#${Theme.of(context).colorScheme.primary.value.toRadixString(16).substring(2)}')},
                      borderCap: 'round',
                      borderJoin: 'round',
                    },
                  },
                },
                restore: {
                  iconStyle: {
                    borderColor: ${jsonEncode('#${Theme.of(context).colorScheme.onSurfaceVariant.value.toRadixString(16).substring(2)}')},
                    borderCap: 'round',
                    borderJoin: 'round',
                  },
                  emphasis: {
                    iconStyle: {
                      borderColor: ${jsonEncode('#${Theme.of(context).colorScheme.primary.value.toRadixString(16).substring(2)}')},
                      borderCap: 'round',
                      borderJoin: 'round',
                    },
                  },
                },
                mark: {show: true},
              }
            },
            tooltip: {
              trigger: 'axis',
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
                name: ${jsonEncode(xValue2)},
                nameLocation: 'middle',
                nameTextStyle: {
                  color: ${jsonEncode('#${Theme.of(context).colorScheme.onSurface.value.toRadixString(16).substring(2)}')},
                  fontWeight: 300,
                  fontSize: 14,
                  verticalAlign: 'top',
                  lineHeight: 32,
                },
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
            yAxis: {
              type: 'value',
              position: 'left',
              scale: false,
              name: ${jsonEncode(yValue)},
              nameLocation: 'end',
              nameTextStyle: {
                  color: ${jsonEncode('#${Theme.of(context).colorScheme.onSurface.value.toRadixString(16).substring(2)}')},
                  fontWeight: 300,
                  fontSize: 14,
                  align: 'right',
                  verticalAlign: 'bottom',
                  padding: [0, 8, 0, 0],
                },
              minInterval: 1,
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
            },
            dataZoom: [
              {
                startValue: '0',
              },
              {
                type: 'inside',
              },
              {
                throttle: 50,
              },
            ],
            visualMap: {
              type: 'piecewise',
              selectedMode: 'multiple',
              inverse: false,
              orient: 'horizontal',
              bottom: '8%',
              left: '5%',
              pieces: [
                {
                  min: 0,
                  max: 500,
                  color: ${getColor(context, 'red')},
                  
                },
                {
                  min: 500,
                  max: 1500,
                  color: ${getColor(context, 'yellow')},
                },
                {
                  min: 1500,
                  max: 2500,
                  color: ${getColor(context, 'green')},
                },
                {
                  min: 2500,
                  color: ${getColor(context, 'orange')},
                },
              ],
              itemGap: 10,
              itemWidth: 16,
              itemHeight: 16,
              textStyle: {
                color: ${jsonEncode('#${Theme.of(context).colorScheme.onSurface.value.toRadixString(16).substring(2)}')},
                fontWeight: 200,
                fontSize: 14,
              },
              icon: 'roundRect',
              outOfRange: {
                color: '#999'
              }
            },
            series: {
              type: 'line',
              step: false,
              lineStyle: {
                width: 1.4,
                cap: 'round',
                join: 'round',
              },
              areaStyle: {
                color: ${jsonEncode('#${Theme.of(context).colorScheme.tertiary.value.toRadixString(16).substring(2)}')},
                opacity: 0.1,
              },
              smooth: true,
              sampling: 'lttb',
              symbol: 'none',
              markArea: {
                itemStyle: {
                  color: ${jsonEncode('#${Theme.of(context).colorScheme.primary.value.toRadixString(16).substring(2)}')},
                  opacity: 0.2,
                },
                label: {
                  show: false,
                  position: 'top',
                  distance: 8,
                  color: ${jsonEncode('#${Theme.of(context).colorScheme.onSurfaceVariant.value.toRadixString(16).substring(2)}')},
                  fontWeight: 300,
                  fontSize: 13,
                  align: 'center',
                },
                emphasis: {
                  label: {
                    show: true,
                    position: 'top',
                    distance: 8,
                    color: ${jsonEncode('#${Theme.of(context).colorScheme.onSurface.value.toRadixString(16).substring(2)}')},
                    fontWeight: 300,
                    fontSize: 15,
                    align: 'center',
                  },
                  itemStyle: {
                    color: ${jsonEncode('#${Theme.of(context).colorScheme.primary.value.toRadixString(16).substring(2)}')},
                    opacity: 0.5,
                  },
                },
                data: ${jsonEncode(markAreas)},
              },
              animation: true,
              animationEasing: 'fastOutSlowIn',
              animationDuration: 1000,
              animationDelay: 0,
              animationEasingUpdate: 'fastOutSlowIn',
              animationDurationUpdate: 500,
              animationDelayUpdate: function (idx) {
                return idx * 5;
              },
              data: ${jsonEncode(data)},
            },
          }''';
}

int getStartingValue() {
  return 0;
}

List<List<Object>> convertRawdataToMap(List<RawData> rawData) {
  List<List<Object>> newData = [];
  for (RawData rawDataPoint in rawData) {
    newData.add([rawDataPoint.timestamp.toString(), rawDataPoint.force]);
  }
  return newData;
}

String getIndicator() {
  List<Map<String, Object>> indicators = [];
  for (Parameter parameter in parameterList) {
    indicators.add({
      'name': parameter.name,
      'max': parameter.max,
      'min': parameter.min,
    });
  }
  return jsonEncode(indicators);
}

String getRadarData(List<RadarParameter> data) {
  List<Map<String, Object>> newData = [];
  for(RadarParameter parameter in data) {
    newData.add({
      'value': parameter.values,
      'name' : parameter.date,
    });
  }
  return jsonEncode(newData);
}

String getDates(List<RadarParameter> data) {
  List<String> dates = [];
  for (RadarParameter parameter in data) {
    dates.add(parameter.date);
  }
  return jsonEncode(dates);
}

String getRadarOption(BuildContext context, List<RadarParameter> data) {
  return '''{
              legend: {
                bottom: '25%',
                data: ${getDates(data)},
                itemGap: 10,
                textStyle: {
                  color: ${jsonEncode('#${Theme.of(context).colorScheme.onSurface.value.toRadixString(16).substring(2)}')},
                  fontSize: 16,
                  fontWeight: 300,
                },
                itemStyle: {
                  borderColor: ${jsonEncode('#${Theme.of(context).colorScheme.onTertiary.value.toRadixString(16).substring(2)}')},
                  borderWidth: 1,
                  shadowColor: ${jsonEncode('#${Theme.of(context).colorScheme.onSurface.value.toRadixString(16).substring(2)}')},
                  shadowBlur: 4,
                },
                selectedMode: 'multiple',
                inactiveColor: ${jsonEncode('#${Theme.of(context).colorScheme.surfaceVariant.value.toRadixString(16).substring(2)}')},
                selector: ['all', 'inverse'],
                selectorLabel: {
                  color: ${jsonEncode('#${Theme.of(context).colorScheme.onPrimary.value.toRadixString(16).substring(2)}')},
                  fontWeight: 300,
                  fontSize: 14,
                  lineHeight: 16,
                  backgroundColor: ${jsonEncode('#${Theme.of(context).colorScheme.primary.value.toRadixString(16).substring(2)}')},
                  borderColor: ${jsonEncode('#${Theme.of(context).colorScheme.onPrimary.value.toRadixString(16).substring(2)}')},
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
                backgroundColor: ${jsonEncode('#${Theme.of(context).colorScheme.surfaceVariant.value.toRadixString(16).substring(2)}')},
                textStyle: {
                  fontWeight: 300,
                  fontSize: 16,
                  color: ${jsonEncode('#${Theme.of(context).colorScheme.onSurfaceVariant.value.toRadixString(16).substring(2)}')},
                },
                order: 'valueAsc',
              },
              radar: {
                indicator: ${getIndicator()},
                center: ['50%', '30%'],
                radius: '70%',
                startAngle: 90,
                shape: 'polygon',
                splitNumber: 3,
                nameGap: 2,
                axisName: {
                  color: ${jsonEncode('#${Theme.of(context).colorScheme.primary.value.toRadixString(16).substring(2)}')},
                  fontWeight: 300,
                  fontSize: 12,
                  overflow: 'breakAll',
                  padding: [4,-14,4,-14],
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
                  color: ${jsonEncode('#${Theme.of(context).colorScheme.primary.value.toRadixString(16).substring(2)}')},
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
                      ${getColor(context, 'red')},
                      ${getColor(context, 'yellow')},
                      ${getColor(context, 'green')},
                    ],
                    opacity: 0.2,
                  },
                },
                axisLine: {
                  symbol: 'none',
                  lineStyle: {
                    color: ${jsonEncode('#${Theme.of(context).colorScheme.primary.value.toRadixString(16).substring(2)}')},
                    width: 0.5,
                    cap: 'round',
                  }
                }
              },
              series: [
                {
                  name: 'Performance',
                  type: 'radar',
                  lineStyle: {
                    width: 1,
                    opacity: 0.7,
                  },
                  data: ${getRadarData(data)},
                  symbol: 'none',
                  itemStyle: {
                    color: ${jsonEncode('#${Theme.of(context).colorScheme.tertiary.value.toRadixString(16).substring(2)}')},
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
                      color: ${jsonEncode('#${Theme.of(context).colorScheme.surfaceVariant.value.toRadixString(16).substring(2)}')},
                      opacity: 0.5,
                    },
                    areaStyle: {
                      color: ${jsonEncode('#${Theme.of(context).colorScheme.surfaceVariant.value.toRadixString(16).substring(2)}')},
                      opacity: 0.2,
                    },
                  },
                },
              ],
            }''';
}
