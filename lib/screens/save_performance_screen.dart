import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';

import '../utilities/constants.dart';
import '../widgets/pb_elevated_button.dart';

class SavePerformanceScreen extends StatefulWidget {
  @override
  State<SavePerformanceScreen> createState() => _SavePerformanceScreenState();
}

class _SavePerformanceScreenState extends State<SavePerformanceScreen> {
  late String athleteName;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: Container(
        padding: EdgeInsets.only(
          top: 30.0,
          left: 20.0,
          right: 20.0,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceVariant,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0),
            topLeft: Radius.circular(20.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Athlete name',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontSize: 30.0,
              ),
            ),
            TextField(
              autofocus: true,
              style: kTitleStyle,
              cursorColor: Theme.of(context).colorScheme.primary,
              keyboardAppearance: Theme.of(context).brightness,
              decoration: InputDecoration(border: OutlineInputBorder()),
              textAlign: TextAlign.center,
              onChanged: (value) {
                athleteName = value;
                print(value);
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            PBElevatedButton(
              onPressed: () {
                print(athleteName);
                //TODO add to firestore
                Navigator.pop(context);
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
      ),
    );
  }
}
