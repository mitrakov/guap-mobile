import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:guap_mobile/redux/ajax.dart';

class PersonsState {
  final List<String> persons;
  const PersonsState({this.persons = const []});
}

class PersonsFetchedAction {
  final List<String> persons;
  PersonsFetchedAction(this.persons);
}

class PersonsFetchErrorAction {
  final String error;
  PersonsFetchErrorAction(this.error);
}

class PersonsThunk {
  static final Ajax ajax = Ajax();

  static ThunkAction fetchPersons() {
    return (Store store) async {
      try {
        store.dispatch(PersonsFetchedAction(await ajax.fetchPersons()));
      } catch(e) {
        store.dispatch(PersonsFetchErrorAction(e.toString()));
      }
    };
  }
}
