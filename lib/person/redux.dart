import 'package:flutter/foundation.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:guap_mobile/redux/actions.dart';
import 'package:guap_mobile/redux/ajax.dart';

class PersonsState {
  final List<String> persons;
  const PersonsState({this.persons = const []});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is PersonsState && runtimeType == other.runtimeType && listEquals(persons, other.persons);

  @override
  int get hashCode => persons.hashCode;
}

class PersonsFetchedAction {
  final List<String> persons;
  PersonsFetchedAction(this.persons);
}

class PersonsThunk {
  static ThunkAction fetchPersons() {
    return (Store store) async {
      try {
        store.dispatch(PersonsFetchedAction(await Ajax.fetchPersons()));
      } catch(e) {
        store.dispatch(ErrorAction(e.toString()));
      }
    };
  }
}
