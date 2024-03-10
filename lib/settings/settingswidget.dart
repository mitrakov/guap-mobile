import 'package:flutter/material.dart';
import 'package:guap_mobile/settings/settings.dart';

class SettingsWidget extends StatefulWidget { // StatefulWidget needed for setState()
  @override
  State<StatefulWidget> createState() => SettingsWidgetState();
}

class SettingsWidgetState extends State<SettingsWidget> {
  final rubToUsdCtrl = TextEditingController(text: Settings.getCurrencyRate("RUB").toString());
  final eurToUsdCtrl = TextEditingController(text: Settings.getCurrencyRate("EUR").toString());
  final gbpToUsdCtrl = TextEditingController(text: Settings.getCurrencyRate("GBP").toString());
  final kgsToUsdCtrl = TextEditingController(text: Settings.getCurrencyRate("KGS").toString());
  final amdToUsdCtrl = TextEditingController(text: Settings.getCurrencyRate("AMD").toString());
  final thbToUsdCtrl = TextEditingController(text: Settings.getCurrencyRate("THB").toString());
  final inrToUsdCtrl = TextEditingController(text: Settings.getCurrencyRate("INR").toString());

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        CheckboxListTile(
          title: const Text("Show persons"),
          subtitle: const Text("Enables or hides persons on each operation"),
          value: Settings.showPersons(),
          onChanged: (value) {
            setState(() {
              Settings.setShowPersons(value ?? true);
            });
          },
        ),
        ListTile(
          title: const Text("RUB rate"),
          subtitle: const Text("Currency rate RUB to USD"),
          trailing: SizedBox(width: 100, child: TextField(controller: rubToUsdCtrl, onChanged: (s) => _setCurrency("RUB", s), decoration: const InputDecoration(border: OutlineInputBorder()))),
        ),
        ListTile(
          title: const Text("EUR rate"),
          subtitle: const Text("Currency rate EUR to USD"),
          trailing: SizedBox(width: 100, child: TextField(controller: eurToUsdCtrl, onChanged: (s) => _setCurrency("EUR", s), decoration: const InputDecoration(border: OutlineInputBorder()))),
        ),
        ListTile(
          title: const Text("GBP rate"),
          subtitle: const Text("Currency rate GBP to USD"),
          trailing: SizedBox(width: 100, child: TextField(controller: gbpToUsdCtrl, onChanged: (s) => _setCurrency("GBP", s), decoration: const InputDecoration(border: OutlineInputBorder()))),
        ),
        ListTile(
          title: const Text("KGS rate"),
          subtitle: const Text("Currency rate KGS to USD"),
          trailing: SizedBox(width: 100, child: TextField(controller: kgsToUsdCtrl, onChanged: (s) => _setCurrency("KGS", s), decoration: const InputDecoration(border: OutlineInputBorder()))),
        ),
        ListTile(
          title: const Text("AMD rate"),
          subtitle: const Text("Currency rate AMD to USD"),
          trailing: SizedBox(width: 100, child: TextField(controller: amdToUsdCtrl, onChanged: (s) => _setCurrency("AMD", s), decoration: const InputDecoration(border: OutlineInputBorder()))),
        ),
        ListTile(
          title: const Text("THB rate"),
          subtitle: const Text("Currency rate THB to USD"),
          trailing: SizedBox(width: 100, child: TextField(controller: thbToUsdCtrl, onChanged: (s) => _setCurrency("THB", s), decoration: const InputDecoration(border: OutlineInputBorder()))),
        ),
        ListTile(
          title: const Text("INR rate"),
          subtitle: const Text("Currency rate INR to USD"),
          trailing: SizedBox(width: 100, child: TextField(controller: inrToUsdCtrl, onChanged: (s) => _setCurrency("INR", s), decoration: const InputDecoration(border: OutlineInputBorder()))),
        ),
      ]
    );
  }

  void _setCurrency(String currency, String value) {
    final d = double.tryParse(value);
    if (d != null) Settings.setCurrencyRate(currency, d);
  }
}
