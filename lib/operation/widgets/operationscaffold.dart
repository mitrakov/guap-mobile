import 'package:optional/optional.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter/material.dart';
import 'package:guap_mobile/redux/appstate.dart';
import 'package:guap_mobile/person/redux.dart';
import 'package:guap_mobile/operation/operation.dart';
import 'package:guap_mobile/operation/widgets/addoperation.dart';
import 'package:guap_mobile/operation/redux.dart';

class AddOperationScaffold extends StatelessWidget {
  final String category;
  final Optional<Operation> operationOpt;
  final TextEditingController itemChangedCtrl;
  final TextEditingController personChangedCtrl;
  final TextEditingController dateChangedCtrl;
  final TextEditingController summaChangedCtrl;
  final TextEditingController currencyChangedCtrl;
  final TextEditingController commentChangedCtrl;

  AddOperationScaffold(this.category, this.operationOpt, {Key key}) :
        itemChangedCtrl = TextEditingController(text: operationOpt.map((o) => o.itemUtf8).orElse("")),
        personChangedCtrl = TextEditingController(text: operationOpt.map((o) => o.personUtf8).orElse("")),
        dateChangedCtrl = TextEditingController(text: operationOpt.map((o) => o.timeUtf8).orElse("")),
        summaChangedCtrl = TextEditingController(text: operationOpt.map((o) => o.summa.toString()).orElse("")),
        currencyChangedCtrl = TextEditingController(text: operationOpt.map((o) => o.currency.toString()).orElse("")),
        commentChangedCtrl = TextEditingController(text: operationOpt.map((o) => o.commentUtf8).orElse("")),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Guap Application")),
      body: AddOperationScreen(
        category,
        itemChangedCtrl: itemChangedCtrl,
        dateChangedCtrl: dateChangedCtrl,
        personChangedCtrl: personChangedCtrl,
        summaChangedCtrl: summaChangedCtrl,
        currencyChangedCtrl: currencyChangedCtrl,
        commentChangedCtrl: commentChangedCtrl,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check, size: 36),
        tooltip: "Confirm",
        onPressed: () => _onPress(context),
      )
    );
  }

  void _onPress(BuildContext context) {
    operationOpt.ifPresent((op) => _editOperation(context, op.id), orElse: () => _addOperation(context));
  }

  void _addOperation(BuildContext context) {
    final person = personChangedCtrl.text.trim();
    final store = StoreProvider.of<AppState>(context);

    if (!store.state.personsState.persons.contains(person)) {
      final action = PersonsThunk.addPerson(person);
      store.dispatch(action);
      // TODO: here we need some pause (event, callback) to let Server finish adding a new person
    }
    final summa = double.parse(summaChangedCtrl.text);
    final currencyRate = _getCurrencyRate(currencyChangedCtrl.text, dateChangedCtrl.text);
    final comment = commentChangedCtrl.text.trim();
    final action = OperationsThunk.addOperation(itemChangedCtrl.text, person, summa, dateChangedCtrl.text, currencyChangedCtrl.text, currencyRate, comment);
    store.dispatch(action);
    Navigator.popUntil(context, ModalRoute.withName("/main"));
  }

  void _editOperation(BuildContext context, int id) {
    final person = personChangedCtrl.text.trim();
    final summa = double.parse(summaChangedCtrl.text);
    final currencyRate = _getCurrencyRate(currencyChangedCtrl.text, dateChangedCtrl.text);
    final comment = commentChangedCtrl.text.trim();
    final action = OperationsThunk.changeOperation(id, itemChangedCtrl.text, person, summa, dateChangedCtrl.text, currencyChangedCtrl.text, currencyRate, comment);
    StoreProvider.of<AppState>(context).dispatch(action);
    Navigator.popUntil(context, ModalRoute.withName("/main"));
  }

  double _getCurrencyRate(String currency, String date) {
    // TODO: taken from Google.Finance at 2023-01-12: need to fetch dynamically for a given date
    switch (currency) {
      case "USD": return 1;
      case "EUR": return 1.0752;
      case "RUB": return 0.0148;
      case "AMD": return 0.0026;
      case "THB": return 0.0299;
      default:    return 1;      // default no-op multiplicator
    }
  }
}
