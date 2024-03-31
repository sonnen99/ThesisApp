import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class Athlete {
  final String firstName;
  final String lastName;

  Athlete({required this.firstName, required this.lastName});

  factory Athlete.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options,) {
      final data = snapshot.data();
      return Athlete(firstName: data?['firstname'], lastName: data?['lastname']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      'firstname': firstName,
      'lastname' : lastName,
    };
  }

}