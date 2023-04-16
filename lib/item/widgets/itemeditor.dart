import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:guap_mobile/item/redux.dart';
import 'package:guap_mobile/redux/appstate.dart';

class ItemEditor extends StatelessWidget {
  final String category;
  final TextEditingController changeItemCtrl = TextEditingController();

  ItemEditor(this.category, {Key? key}): super(key: key);

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
      endActionPane: ActionPane(
        motion: DrawerMotion(),
        extentRatio: 0.5,
        children: [
          SlidableAction(
            label: "Edit",
            backgroundColor: Colors.grey[400]!,
            icon: Icons.mode_edit,
            onPressed: (_) => _changeItemDialog(context, item).show(), // don't use the context from "_"
          ),
          SlidableAction(
            label: "Delete",
            backgroundColor: Colors.red[400]!,
            icon: Icons.delete,
            onPressed: (_) => _removeItemDialog(context, item).show(), // don't use the context from "_"
          )
        ],
      ),
      child: ListTile(
        title: Text(item),
        leading: Icon(Icons.satellite),
      )
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

  Alert _removeItemDialog(BuildContext context, String item) {
    return Alert(
      context: context,
      title: "Are you sure to remove item $item?",
      buttons: [
        DialogButton(
          child: Text("Cancel", style: TextStyle(color: Colors.white, fontSize: 20)),
          onPressed: () => Navigator.pop(context),
        ),
        DialogButton(
          color: Colors.grey[300],
          child: Text("Delete", style: TextStyle(color: Colors.deepOrange[800], fontSize: 20, fontWeight: FontWeight.w600)),
          onPressed: () {
            StoreProvider.of<AppState>(context).dispatch(ItemsThunk.removeItem(item, category));
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
