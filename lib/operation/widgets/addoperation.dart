import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:intl/intl.dart';
import 'package:guap_mobile/item/widgets/itemschooser.dart';
import 'package:guap_mobile/item/redux.dart';
import 'package:guap_mobile/person/widgets/personchooser.dart';
import 'package:guap_mobile/redux/appstate.dart';
import 'package:guap_mobile/common/widgets/dropdown.dart';

class AddOperationScreen extends StatelessWidget {
  static final double MARGIN = 6;
  final String category;
  final TextEditingController itemChangedCtrl;
  final TextEditingController personChangedCtrl;
  final TextEditingController dateChangedCtrl;
  final TextEditingController summaChangedCtrl;
  final TextEditingController currencyChangedCtrl;
  final TextEditingController commentChangedCtrl;
  final TextEditingController addItemCtrl = TextEditingController();
  final DateFormat formatter = DateFormat("dd-MM-yyyy");

  AddOperationScreen(this.category, {required this.itemChangedCtrl, required this.personChangedCtrl, required this.dateChangedCtrl,
    required this.summaChangedCtrl, required this.currencyChangedCtrl, required this.commentChangedCtrl, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dateChangedCtrl.text = dateChangedCtrl.text.isEmpty ? formatter.format(DateTime.now()) : dateChangedCtrl.text;
    currencyChangedCtrl.text = currencyChangedCtrl.text.isEmpty ? "RUB" : currencyChangedCtrl.text;
    return Column(children: <Widget>[
      Row(
        children: <Widget>[
          Expanded(child: ItemsChooser(itemChangedCtrl)),
          IconButton(icon: const Icon(Icons.add_circle), onPressed: () => _addItemDialog(context).show()),
        ]
      ),
      SizedBox(height: MARGIN),
      Row(
        children: [
          Expanded(flex: 2, child: TextField(
            controller: summaChangedCtrl,
            decoration: const InputDecoration(border: OutlineInputBorder(), labelText: "Input sum"),
            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[\d.,]'))],  // digits, "." for Android, "," for iOS (which may show either of them depending on locale)
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          )),
          const SizedBox(width: 10),
          Expanded(child: TrixDropdown<String>(
            hintText: "Currency",
            options: const ["RUB", "USD", "EUR", "GBP", "KGS", "AMD", "THB", "INR"],
            value: currencyChangedCtrl.text,
            onChanged: (String currencyCode) { currencyChangedCtrl.text = currencyCode; },
            getLabel: (String value) => value,
          )),
        ],
      ),
      SizedBox(height: MARGIN),
      PersonChooser(personChangedCtrl),
      SizedBox(height: MARGIN),
      TextField(
        controller: dateChangedCtrl,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Choose the date"
        ),
        onTap: () async {
          final currentDate = formatter.parse(dateChangedCtrl.text);
          final newDate = await _showCalendar(context, currentDate) ?? currentDate;
          dateChangedCtrl.text = formatter.format(newDate);
        }
      ),
      SizedBox(height: MARGIN),
      TextField(controller: commentChangedCtrl, decoration: const InputDecoration(border: OutlineInputBorder(), labelText: "Add comment (optional)"))
    ]);
  }

  Future<DateTime?> _showCalendar(BuildContext context, DateTime initialDate) => showRoundedDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: DateTime(DateTime.now().year - 1),
    lastDate: DateTime(DateTime.now().year + 1),
    borderRadius: 16,
  );

  Alert _addItemDialog(BuildContext context) {
    return Alert(
      context: context,
      title: "Add item",
      content: Column(
        children: <Widget>[
          TextField(
            controller: addItemCtrl,
            decoration: const InputDecoration(icon: Icon(Icons.call_to_action), labelText: "Item name"),
          )
        ],
      ),
      buttons: [
        DialogButton(
          child: const Text("Add", style: TextStyle(color: Colors.white, fontSize: 20)),
          onPressed: () {
            StoreProvider.of<AppState>(context).dispatch(ItemsThunk.addItem(addItemCtrl.text, category));
            Navigator.pop(context);
          }
        ),
      ],
    );
  }
}
