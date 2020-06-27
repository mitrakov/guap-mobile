import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:guap_mobile/person/redux.dart';
import 'package:guap_mobile/redux/appstate.dart';

class PersonEditor extends StatelessWidget {
  final TextEditingController changePersonCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PersonsState>(
      distinct: true,
      converter: (store) => store.state.personsState,
      builder: (context1, state) {
        if (state.persons.isEmpty)
          StoreProvider.of<AppState>(context1).dispatch(PersonsThunk.fetchPersons());
        return ListView.builder(
          itemCount: state.persons.length,
          itemBuilder: (context2, i) => _createTile(context2, state.persons[i]),
        );
      },
    );
  }

  Widget _createTile(BuildContext context, String person) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.2,
      child: ListTile(
        title: Text(person),
        leading: Icon(Icons.person),
      ),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: "Edit",
          color: Colors.grey[400],
          icon: Icons.mode_edit,
          onTap: () => _changePersonDialog(context, person).show(),
        ),
        IconSlideAction(
          caption: "Delete",
          color: Colors.red[400],
          icon: Icons.delete,
          onTap: () => StoreProvider.of<AppState>(context).dispatch(PersonsThunk.removePerson(person)),
        ),
      ]
    );
  }

  Alert _changePersonDialog(BuildContext context, String curName) {
    changePersonCtrl.text = curName;
    return Alert(
      context: context,
      title: "Rename person",
      content: Column(
        children: <Widget>[
          TextField(
            controller: changePersonCtrl,
            decoration: InputDecoration(icon: Icon(Icons.person), labelText: "Person name"),
          )
        ],
      ),
      buttons: [
        DialogButton(
          child: Text("Rename", style: TextStyle(color: Colors.white, fontSize: 20)),
          onPressed: () {
            final newName = changePersonCtrl.text;
            if (newName.isNotEmpty && newName != curName) {
              StoreProvider.of<AppState>(context).dispatch(PersonsThunk.renamePerson(curName, newName));
              Navigator.pop(context);
            }
          }
        ),
      ],
    );
  }
}
