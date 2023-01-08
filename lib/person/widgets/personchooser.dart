import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:guap_mobile/person/redux.dart';
import 'package:guap_mobile/redux/appstate.dart';

class PersonChooser extends StatelessWidget {
  final TextEditingController ctrl;

  const PersonChooser(this.ctrl, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Rebiulding person chooser");
    return StoreConnector<AppState, PersonsState>(
      distinct: true,
      converter: (store) => store.state.personsState,
      builder: (context1, state) {
        if (state.persons.isEmpty)
          StoreProvider.of<AppState>(context1).dispatch(PersonsThunk.fetchPersons());
        return TypeAheadField(
          textFieldConfiguration: TextFieldConfiguration(
            controller: ctrl,
            style: DefaultTextStyle.of(context1).style.copyWith(fontStyle: FontStyle.italic),
            decoration: InputDecoration(border: OutlineInputBorder(), labelText: "Choose person (optional)"),
          ),
          suggestionsCallback: (prefix) {
            final list = new List<String>.from(state.persons);
            list.retainWhere((s) => s.toLowerCase().contains(prefix.toLowerCase()));
            return list;
          },
          itemBuilder: (context2, suggestion) => ListTile(title: Text(suggestion)),
          onSuggestionSelected: (newValue) {
            ctrl.text = newValue;
          }
        );
      }
    );
  }
}
