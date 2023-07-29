import 'package:flutter/material.dart';
import 'package:guap_mobile/settings/settings.dart';

class SettingsWidget extends StatefulWidget { // StatefulWidget needed for setState()
  @override
  State<StatefulWidget> createState() => SettingsWidgetState();
}

class SettingsWidgetState extends State<SettingsWidget> {
  final rubToUsdCtrl = TextEditingController(text: Settings.getCurrencyRate("RUB").toString());
  final eurToUsdCtrl = TextEditingController(text: Settings.getCurrencyRate("EUR").toString());
  final kgsToUsdCtrl = TextEditingController(text: Settings.getCurrencyRate("KGS").toString());
  final amdToUsdCtrl = TextEditingController(text: Settings.getCurrencyRate("AMD").toString());
  final thbToUsdCtrl = TextEditingController(text: Settings.getCurrencyRate("THB").toString());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CheckboxListTile(
          title: Text("Show persons"),
          subtitle: Text("Enables or hides persons on each operation"),
          value: Settings.showPersons(),
          onChanged: (value) {
            setState(() {
              Settings.setShowPersons(value ?? true);
            });
          },
        ),
        ListTile(
          title: Text("RUB rate"),
          subtitle: Text("Currency rate RUB to USD"),
          trailing: SizedBox(width: 100, child: TextField(controller: rubToUsdCtrl, onChanged: (s) => _setCurrency("RUB", s), decoration: const InputDecoration(border: OutlineInputBorder()))),
        ),
        ListTile(
          title: Text("EUR rate"),
          subtitle: Text("Currency rate EUR to USD"),
          trailing: SizedBox(width: 100, child: TextField(controller: eurToUsdCtrl, onChanged: (s) => _setCurrency("EUR", s), decoration: const InputDecoration(border: OutlineInputBorder()))),
        ),
        ListTile(
          title: Text("KGS rate"),
          subtitle: Text("Currency rate KGS to USD"),
          trailing: SizedBox(width: 100, child: TextField(controller: kgsToUsdCtrl, onChanged: (s) => _setCurrency("KGS", s), decoration: const InputDecoration(border: OutlineInputBorder()))),
        ),
        ListTile(
          title: Text("AMD rate"),
          subtitle: Text("Currency rate AMD to USD"),
          trailing: SizedBox(width: 100, child: TextField(controller: amdToUsdCtrl, onChanged: (s) => _setCurrency("AMD", s), decoration: const InputDecoration(border: OutlineInputBorder()))),
        ),
        ListTile(
          title: Text("THB rate"),
          subtitle: Text("Currency rate THB to USD"),
          trailing: SizedBox(width: 100, child: TextField(controller: thbToUsdCtrl, onChanged: (s) => _setCurrency("THB", s), decoration: const InputDecoration(border: OutlineInputBorder()))),
        ),
      ]
    );
  }

  void _setCurrency(String currency, String value) {
    final d = double.tryParse(value);
    if (d != null) Settings.setCurrencyRate(currency, d);
  }
}
