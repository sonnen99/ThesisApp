import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:thesisapp/models/athlete.dart';
import 'package:thesisapp/screens/add_athlete_screen.dart';
import 'package:thesisapp/screens/athlete_screen.dart';
import 'package:thesisapp/utilities/firebase_tags.dart';
import '../widgets/ble_tile.dart';

final _firestore = FirebaseFirestore.instance;

class TeamsScreen extends StatefulWidget {
  static const String id = 'teams_screen';

  @override
  State<TeamsScreen> createState() => _TeamsScreenState();
}

class _TeamsScreenState extends State<TeamsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80.0),
        child: FloatingActionButton.small(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: AddAthleteScreen(),
                ),
              ),
            );
          },
          heroTag: 'performance',
          shape: const CircleBorder(),
          child: const Icon(
            Symbols.add_rounded,
            size: 32.0,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: const Column(
        children: [
          Expanded(
            child: AthleteStream(),
          ),
        ],
      ),
    );
  }
}

class AthleteStream extends StatelessWidget {
  const AthleteStream({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection(fbAthletes).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Athlete> athleteList = [];
          for (var athlete in snapshot.data!.docs) {
            athleteList.add(
                Athlete(firstName: athlete[fbFirstname], lastName: athlete[fbLastname], fbid: athlete.id)
            );
          }
          athleteList.sort((a, b) => a.firstName.compareTo(b.firstName));
          return Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: athleteList.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  //TODO maybe uncomment
                  // onLongPress: () {
                  //   _firestore.collection(fbAthletes).where(fbFirstname, isEqualTo: athleteList[index].firstName).where(fbLastname, isEqualTo: athleteList[index].lastName).get().then((doc) {
                  //     String id = doc.docs[0].id;
                  //     _firestore.collection(fbAthletes).doc(id).delete();
                  //   });
                  // },
                  child: BLETile(
                    bleTitle: '${athleteList[index].firstName} ${athleteList[index].lastName}',
                    onPress: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        print(athleteList[index].fbid);
                        print(athleteList[index].firstName);
                        return AthleteScreen(athleteID: athleteList[index].fbid, athleteName: '${athleteList[index].firstName} ${athleteList[index].lastName}',);
                      }));
                    },
                    isConnected: DeviceConnectionState.disconnecting,
                    leading: const Icon(
                      Symbols.person,
                      size: 24.0,
                    ),
                  ),
                );
              },
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return const Center(
            child: SpinKitPulsingGrid(
              size: 40.0,
              color: Colors.blueAccent,
            ),
          );
        }
      },
    );
  }
}
