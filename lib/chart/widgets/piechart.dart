import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:guap_mobile/chart/chart.dart';
import 'package:guap_mobile/chart/widgets/fullscreenimage.dart';
import 'package:guap_mobile/redux/ajax.dart';

class PieChart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PieChartState();
}

class PieChartState extends State<PieChart> {
  static final now = DateTime.now();
  static final formatter = DateFormat.LLLL();
  
  final List<String> months = List.generate(12, (i) => i+1).map((i) => formatter.format(DateTime(now.year, i))).toList();
  final List<int> years = List.generate(4, (i) => i).map((i) => now.year - i).toList().reversed.toList();
  final TextEditingController monthCtrl = TextEditingController();
  final TextEditingController yearCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final monthDropdown = DropdownButton<String>(
      value: monthCtrl.text.isNotEmpty ? monthCtrl.text : null,
      hint: Text("Choose a month"),
      icon: Icon(Icons.arrow_drop_down),
      items: months.map((month) => DropdownMenuItem(value: month, child: Text(month))).toList(),
      elevation: 12,
      onChanged: (String? newValue) {
        setState(() {
          monthCtrl.text = newValue ?? "";
        });
      }
    );
    final yearDropdown = DropdownButton<int>(
        value: yearCtrl.text.isNotEmpty ? int.parse(yearCtrl.text) : null,
        hint: Text("Choose a year"),
        icon: Icon(Icons.arrow_drop_down),
        items: years.map((year) => DropdownMenuItem(value: year, child: Text(year.toString()))).toList(),
        elevation: 12,
        onChanged: (int? newValue) {
          setState(() {
            yearCtrl.text = newValue.toString();
          });
        }
    );

    return Column(children: <Widget>[
      monthDropdown,
      yearDropdown,
      ElevatedButton(
        child: Text("Go", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18)),
        onPressed: () {
          // no need to dispatch actions here, because it's used only here
          Ajax.pieChart(PieChartRequest(formatter.parse(monthDropdown.value ?? "").month, yearDropdown.value ?? 0)).then((uri) {
            Navigator.push(context, MaterialPageRoute(builder: (context1) => FullScreenImage(uri)));
          });
        }
      )
    ]);
  }
}
