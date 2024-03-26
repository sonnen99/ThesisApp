import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

const kIconData = IconThemeData(
  fill: 0,
  weight: 200,
  opticalSize: 48,
  grade: 200,
  size: 40,
);

final iconList = <IconData>[
  Symbols.home_rounded,
  Symbols.groups_rounded,
  Symbols.settings_rounded,
  Symbols.account_circle_rounded,
];

final screenList = <String>[
  'Home',
  'Teams',
  'Settings',
  'Profile',
];

const kTitleStyle = TextStyle(fontWeight: FontWeight.w100);
