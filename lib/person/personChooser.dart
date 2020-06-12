import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:guap_mobile/person/redux.dart';
import 'package:guap_mobile/redux/appstate.dart';

class PersonChooser extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PersonChooserState();
}

class PersonChooserState extends State<PersonChooser> {
  String currentValue;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, PersonsState>(
      distinct: true,
      converter: (store) => store.state.personsState,
      builder: (context1, state) => DropdownButton(
          value: currentValue,
          hint: Text("Choose a person"),
          icon: Icon(Icons.keyboard_arrow_down),
          items: state.persons.map((person) => DropdownMenuItem(value: person, child: Text(person))).toList(),
          elevation: 4,
          onChanged: (String newValue) {
            setState(() {
              currentValue = newValue;
            });
          },
        ),
    );
  }
  
}
