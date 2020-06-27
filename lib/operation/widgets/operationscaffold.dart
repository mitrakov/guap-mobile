import 'package:flutter/material.dart';
import 'package:guap_mobile/operation/global.dart';
import 'package:guap_mobile/operation/operation.dart';
import 'package:guap_mobile/redux/ajax.dart';
import 'package:guap_mobile/operation/widgets/addoperation.dart';
import 'package:optional/optional.dart';

class AddOperationScaffold extends StatelessWidget {
  final String category;
  final Optional<int> idOpt;
  final TextEditingController itemChangedCtrl = TextEditingController();
  final TextEditingController personChangedCtrl = TextEditingController();
  final TextEditingController dateChangedCtrl = TextEditingController();
  final TextEditingController summaChangedCtrl = TextEditingController();

  AddOperationScaffold(this.category, this.idOpt, {Key key}) : super(key: key);

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
    idOpt.ifPresent((id) => editOperation(context, id), orElse: () => addOperation(context));
  }

  void addOperation(BuildContext context) {
    final r = AddOperationRequest(itemChangedCtrl.text, personChangedCtrl.text, int.parse(summaChangedCtrl.text), dateChangedCtrl.text);
    Ajax.addOperation(r).then((_) => Navigator.popUntil(context, ModalRoute.withName("/main")));
  }

  void editOperation(BuildContext context, int id) {
    final r = ChangeOperationRequest(id, itemChangedCtrl.text, personChangedCtrl.text, int.parse(summaChangedCtrl.text), dateChangedCtrl.text);
    Ajax.changeOperation(r).then((_) {
      GlobalOperationStore.invalidate(id);
      Navigator.popUntil(context, ModalRoute.withName("/main"));
    });
  }
}
