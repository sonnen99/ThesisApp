import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';
import 'package:thesisapp/models/athlete.dart';
import 'package:thesisapp/models/raw_data_handler.dart';
import '../utilities/constants.dart';
import '../widgets/pb_elevated_button.dart';
import 'package:intl/intl.dart';


final _firestore = FirebaseFirestore.instance;

class SavePerformanceScreen extends StatefulWidget {
  final List<Athlete> athletes;
  SavePerformanceScreen({required this.athletes});
  @override
  State<SavePerformanceScreen> createState() => _SavePerformanceScreenState();
}

class _SavePerformanceScreenState extends State<SavePerformanceScreen> {
  
  late String selectedAthlete = widget.athletes.first.fbid;

  DropdownButton getDropdown() {

    List<DropdownMenuItem<String>> list = [];
    for (int i = 0; i < widget.athletes.length; i++) {
      list.add(DropdownMenuItem(
        value: widget.athletes[i].fbid,
        child: Text('${widget.athletes[i].firstName} ${widget.athletes[i].lastName}'),
      ));
    }
    return DropdownButton<String>(
      value: selectedAthlete,
      items: list,
      onChanged: (value) {
        setState(() {
          selectedAthlete = value!;
        });
      },
      style: kButtonTextStyle.copyWith(color: Theme.of(context).colorScheme.onSecondaryContainer),
      borderRadius: BorderRadius.circular(10.0),
      dropdownColor: Theme.of(context).colorScheme.secondaryContainer,
      isExpanded: true,
      isDense: true,
    );
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
              'Save performance',
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
            getDropdown(),
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
                    final DateTime now = DateTime.now();
                    final DateFormat formatter = DateFormat('yyyy-MM-dd hh:mm:ss');
                    final String date = formatter.format(now);
                    _firestore.collection('athletes').doc(selectedAthlete).collection('performances').doc(date).set(Provider.of<RawDataHandler>(context, listen: false).convertForFirestore(date)).onError((error, stackTrace) {
                      Navigator.pop(context, false);
                    });
                    Navigator.pop(context, true);
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
