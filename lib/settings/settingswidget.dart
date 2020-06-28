import 'package:flutter/material.dart';
import 'package:guap_mobile/settings/settings.dart';

class SettingsWidget extends StatefulWidget { // StatefulWidget needed for setState()
  @override
  State<StatefulWidget> createState() => SettingsWidgetState();
}

class SettingsWidgetState extends State<SettingsWidget> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text("Show persons"),
      subtitle: Text("Enables or hides persons on each operation"),
      value: Settings.showPersons(),
      onChanged: (value) {
        setState(() {
          Settings.setShowPersons(value);
        });
      },
    );
  }
}
