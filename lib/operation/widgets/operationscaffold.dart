import 'package:flutter/material.dart';
import 'package:guap_mobile/operation/global.dart';
import 'package:guap_mobile/operation/operation.dart';
import 'package:guap_mobile/redux/ajax.dart';
import 'package:guap_mobile/operation/widgets/addoperation.dart';
import 'package:optional/optional.dart';

class AddOperationScaffold extends StatelessWidget {
  final String category;
  final Optional<int> idOpt;

  const AddOperationScaffold(this.category, this.idOpt, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // no need in Stateful widget for these 4 variables: // TODO are you sure?
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
        onSummaChanged: (value) => summa = value,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check, size: 36),
        tooltip: "Confirm",
        onPressed: () => onPress(context, item, date, person, summa),
      )
    );
  }

  void onPress(BuildContext context, String item, String date, String person, int summa) {
    idOpt.ifPresent((id) => editOperation(context, id, item, date, person, summa),           // I love you, Scala ☹️
              orElse: () => addOperation(context, item, date, person, summa)
    );
  }

  void addOperation(BuildContext context, String item, String date, String person, int summa) {
    Ajax.addOperation(AddOperationRequest(item, person, summa, date))
        .then((_) => Navigator.popUntil(context, ModalRoute.withName("/main")));
  }

  void editOperation(BuildContext context, int id, String item, String date, String person, int summa) {
    Ajax.changeOperation(ChangeOperationRequest(id, item, person, summa, date)).then((_) {
      GlobalOperationStore.invalidate(id);
      Navigator.popUntil(context, ModalRoute.withName("/main"));
    });
  }
}
