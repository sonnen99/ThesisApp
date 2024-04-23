import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class PBSwitch extends StatelessWidget {
  final IconData activeIcon;
  final IconData inactiveIcon;
  final bool value;
  final void Function(bool) onChanged;
  const PBSwitch({required this.activeIcon, required this.inactiveIcon, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Switch(
        thumbIcon: MaterialStateProperty.resolveWith<Icon?>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return Icon(
                activeIcon,
                color: Theme.of(context).colorScheme.onTertiary,
              );
            }
            return Icon(
              inactiveIcon,
              color: Theme.of(context).colorScheme.onError,
            );
          },
        ),
        inactiveThumbColor: Theme.of(context).colorScheme.error,
        activeColor: Theme.of(context).colorScheme.tertiary,
        activeTrackColor: Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
        value: value,
        onChanged: onChanged,
    );
  }
}
