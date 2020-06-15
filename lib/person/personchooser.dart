import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:guap_mobile/person/redux.dart';
import 'package:guap_mobile/redux/appstate.dart';

class PersonChooser extends StatelessWidget {
  final ValueChanged<String> onPersonChange;

  const PersonChooser(this.onPersonChange, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController ctrl = TextEditingController();
    return StoreConnector<AppState, PersonsState>(
      distinct: true,
      converter: (store) => store.state.personsState,
      builder: (context1, state) => TypeAheadField(
        textFieldConfiguration: TextFieldConfiguration(
          controller: ctrl,
          style: DefaultTextStyle.of(context1).style.copyWith(fontStyle: FontStyle.italic),
          decoration: InputDecoration(border: OutlineInputBorder())
        ),
        suggestionsCallback: (prefix) {
          final list = new List<String>.from(state.persons);
          list.retainWhere((s) => s.toLowerCase().contains(prefix.toLowerCase()));
          return list;
        },
        itemBuilder: (context2, suggestion) => ListTile(title: Text(suggestion)),
        onSuggestionSelected: (newValue) {
          onPersonChange(newValue);
          ctrl.text = newValue;
        }
      )
    );
  }
}
