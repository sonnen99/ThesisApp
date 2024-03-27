import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:thesisapp/models/communication_handler.dart';
import 'package:thesisapp/widgets/ble_tile.dart';

import '../utilities/constants.dart';
import '../widgets/pb_icon_button.dart';

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
          leading: PBButton(
            icon: Symbols.keyboard_arrow_left_rounded,
            size: 32.0,
            onPressed: () {
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
                        size: 24.0,
                      )
                    : SpinKitWaveSpinner( //dual ring, , , ripple, spinning lines, wave spinner
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
            ],
          ),
        ));
  }

  Future<void> connectToDevice(DiscoveredDevice selectedDevice) async {
    communicationHandler ??= CommunicationHandler();
    await communicationHandler?.stopScan();
    communicationHandler?.connectToDevice(selectedDevice, (isConnected, status) {
      setState(() {
        connectionState = status;
        this.isConnected = isConnected;
      });
    });
  }
}
