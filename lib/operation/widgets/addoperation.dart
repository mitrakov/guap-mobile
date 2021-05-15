import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:intl/intl.dart';
import 'package:guap_mobile/item/widgets/itemschooser.dart';
import 'package:guap_mobile/item/redux.dart';
import 'package:guap_mobile/person/widgets/personchooser.dart';
import 'package:guap_mobile/redux/appstate.dart';

class AddOperationScreen extends StatelessWidget {
  final String category;
  final TextEditingController itemChangedCtrl;
  final TextEditingController personChangedCtrl;
  final TextEditingController dateChangedCtrl;
  final TextEditingController summaChangedCtrl;
  final TextEditingController addItemCtrl = TextEditingController();
  final DateFormat formatter = DateFormat("dd-MM-yyyy");

  AddOperationScreen(this.category, {this.itemChangedCtrl, this.personChangedCtrl, this.dateChangedCtrl, this.summaChangedCtrl, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dateChangedCtrl.text = dateChangedCtrl.text.isEmpty ? formatter.format(DateTime.now()) : dateChangedCtrl.text;
    return Column(children: <Widget>[
      Row(
        children: <Widget>[
          Expanded(child: ItemsChooser(itemChangedCtrl)),
          IconButton(icon: Icon(Icons.add_circle), onPressed: () => addItemDialog(context).show()),
        ]
      ),
      TextField(
        controller: summaChangedCtrl,
        decoration: InputDecoration(border: OutlineInputBorder(), labelText: "Input sum"),
        inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
        keyboardType: TextInputType.number,
      ),
      PersonChooser(personChangedCtrl),
      TextField(
        controller: dateChangedCtrl,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Choose the date"
        ),
        onTap: () async {
          final currentDate = formatter.parse(dateChangedCtrl.text);
          final newDate = await _showCalendar(context, currentDate) ?? currentDate;
          dateChangedCtrl.text = formatter.format(newDate);
        }
      ),
    ]);
  }

  Future<DateTime> _showCalendar(BuildContext context, DateTime initialDate) => showRoundedDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: DateTime(DateTime.now().year - 1),
    lastDate: DateTime(DateTime.now().year + 1),
    borderRadius: 16,
  );

  Alert addItemDialog(BuildContext context) {
    return Alert(
      context: context,
      title: "Add item",
      closeFunction: () => {},
      content: Column(
        children: <Widget>[
          TextField(
            controller: addItemCtrl,
            decoration: InputDecoration(icon: Icon(Icons.call_to_action), labelText: "Item name"),
          )
        ],
      ),
      buttons: [
        DialogButton(
          child: Text("Add", style: TextStyle(color: Colors.white, fontSize: 20)),
          onPressed: () {
            StoreProvider.of<AppState>(context).dispatch(ItemsThunk.addItem(addItemCtrl.text, category));
            Navigator.pop(context);
          }
        ),
      ],
    );
  }
}
