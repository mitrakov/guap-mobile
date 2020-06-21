import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:intl/intl.dart';
import 'package:guap_mobile/item/item.dart';
import 'package:guap_mobile/item/itemschooser.dart';
import 'package:guap_mobile/item/redux.dart';
import 'package:guap_mobile/person/personchooser.dart';
import 'package:guap_mobile/redux/appstate.dart';

class AddOperationScreen extends StatelessWidget {
  final String category;
  final ValueChanged<String> onItemChanged;
  final ValueChanged<String> onPersonChanged;
  final ValueChanged<String> onDateChanged;
  final ValueChanged<int> onSummaChanged;

  const AddOperationScreen(this.category, {Key key, this.onItemChanged, this.onPersonChanged, this.onDateChanged, this.onSummaChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat("dd-MM-yyyy");
    final ctrl = TextEditingController();
    return Column(children: <Widget>[
      Row(
        children: <Widget>[
          Expanded(child: ItemsChooser(onItemChanged)),
          IconButton(icon: Icon(Icons.add_circle), onPressed: () => addItemDialog(context).show())
        ]
      ),
      TextField(
        decoration: InputDecoration(border: OutlineInputBorder(), labelText: "Input sum"),
        onChanged: (text) => onSummaChanged(int.parse(text)),
      ),
      PersonChooser(onPersonChanged),
      TextField(
        controller: ctrl,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Choose the date"
        ),
        onTap: () async {
          ctrl.text = formatter.format(await _showCalendar(context));
          onDateChanged(ctrl.text);
        }
      )
    ]);
  }

  Future<DateTime> _showCalendar(BuildContext context) => showRoundedDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(DateTime.now().year - 1),
    lastDate: DateTime(DateTime.now().year + 1),
    borderRadius: 16
  );

  Alert addItemDialog(BuildContext context) {
    String item = ""; // comment: is it safe?
    return Alert(
      context: context,
      title: "Add item",
      content: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(icon: Icon(Icons.call_to_action), labelText: "Item name"),
            onChanged: (text) => item = text
          )
        ],
      ),
      buttons: [
        DialogButton(
          child: Text("Add", style: TextStyle(color: Colors.white, fontSize: 20)),
          onPressed: () {
            StoreProvider.of<AppState>(context).dispatch(ItemsThunk.addItem(AddItemRequest(item, category)));
            Navigator.pop(context);
          }
        )
      ]
    );
  }
}
