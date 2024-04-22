import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:thesisapp/utilities/color_schemes.g.dart';
import 'package:thesisapp/utilities/firebase_tags.dart';

import '../utilities/constants.dart';
import '../widgets/pb_elevated_button.dart';

final _firestore = FirebaseFirestore.instance;

class ChangeLimitsScreen extends StatefulWidget {
  final String athleteID;
  final List<int> athleteLimits;

  ChangeLimitsScreen({required this.athleteID, required this.athleteLimits});

  @override
  State<ChangeLimitsScreen> createState() => _ChangeLimitsScreenState();
}

class _ChangeLimitsScreenState extends State<ChangeLimitsScreen> {
  late int _currentRedValue = widget.athleteLimits[0];
  late int _currentYellowValue = widget.athleteLimits[1];
  late int _currentGreenValue = widget.athleteLimits[2];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondaryContainer,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20.0),
            topLeft: Radius.circular(20.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Select limits',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSecondaryContainer,
                fontSize: 30.0,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              'Red upper limit',
              style: kSurfaceTextStyle.copyWith(color: getLineColorAsColor(context, 'red')),
            ),
            const SizedBox(
              height: 10.0,
            ),
            NumberPicker(
              haptics: true,
              axis: Axis.horizontal,
              itemHeight: 50,
              itemWidth: 80,
              minValue: 0,
              step: 50,
              maxValue: 4000,
              selectedTextStyle: kSurfaceTextStyle.copyWith(color: Theme.of(context).colorScheme.onSecondaryContainer),
              textStyle: kTitleStyle,
              value: _currentRedValue,
              onChanged: (value) {
                setState(() {
                  _currentRedValue = value;
                });
              },
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Theme.of(context).colorScheme.onSecondaryContainer),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              'Yellow upper limit',
              style: kSurfaceTextStyle.copyWith(color: getLineColorAsColor(context, 'yellow')),
            ),
            const SizedBox(
              height: 10.0,
            ),
            NumberPicker(
              haptics: true,
              axis: Axis.horizontal,
              itemHeight: 50,
              itemWidth: 80,
              minValue: _currentRedValue,
              step: 50,
              maxValue: 4000,
              selectedTextStyle: kSurfaceTextStyle.copyWith(color: Theme.of(context).colorScheme.onSecondaryContainer),
              textStyle: kTitleStyle,
              value: _currentYellowValue,
              onChanged: (value) {
                setState(() {
                  _currentYellowValue = value;
                });
              },
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Theme.of(context).colorScheme.onSecondaryContainer),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              'Green upper limit',
              style: kSurfaceTextStyle.copyWith(color: getLineColorAsColor(context, 'green')),
            ),
            const SizedBox(
              height: 10.0,
            ),
            NumberPicker(
              haptics: true,
              axis: Axis.horizontal,
              itemHeight: 50,
              itemWidth: 80,
              minValue: _currentYellowValue,
              step: 50,
              maxValue: 4000,
              selectedTextStyle: kSurfaceTextStyle.copyWith(color: Theme.of(context).colorScheme.onSecondaryContainer),
              textStyle: kTitleStyle,
              value: _currentGreenValue,
              onChanged: (value) {
                setState(() {
                  _currentGreenValue = value;
                });
              },
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Theme.of(context).colorScheme.onSecondaryContainer),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: kButtonTextStyle.copyWith(color: Theme.of(context).colorScheme.onSecondaryContainer),
                  ),
                ),
                PBElevatedButton(
                  onPressed: () {
                    final newLimits = <String, dynamic>{
                      fbRedArea: _currentRedValue,
                      fbYellowArea: _currentYellowValue,
                      fbGreenArea: _currentGreenValue,
                    };
                    _firestore.collection('athletes').doc(widget.athleteID).update(newLimits);
                    Navigator.pop(context, [_currentRedValue, _currentYellowValue, _currentGreenValue]);
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Symbols.save_rounded,
                      ),
                      SizedBox(
                        width: 4.0,
                      ),
                      Text(
                        'Save',
                        style: kButtonTextStyle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
