import 'package:flutter/material.dart';


class PBTrainingListTile extends StatelessWidget {
  final Widget content;
  final void Function() onPress;
  final Widget leading;

  PBTrainingListTile({required this.content, required this.onPress, required this.leading});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        title: content,
        onTap: onPress,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        tileColor: Theme.of(context).colorScheme.secondaryContainer,
        iconColor: Theme.of(context).colorScheme.onSecondaryContainer,
        leading: leading,
      ),
    );
  }

}
