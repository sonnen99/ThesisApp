import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:provider/provider.dart';
import 'package:thesisapp/models/raw_data_handler.dart';
import 'package:thesisapp/utilities/constants.dart';
import 'package:thesisapp/widgets/pb_switch.dart';

class SettingsScreen extends StatefulWidget {
  static const String id = 'settings_screen';

  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  bool _notifications = true;
  String selectedLanguage = 'English';

  DropdownButton getDropdown() {
    List<DropdownMenuItem<String>> list = [];
    for (int i = 0; i < languageList.length; i++) {
      list.add(DropdownMenuItem(
        value: languageList[i],
        child: Text(languageList[i]),
      ));
    }
    return DropdownButton<String>(
      value: selectedLanguage,
      items: list,
      onChanged: (value) {
        setState(() {
          selectedLanguage = value!;
        });
      },
      style: kButtonTextStyle.copyWith(color: Theme
          .of(context)
          .colorScheme
          .onSurfaceVariant),
      borderRadius: BorderRadius.circular(10.0),
      dropdownColor: Theme
          .of(context)
          .colorScheme
          .surfaceVariant,
      isExpanded: false,
      isDense: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Language',
                style: kHeadline2TextStyle,
              ),
              const SizedBox(
                width: 4.0,
              ),
              getDropdown(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Dark mode',
                style: kHeadline2TextStyle,
              ),
              const SizedBox(
                width: 4.0,
              ),
              PBSwitch(
                activeIcon: Symbols.dark_mode_rounded,
                inactiveIcon: Symbols.light_mode_rounded,
                value: Provider.of<RawDataHandler>(context).mode == ThemeMode.dark,
                onChanged: (value) {
                  setState(() {
                    Provider.of<RawDataHandler>(context, listen: false).toggleMode();
                  });
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Notifications',
                style: kHeadline2TextStyle,
              ),
              const SizedBox(
                width: 4.0,
              ),
              PBSwitch(
                activeIcon: Symbols.notifications_active_rounded,
                inactiveIcon: Symbols.notifications_off_rounded,
                value: _notifications,
                onChanged: (value) {
                  setState(() {
                    _notifications = value;
                  });
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
