import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thesisapp/utilities/firebase_tags.dart';

class Athlete {
  final String firstName;
  final String lastName;
  final String fbid;
  final int redArea;
  final int yellowArea;
  final int greenArea;

  Athlete({required this.firstName, required this.lastName, required this.fbid, required this.redArea, required this.yellowArea, required this.greenArea});

  factory Athlete.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options,) {
      final data = snapshot.data();
      return Athlete(firstName: data?[fbFirstname], lastName: data?[fbLastname], fbid: snapshot.id, redArea:  data?[fbRedArea], yellowArea: data?[fbYellowArea], greenArea: data?[fbGreenArea]);
  }

  Map<String, dynamic> toFirestore() {
    return {
      fbFirstname: firstName,
      fbLastname : lastName,
      fbRedArea : redArea,
      fbYellowArea : yellowArea,
      fbGreenArea : greenArea,
    };
  }

}