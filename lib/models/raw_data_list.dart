import 'package:flutter/material.dart';
import 'package:flutter_echarts/flutter_echarts.dart';
import 'package:provider/provider.dart';
import 'package:thesisapp/models/raw_data_handler.dart';

import 'chart_handler.dart';

class RawDataList extends StatelessWidget {
  const RawDataList({super.key});


  @override
  Widget build(BuildContext context) {
    return Consumer<RawDataHandler>(
      builder: (context, value, child) {
        return Expanded(
          child: Echarts(
            option: getLineOption(context, value.rawData, value.markAreas, [500, 1500, 2500]),
          ),
        );
      },
    );
  }
}



