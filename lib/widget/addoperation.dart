import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:guap_mobile/item/itemschooser.dart';
import 'package:guap_mobile/person/personchooser.dart';
import 'package:intl/intl.dart';

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
      ItemsChooser(category, onItemChanged),
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
}
