import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:thesisapp/utilities/constants.dart';
import 'package:thesisapp/widgets/pb_list_tile.dart';
import 'package:thesisapp/widgets/pb_training_list_tile.dart';

class HomeScreen extends StatelessWidget {
  static const String id = 'home_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80.0),
        child: FloatingActionButton.small(
          onPressed: () {
            // showModalBottomSheet(
            //   context: context,
            //   isScrollControlled: true,
            //   builder: (context) => SingleChildScrollView(
            //     child: Container(
            //       padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            //       //TODO add new training
            //     ),
            //   ),
            // );
          },
          shape: const CircleBorder(),
          child: const Icon(
            Symbols.add_rounded,
            size: 32.0,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            PBTrainingListTile(
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Training',
                          style: kHeadline2TextStyle.copyWith(color: Theme.of(context).colorScheme.onSecondaryContainer),
                        ),
                        Text(
                          '26/04/2024',
                          style: kSubHeadlineTextStyle.copyWith(color: Theme.of(context).colorScheme.onSecondaryContainer),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '17.30 - 19.00',
                          style: kSubHeadlineTextStyle.copyWith(color: Theme.of(context).colorScheme.onSecondaryContainer),
                        ),
                        Text(
                          '10/14',
                          style: kSubHeadlineTextStyle.copyWith(color: Theme.of(context).colorScheme.onSecondaryContainer),
                        ),
                      ],
                    ),
                  ],
                ),
                onPress: () {},
                leading: Icon(Symbols.pool_rounded))
          ],
        ),
      ),
    );
  }
}
