import 'dart:convert';

import 'package:flutter/material.dart';

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF0A57CE),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFDAE2FF),
  onPrimaryContainer: Color(0xFF001847),
  secondary: Color(0xFF00639B),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFCEE5FF),
  onSecondaryContainer: Color(0xFF001D33),
  tertiary: Color(0xFF156D30),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFA1F6A9),
  onTertiaryContainer: Color(0xFF002108),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  background: Color(0xFFFEFBFF),
  onBackground: Color(0xFF1B1B1F),
  surface: Color(0xFFFEFBFF),
  onSurface: Color(0xFF1B1B1F),
  surfaceVariant: Color(0xFFE1E2EC),
  onSurfaceVariant: Color(0xFF44464F),
  outline: Color(0xFF757780),
  onInverseSurface: Color(0xFFF2F0F4),
  inverseSurface: Color(0xFF303034),
  inversePrimary: Color(0xFFB1C5FF),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF0A57CE),
  outlineVariant: Color(0xFFC5C6D0),
  scrim: Color(0xFF000000),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFFB1C5FF),
  onPrimary: Color(0xFF002C72),
  primaryContainer: Color(0xFF0040A0),
  onPrimaryContainer: Color(0xFFDAE2FF),
  secondary: Color(0xFF96CBFF),
  onSecondary: Color(0xFF003353),
  secondaryContainer: Color(0xFF004A76),
  onSecondaryContainer: Color(0xFFCEE5FF),
  tertiary: Color(0xFF85D98F),
  onTertiary: Color(0xFF003913),
  tertiaryContainer: Color(0xFF00531F),
  onTertiaryContainer: Color(0xFFA1F6A9),
  error: Color(0xFFFFB4AB),
  errorContainer: Color(0xFF93000A),
  onError: Color(0xFF690005),
  onErrorContainer: Color(0xFFFFDAD6),
  background: Color(0xFF1B1B1F),
  onBackground: Color(0xFFE4E2E6),
  surface: Color(0xFF1B1B1F),
  onSurface: Color(0xFFE4E2E6),
  surfaceVariant: Color(0xFF44464F),
  onSurfaceVariant: Color(0xFFC5C6D0),
  outline: Color(0xFF8F9099),
  onInverseSurface: Color(0xFF1B1B1F),
  inverseSurface: Color(0xFFE4E2E6),
  inversePrimary: Color(0xFF0A57CE),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFFB1C5FF),
  outlineVariant: Color(0xFF44464F),
  scrim: Color(0xFF000000),
);

String getColor(BuildContext context, String color) {
  Color returnColor = const Color(0xFFFFFFFF);
  switch (Theme.of(context).brightness) {
    case Brightness.light:
      switch (color) {
        case 'blue':
          returnColor = const Color(0xFF395AAE);
          break;
        case 'green':
          returnColor = const Color(0xFF156D30);
          break;
        case 'brown':
          returnColor = const Color(0xFF855300);
          break;
        case 'pink':
          returnColor = const Color(0xFFA83156);
          break;
        case 'red':
          returnColor = const Color(0xFFC00100);
          break;
        case 'turquoise':
          returnColor = const Color(0xFF00687B);
          break;
        case 'violet':
          returnColor = const Color(0xFF6351A5);
          break;
        case 'yellow':
          returnColor = const Color(0xFFFBDB0F);
          break;
        case 'orange':
          returnColor = const Color(0xFFE47000);
          break;
        default:
          returnColor = const Color(0xFFFFFFFF);
          break;
      }
      break;
    case Brightness.dark:
      switch (color) {
        case 'blue':
          returnColor = const Color(0xFFB3C5FF);
          break;
        case 'green':
          returnColor = const Color(0xFF66DE8B);
          break;
        case 'brown':
          returnColor = const Color(0xFFC5Cf21);
          break;
        case 'pink':
          returnColor = const Color(0xFFFFB1C1);
          break;
        case 'red':
          returnColor = const Color(0xFFFF5540);
          break;
        case 'turquoise':
          returnColor = const Color(0xFF50D6F7);
          break;
        case 'violet':
          returnColor = const Color(0xFFCCBEFF);
          break;
        case 'yellow':
          returnColor = const Color(0xFFeffa4f);
          break;
        case 'orange':
          returnColor = const Color(0xFFFFB688);
          break;
        default:
          returnColor = const Color(0xFF000000);
          break;
      }
      break;
  }
  return jsonEncode('#${returnColor.value.toRadixString(16).substring(2)}');
}

String getLineColor(BuildContext context, String color) {
  Color returnColor = const Color(0xFFFFFFFF);

      switch (color) {

        case 'green':
          returnColor = const Color(0xFF85D98F);
          break;
        case 'yellow':
          returnColor = const Color(0xFFFBDB0F);
          break;
        case 'orange':
          returnColor = const Color(0xFFFC7D02);
          break;
        case 'red':
          returnColor = const Color(0xFFFD0100);
          break;
        default:
          returnColor = const Color(0xFFFFFFFF);
          break;
      }

  return jsonEncode('#${returnColor.value.toRadixString(16).substring(2)}');
}

Color getLineColorAsColor(BuildContext context, String color) {
  Color returnColor = const Color(0xFFFFFFFF);

  switch (color) {

    case 'green':
      returnColor = const Color(0xFF85D98F);
      break;
    case 'yellow':
      returnColor = const Color(0xFFFBDB0F);
      break;
    case 'orange':
      returnColor = const Color(0xFFFC7D02);
      break;
    case 'red':
      returnColor = const Color(0xFFFD0100);
      break;
    default:
      returnColor = const Color(0xFFFFFFFF);
      break;
  }

  return returnColor;
}