import 'package:guap_mobile/redux/actions.dart';
import 'package:guap_mobile/redux/ajax.dart';
import 'package:guap_mobile/redux/appstate.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

class Saga implements EpicClass<AppState> {
  final Ajax ajax;

  Saga(this.ajax);

  @override
  Stream call(Stream actions, EpicStore<AppState> store) {
    return Observable(actions)
        .ofType(TypeToken<FetchPersonsAction>())
        .debounce(Duration(milliseconds: 250))
        .switchMap((_) => fetchPersons());
  }

  Stream fetchPersons() async* {
    try {
      yield PersonsFetchedAction(await ajax.fetchPersons());
    } catch(e) {
      yield FetchErrorAction(e.toString());
    }
  }
}
