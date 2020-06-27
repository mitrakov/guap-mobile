import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:guap_mobile/item/redux.dart';
import 'package:guap_mobile/redux/appstate.dart';

class ItemEditor extends StatelessWidget {
  final String category;
  final TextEditingController changeItemCtrl = TextEditingController();

  ItemEditor(this.category, {Key key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ItemState>(
      distinct: true,
      converter: (store) => store.state.itemState,
      builder: (context1, state) {
        return ListView.builder(
          itemCount: state.items.length,
          itemBuilder: (context2, i) => _createTile(context2, state.items[i]),
        );
      },
    );
  }

  Widget _createTile(BuildContext context, String item) {
    return Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.75,
        child: ListTile(
          title: Text(item),
          leading: Icon(Icons.satellite),
        ),
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: "Edit",
            color: Colors.grey[400],
            icon: Icons.mode_edit,
            onTap: () => _changeItemDialog(context, item),
          ),
          IconSlideAction(
            caption: "Delete",
            color: Colors.red[400],
            icon: Icons.delete,
            onTap: () => StoreProvider.of<AppState>(context).dispatch(ItemsThunk.removeItem(item, category)),
          ),
        ]
    );
  }

  Alert _changeItemDialog(BuildContext context, String curName) {
    changeItemCtrl.text = curName;
    return Alert(
      context: context,
      title: "Rename item",
      content: Column(
        children: <Widget>[
          TextField(
            controller: changeItemCtrl,
            decoration: InputDecoration(icon: Icon(Icons.insert_chart), labelText: "Item name"),
          )
        ],
      ),
      buttons: [
        DialogButton(
            child: Text("Rename", style: TextStyle(color: Colors.white, fontSize: 20)),
            onPressed: () {
              final newName = changeItemCtrl.text;
              if (newName.isNotEmpty && newName != curName) {
                StoreProvider.of<AppState>(context).dispatch(ItemsThunk.changeItem(curName, newName, category));
                Navigator.pop(context);
              }
            }
        ),
      ],
    );
  }
}
