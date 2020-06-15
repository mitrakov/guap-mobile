import 'package:flutter/material.dart';
import 'package:guap_mobile/operation/operation.dart';
import 'package:guap_mobile/redux/ajax.dart';
import 'package:guap_mobile/widget/addoperation.dart';

class OperationScaffold extends StatelessWidget {
  final String category;

  const OperationScaffold(this.category, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // no need in Stateful widget for these 4 variables:
    String item = "";
    String date = "";
    String person = "";
    int summa = 0;

    return Scaffold(
      appBar: AppBar(title: Text("Guap application")),
      body: AddOperationScreen(
          category,
          onItemChanged: (value) => item = value,
          onDateChanged: (value) => date = value,
          onPersonChanged: (value) => person = value,
          onSummaChanged: (value) => summa = value
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check, size: 36),
        tooltip: "Confirm",
        onPressed: () => Ajax.addOperation(AddOperationRequest(item, person, summa, date))
            .then((r) => Navigator.popUntil(context, ModalRoute.withName("/main"))),
      ),
    );
  }
}
