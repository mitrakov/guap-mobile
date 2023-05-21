import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:guap_mobile/common/widgets/dropdown.dart';
import 'package:guap_mobile/redux/ajax.dart';

class QueryAggregateScreen extends StatelessWidget {
  final TextEditingController functionCtrl = TextEditingController();
  final TextEditingController dateFromCtrl = TextEditingController();
  final TextEditingController dateToCtrl = TextEditingController();
  final DateFormat formatter = DateFormat("dd-MM-yyyy");

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    functionCtrl.text = functionCtrl.text.isEmpty ? "SUM" : functionCtrl.text;
    dateFromCtrl.text = dateFromCtrl.text.isEmpty ? formatter.format(DateTime(now.year, now.month)) : dateFromCtrl.text;
    dateToCtrl.text = dateToCtrl.text.isEmpty ? formatter.format(now) : dateToCtrl.text;
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(children: <Widget>[
        TrixDropdown<String>(
          hintText: "Function",
          options: ["SUM", "MIN", "MAX", "AVG"],
          value: functionCtrl.text,
          onChanged: (String func) { functionCtrl.text = func; },
          getLabel: (String value) => value,
        ),
        SizedBox(height: 10),
        TextField(
          controller: dateFromCtrl,
          decoration: InputDecoration(border: OutlineInputBorder(), labelText: "Date FROM"),
          onTap: () async {
            final currentDate = formatter.parse(dateFromCtrl.text);
            final newDate = await _showCalendar(context, currentDate) ?? currentDate;
            dateFromCtrl.text = formatter.format(newDate);
          }
        ),
        SizedBox(height: 10),
        TextField(
          controller: dateToCtrl,
          decoration: InputDecoration(border: OutlineInputBorder(), labelText: "Date TO"),
          onTap: () async {
            final currentDate = formatter.parse(dateToCtrl.text);
            final newDate = await _showCalendar(context, currentDate) ?? currentDate;
            dateToCtrl.text = formatter.format(newDate);
          }
        ),
        SizedBox(height: 10),
        ElevatedButton(
          child: Text("Query", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18)),
          onPressed: () {
            // no need to dispatch actions here, because it's used only here
            Ajax.queryAggregate(functionCtrl.text, dateFromCtrl.text, dateToCtrl.text).then((value) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Result is $value")));
            });
          }
        )
      ])
    );
  }

  Future<DateTime?> _showCalendar(BuildContext context, DateTime initialDate) => showRoundedDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: DateTime(DateTime.now().year - 1),
    lastDate: DateTime(DateTime.now().year + 1),
    borderRadius: 16,
  );
}
