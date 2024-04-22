import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:thesisapp/utilities/firebase_tags.dart';
import '../utilities/constants.dart';
import '../widgets/pb_elevated_button.dart';
import '../widgets/pb_text_field.dart';

final _firestore = FirebaseFirestore.instance;

class AddAthleteScreen extends StatefulWidget {
  @override
  State<AddAthleteScreen> createState() => _AddAthleteScreenState();
}

class _AddAthleteScreenState extends State<AddAthleteScreen> {
  late String firstName;
  late String lastName;
  final _firstController = TextEditingController();
  final _secondController = TextEditingController();

  @override
  void dispose() {
    _firstController.dispose();
    _secondController.dispose();
    super.dispose();
  }

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
              'Add athlete',
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
            PBTextField(
              labelText: 'First name',
              onChanged: (value) {
                setState(() {
                  _firstController;
                });
                firstName = value;
                print(value);
              },
              textEditingController: _firstController,
            ),
            const SizedBox(
              height: 10.0,
            ),
            PBTextField(
              labelText: 'Last name',
              onChanged: (value) {
                setState(() {
                  _secondController;
                });
                lastName = value;
                print(value);
              },
              textEditingController: _secondController,
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
                    if (_firstController.value.text.isNotEmpty && _secondController.value.text.isNotEmpty) {
                      final athlete = <String, dynamic> {
                        fbFirstname: firstName.trim(),
                        fbLastname : lastName.trim(),
                        fbRedArea: 500,
                        fbYellowArea: 1500,
                        fbGreenArea: 2500,
                      };
                      _firestore.collection(fbAthletes).add(athlete);
                      Navigator.pop(context);
                    }
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
