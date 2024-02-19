import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

//TODO select date range?

class TeamsScreen extends StatefulWidget {
  static const String id = 'teams_screen';

  @override
  State<TeamsScreen> createState() => _TeamsScreenState();
}

class _TeamsScreenState extends State<TeamsScreen> {
  int selectedDataSetIndex = -1;
  double angleValue = 0;

  @override
  Widget build(BuildContext context) {
    var gridColor = Theme.of(context).colorScheme.primary;
    var titleColor = Theme.of(context).colorScheme.onSurface;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                selectedDataSetIndex = -1;
              });
            },
            child: Text(
              'Jonathan'.toUpperCase(),
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w300,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: rawDataSets()
                .asMap()
                .map((index, value) {
                  final isSelected = index == selectedDataSetIndex;
                  return MapEntry(
                    index,
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedDataSetIndex = index;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(vertical: 2),
                        height: 26,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Theme.of(context).colorScheme.surface
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(46),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 6,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInToLinear,
                              padding: EdgeInsets.all(isSelected ? 8 : 6),
                              decoration: BoxDecoration(
                                color: value.color,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInToLinear,
                              style: TextStyle(
                                color: isSelected ? value.color : gridColor,
                              ),
                              child: Text(value.title),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                })
                .values
                .toList(),
          ),
          AspectRatio(
            aspectRatio: 1.2,
            child: RadarChart(
              RadarChartData(
                radarTouchData: RadarTouchData(
                  touchCallback: (FlTouchEvent event, response) {
                    if (!event.isInterestedForInteractions) {
                      setState(() {
                        selectedDataSetIndex = -1;
                      });
                      return;
                    }
                    setState(() {
                      selectedDataSetIndex =
                          response?.touchedSpot?.touchedDataSetIndex ?? -1;
                    });
                  },
                ),
                // Included Datasets
                dataSets: showingDataSets(),
                // Shape of the chart (circle/polygon)
                radarShape: RadarShape.polygon,
                // Background Color, Overlays the tickLines
                radarBackgroundColor:
                    Theme.of(context).colorScheme.surfaceVariant,
                // Outside Border of the chart
                radarBorderData: BorderSide(color: gridColor, width: 1.5),
                // How far the title is away from the grid
                titlePositionPercentageOffset: 0.2,
                titleTextStyle: TextStyle(
                    color: titleColor,
                    fontWeight: FontWeight.w100,
                    fontSize: 16),
                // Set the title for the grid
                getTitle: (index, angle) {
                  switch (index) {
                    case 1:
                      return RadarChartTitle(
                        text: 'Jump height',
                        angle: angleValue,
                      );
                    case 0:
                      return RadarChartTitle(
                        text: 'Jump distance',
                        angle: angleValue,
                      );
                    case 2:
                      return RadarChartTitle(
                        text: 'Agility',
                        angle: angleValue,
                      );
                    case 3:
                      return RadarChartTitle(
                        text: 'Speed 5m',
                        angle: angleValue,
                      );
                    case 4:
                      return RadarChartTitle(
                        text: 'Speed 15m',
                        angle: angleValue,
                      );
                    case 5:
                      return RadarChartTitle(
                        text: 'Endurance',
                        angle: angleValue,
                      );
                    default:
                      return const RadarChartTitle(text: '');
                  }
                },
                // Number of ticks in between
                tickCount: 3,
                // Style of the ticks
                tickBorderData: BorderSide(
                  color: gridColor,
                  width: 0.5,
                ),
                gridBorderData: BorderSide(color: gridColor, width: 1),
              ),
              swapAnimationDuration: const Duration(milliseconds: 400),
            ),
          ),
        ],
      ),
    );
  }

  List<RadarDataSet> showingDataSets() {
    return rawDataSets().asMap().entries.map((entry) {
      final index = entry.key;
      final rawDataSet = entry.value;

      final isSelected = index == selectedDataSetIndex
          ? true
          : selectedDataSetIndex == -1
              ? true
              : false;

      return RadarDataSet(
        // Inside Color of the set
        fillColor: isSelected
            ? rawDataSet.color.withOpacity(0.4)
            : rawDataSet.color.withOpacity(0.1),
        // Border Color of the set
        borderColor:
            isSelected ? rawDataSet.color : rawDataSet.color.withOpacity(0.4),
        // Radius of one point
        entryRadius: isSelected ? 2.5 : 2,
        // Width of the set borders
        borderWidth: isSelected ? 2.3 : 2,
        // Entries of the set
        dataEntries:
            rawDataSet.values.map((e) => RadarEntry(value: e)).toList(),
      );
    }).toList();
  }

  // TODO: get values from Database
  List<RawDataSet> rawDataSets() {
    return [
      // One Dataset of values
      RawDataSet(
        title: 'January [%]',
        color: Theme.of(context).colorScheme.tertiary,
        values: [
          250/220*100, //distance
          232/240*100, // height
          4.8/5.12*100, // agility
          1.6/1.25*100, // 5m
          3.3/2.76*100, // 15m
          5.7/5.9*100, // endurance
        ],
      ),
    ];
  }
}

class RawDataSet {
  RawDataSet({
    required this.title,
    required this.color,
    required this.values,
  });

  final String title;
  final Color color;
  final List<double> values;
}
