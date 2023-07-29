import 'package:optional/optional.dart';
import 'package:tuple/tuple.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:guap_mobile/operation/global.dart';
import 'package:guap_mobile/operation/operation.dart';
import 'package:guap_mobile/operation/redux.dart';
import 'package:guap_mobile/redux/appstate.dart';
import 'package:guap_mobile/settings/settings.dart';

class OperationTile extends StatelessWidget {
  final int id;

  const OperationTile(this.id, Key key) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      child: _createTile(),
      endActionPane: ActionPane(
        motion: DrawerMotion(),
        extentRatio: 0.5,
        children: [
          SlidableAction(
            label: "Edit",
            backgroundColor: Colors.grey[400]!,
            icon: Icons.mode_edit,
            onPressed: (_) => _onEdit(context), // don't use the context from "_"
          ),
          SlidableAction(
            label: "Delete",
            backgroundColor: Colors.red[400]!,
            icon: Icons.delete_forever,
            onPressed: (_) => _removeOperationDialog(context).show(), // don't use the context from "_"
          )
        ],
      )
    );
  }

  Widget _createTile() {
    return FutureBuilder<Operation>(
      future: GlobalOperationStore.get(id), // it's ok to run future here because it's cached
      builder: (context1, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data!;
          final person = Settings.showPersons() ? "\n${data.personUtf8}" : "";
          return ListTile(
            title: Text(data.itemUtf8),
            subtitle: Text("${data.timeUtf8}$person"),
            trailing: Text("${data.summa} ${_currencyMapping(data.currency)}", style: TextStyle(fontSize: 22)),
          );
        }
        if (snapshot.hasError)
          return Text("${snapshot.error}");
        return CircularProgressIndicator();
      }
    );
  }

  void _onEdit(BuildContext context) async {
    final operation = await GlobalOperationStore.get(id);
    Navigator.pushNamed(context, "/chooseCategory", arguments: Tuple2(Optional.of(operation), "/operation"));
  }

  Alert _removeOperationDialog(BuildContext context) {
    return Alert(
      context: context,
      title: "Are you sure to remove this operation?",
      buttons: [
        DialogButton(
          child: Text("Cancel", style: TextStyle(color: Colors.white, fontSize: 20)),
          onPressed: () => Navigator.pop(context),
        ),
        DialogButton(
          color: Colors.grey[300],
          child: Text("Delete", style: TextStyle(color: Colors.deepOrange[800], fontSize: 20, fontWeight: FontWeight.w600)),
          onPressed: () {
            StoreProvider.of<AppState>(context).dispatch(OperationsThunk.removeOperation(id));
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  String _currencyMapping(String currencyCode) {
    switch (currencyCode) {
      case "RUB": return "₽";
      case "USD": return "\$";
      case "EUR": return "€";
      case "KGS": return "лв";
      case "AMD": return "֏";
      case "THB": return "฿";
      default: return "?";
    }
  }
}
