import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:guap_mobile/category/redux.dart';
import 'package:guap_mobile/chart/chart.dart';
import 'package:guap_mobile/chart/widgets/fullscreenimage.dart';
import 'package:guap_mobile/redux/ajax.dart';
import 'package:guap_mobile/redux/appstate.dart';

class TimeChart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => TimeChartState();
}

class TimeChartState extends State<TimeChart> {
  static final now = DateTime.now();
  
  final DateFormat formatter = DateFormat("dd-MM-yyyy");
  final List<int> years = List.generate(4, (i) => i).map((i) => now.year - i).toList().reversed.toList();
  final TextEditingController yearCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final yearDropdown = DropdownButton<int>(
      value: yearCtrl.text.isNotEmpty ? int.parse(yearCtrl.text) : null,
      hint: Text("Choose a year"),
      icon: Icon(Icons.arrow_drop_down),
      items: years.map((year) => DropdownMenuItem(value: year, child: Text(year.toString()))).toList(),
      elevation: 12,
      onChanged: (int newValue) {
        setState(() {
          yearCtrl.text = newValue.toString();
        });
      }
    );

    return StoreConnector<AppState, CategoryState>(
      distinct: true,
      converter: (store) => store.state.categoryState,
      builder: (context1, state) => Column(children: <Widget>[
        yearDropdown,
        RaisedButton(
          color: Theme.of(context).primaryColor,
          child: Text("Come on", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18)),
          onPressed: () {
            // no need to dispatch actions here, because it's used only here
            final date = formatter.format(DateTime(yearDropdown.value));
            final categories = state.asPlainList().map((c) => c.category.labelUtf8).toList();
            Ajax.timeChart(TimeChartRequest("month", date, categories)).then((uri) {
              Navigator.push(context, MaterialPageRoute(builder: (context1) => FullScreenImage(uri)));
            });
          }
        )
      ])
    );
  }
}
