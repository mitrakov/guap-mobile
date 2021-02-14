import 'package:flutter/foundation.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:guap_mobile/redux/appstate.dart';
import 'package:guap_mobile/person/person.dart';
import 'package:guap_mobile/operation/global.dart';
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
  static ThunkAction<AppState> fetchPersons() {
    return (Store<AppState> store) async {
      try {
        store.dispatch(PersonsFetchedAction(await Ajax.fetchPersons()));
      } catch(e) {
        store.dispatch(ErrorAction(e.toString()));
      }
    };
  }

  static ThunkAction<AppState> addPerson(String name) {
    return (Store<AppState> store) {
      try {
        Ajax.addPerson(AddPersonRequest(name)).then((_) => store.dispatch(fetchPersons()));
      } catch(e) {
        store.dispatch(ErrorAction(e.toString()));
      }
    };
  }

  static ThunkAction<AppState> renamePerson(String oldName, String newName) {
    return (Store<AppState> store) async {
      try {
        Ajax.changePerson(ChangePersonRequest(oldName, newName)).then((_) {
          store.dispatch(fetchPersons());
          GlobalOperationStore.invalidateAll(); // recreate all operations to update persons' names
        });
      } catch(e) {
        store.dispatch(ErrorAction(e.toString()));
      }
    };
  }

  static ThunkAction<AppState> removePerson(String person) {
    return (Store<AppState> store) async {
      try {
        Ajax.removePerson(RemovePersonRequest(person)).then((_) => store.dispatch(fetchPersons()));
      } catch(e) {
        store.dispatch(ErrorAction(e.toString()));
      }
    };
  }
}
