import 'package:flutter/material.dart';
import 'package:guap_mobile/operation/global.dart';
import 'package:guap_mobile/operation/operation.dart';
import 'package:guap_mobile/redux/ajax.dart';
import 'package:guap_mobile/operation/widgets/addoperation.dart';
import 'package:optional/optional.dart';

class AddOperationScaffold extends StatelessWidget {
  final String category;
  final Optional<Operation> operationOpt;
  final TextEditingController itemChangedCtrl;
  final TextEditingController personChangedCtrl;
  final TextEditingController dateChangedCtrl;
  final TextEditingController summaChangedCtrl;

  AddOperationScaffold(this.category, this.operationOpt, {Key key}) :
        itemChangedCtrl = TextEditingController(text: operationOpt.map((o) => o.itemUtf8).orElseGet(() => "")),
        personChangedCtrl = TextEditingController(text: operationOpt.map((o) => o.personUtf8).orElseGet(() => "")),
        dateChangedCtrl = TextEditingController(text: operationOpt.map((o) => o.timeUtf8).orElseGet(() => "")),
        summaChangedCtrl = TextEditingController(text: operationOpt.map((o) => o.summa.toString()).orElseGet(() => "")),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Guap application")),
      body: AddOperationScreen(
        category,
        itemChangedCtrl: itemChangedCtrl,
        dateChangedCtrl: dateChangedCtrl,
        personChangedCtrl: personChangedCtrl,
        summaChangedCtrl: summaChangedCtrl,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check, size: 36),
        tooltip: "Confirm",
        onPressed: () => onPress(context),
      )
    );
  }

  void onPress(BuildContext context) {
    operationOpt.ifPresent((op) => editOperation(context, op.id), orElse: () => addOperation(context));
  }

  void addOperation(BuildContext context) {
    // TODO Thunk?
    final r = AddOperationRequest(itemChangedCtrl.text, personChangedCtrl.text, int.parse(summaChangedCtrl.text), dateChangedCtrl.text);
    Ajax.addOperation(r).then((_) => Navigator.popUntil(context, ModalRoute.withName("/main")));
  }

  void editOperation(BuildContext context, int id) {
    // TODO Thunk?
    final r = ChangeOperationRequest(id, itemChangedCtrl.text, personChangedCtrl.text, int.parse(summaChangedCtrl.text), dateChangedCtrl.text);
    Ajax.changeOperation(r).then((_) {
      GlobalOperationStore.invalidate(id);
      Navigator.popUntil(context, ModalRoute.withName("/main"));
    });
  }
}
