import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:guap_mobile/redux/ajax.dart';
import 'package:guap_mobile/redux/actions.dart';

class Thunk {
  static ThunkAction fetchPersons() {
    return (Store store) async {
      try {
        store.dispatch(PersonsFetchedAction(await Ajax.fetchPersons()));
      } catch(e) {
        store.dispatch(FetchErrorAction(e.toString()));
      }
    };
  }
}
