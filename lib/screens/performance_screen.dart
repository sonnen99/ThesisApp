import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';
import 'package:thesisapp/models/communication_handler.dart';
import 'package:thesisapp/models/raw_data_handler.dart';
import 'package:thesisapp/models/raw_data_list.dart';
import 'package:thesisapp/screens/save_performance_screen.dart';
import 'package:thesisapp/widgets/ble_tile.dart';
import 'package:thesisapp/widgets/pb_elevated_button.dart';

import '../models/athlete.dart';
import '../utilities/constants.dart';
import '../utilities/firebase_tags.dart';
import '../widgets/pb_icon_button.dart';

final _firestore = FirebaseFirestore.instance;

class PerformanceScreen extends StatefulWidget {
  static const String id = 'performance_screen';

  PerformanceScreen({required this.device});

  final device;

  @override
  State<PerformanceScreen> createState() => _PerformanceScreenState();
}

class _PerformanceScreenState extends State<PerformanceScreen> {
  CommunicationHandler? communicationHandler;
  bool isConnected = false;
  DeviceConnectionState connectionState = DeviceConnectionState.connecting;

  @override
  void initState() {
    super.initState();
    connectToDevice(widget.device);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: PBIconButton(
          icon: Symbols.keyboard_arrow_left_rounded,
          size: 32.0,
          onPressed: () {
            Provider.of<RawDataHandler>(context, listen: false).deleteAll();
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Performance collection',
          style: kTitleStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            BLETile(
              bleTitle: widget.device.name,
              onPress: () {
                connectToDevice(widget.device);
              },
              isConnected: connectionState,
              leading: isConnected
                  ? const Icon(
                      Symbols.bluetooth_connected_rounded,
                    )
                  : SpinKitWaveSpinner(
                      //dual ring, , , ripple, spinning lines, wave spinner
                      trackColor: Theme.of(context).colorScheme.secondaryContainer,
                      waveColor: Theme.of(context).colorScheme.primary,
                      curve: Curves.fastOutSlowIn,
                      color: Theme.of(context).colorScheme.primary,
                      size: 54.0,
                      duration: const Duration(milliseconds: 1400),
                      child: const Icon(
                        Symbols.bluetooth_searching_rounded,
                        size: 24.0,
                      ),
                    ),
            ),

            RawDataList(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PBElevatedButton(
                  onPressed: () {
                    Provider.of<RawDataHandler>(context, listen: false).deleteAll();
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Symbols.restart_alt_rounded,
                      ),
                      SizedBox(
                        width: 4.0,
                      ),
                      Text(
                        'Reset',
                        style: kButtonTextStyle,
                      ),
                    ],
                  ),
                ),
                PBElevatedButton(
                  onPressed: () async {
                    List<Athlete> athleteList = [];
                    await _firestore.collection(fbAthletes).get().then((querySnapshot) {
                      if (querySnapshot.docs.isNotEmpty) {
                        for (var snapshot in querySnapshot.docs) {
                          athleteList.add(Athlete(firstName: snapshot.data()[fbFirstname], lastName: snapshot.data()[fbLastname], fbid: snapshot.id));
                        }
                      }
                    });
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: SavePerformanceScreen(
                            athletes: athleteList,
                          ),
                        ),
                      ),
                    );
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
            // RealTimeGraph(stream: dataStream(),),
          ],
        ),
      ),
    );
  }

  Future<void> connectToDevice(DiscoveredDevice selectedDevice) async {
    communicationHandler ??= CommunicationHandler(context);
    await communicationHandler?.stopScan();
    communicationHandler?.connectToDevice(selectedDevice, (isConnected, status) {
      setState(() {
        connectionState = status;
        this.isConnected = isConnected;
      });
    });
  }

// Stream<int> dataStream() {
//   return Stream.
// }
}
