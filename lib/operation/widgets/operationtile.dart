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

class OperationTile extends StatelessWidget {
  final int id;

  const OperationTile(this.id, Key key) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.2,
      child: _createTile(),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: "Edit",
          color: Colors.grey[400],
          icon: Icons.mode_edit,
          onTap: () => onEdit(context),
        ),
        IconSlideAction(
          caption: "Delete",
          color: Colors.red[400],
          icon: Icons.delete_forever,
          onTap: () => _removeOperationDialog(context).show(),
        ),
      ]
    );
  }

  Widget _createTile() {
    return FutureBuilder<Operation>(
      future: GlobalOperationStore.get(id), // it's ok to run future here because it's cached
      builder: (context1, snapshot) {
        if (snapshot.hasData)
          return ListTile(
            title: Text(snapshot.data.itemUtf8),
            subtitle: Text("${snapshot.data.timeUtf8}\n${snapshot.data.personUtf8}"),
            trailing: Text("${snapshot.data.summa} ₽", style: TextStyle(fontSize: 22)),
          );
        if (snapshot.hasError)
          return Text("${snapshot.error}");
        return CircularProgressIndicator();
      }
    );
  }

  void onEdit(BuildContext context) async {
    final operation = await GlobalOperationStore.get(id);
    Navigator.pushNamed(context, "/chooseCategory", arguments: Tuple2(Optional.of(operation), "/operation"));
  }

  Alert _removeOperationDialog(BuildContext context) {
    return Alert(
      context: context,
      title: "Are you sure to remove this operation?",
      closeFunction: () => {},
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
}
