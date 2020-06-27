import 'package:optional/optional.dart';
import 'package:tuple/tuple.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
          onTap: () => Navigator.pushNamed(context, "/chooseCategory", arguments: Tuple2(Optional.of(id), "/operation")),
        ),
        IconSlideAction(
          caption: "Delete",
          color: Colors.red[400],
          icon: Icons.delete_forever,
          onTap: () => StoreProvider.of<AppState>(context).dispatch(OperationsThunk.removeOperation(id)),
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
}
