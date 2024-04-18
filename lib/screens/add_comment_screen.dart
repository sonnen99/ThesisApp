import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:thesisapp/utilities/firebase_tags.dart';

import '../utilities/constants.dart';
import '../widgets/pb_elevated_button.dart';
import '../widgets/pb_text_field.dart';

final _firestore = FirebaseFirestore.instance;

class AddCommentScreen extends StatefulWidget {
  final String athleteID;
  final String date;
  final String comment;

  const AddCommentScreen({required this.athleteID, required this.date, required this.comment});

  @override
  State<AddCommentScreen> createState() => _AddCommentScreenState();
}

class _AddCommentScreenState extends State<AddCommentScreen> {
  String newComment = '';
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
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
              'Add note',
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
            Text('${widget.comment} $newComment'),
            const SizedBox(
              height: 10.0,
            ),
            PBTextField(
              labelText: 'Note',
              onChanged: (value) {
                setState(() {
                  _controller;
                  newComment = value;
                });
              },
              textEditingController: _controller,
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
                    final comment = <String, dynamic> {
                      fbComment: '${widget.comment} $newComment'.trim(),
                    };
                    _firestore.collection('athletes').doc(widget.athleteID).collection('performances').doc(widget.date).set(comment, SetOptions(merge: true));
                    Navigator.pop(context, '${widget.comment} $newComment'.trim());
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
