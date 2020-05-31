import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:guap_mobile/redux/ajax.dart';
import 'package:guap_mobile/redux/actions.dart';

class Thunk {
  static final Ajax ajax = Ajax();

  static ThunkAction fetchPersons() {
    return (Store store) async {
      try {
        store.dispatch(PersonsFetchedAction(await ajax.fetchPersons()));
      } catch(e) {
        store.dispatch(FetchErrorAction(e.toString()));
      }
    };
  }
}
