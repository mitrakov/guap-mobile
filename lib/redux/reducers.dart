import 'package:redux/redux.dart';
import 'package:guap_mobile/redux/actions.dart';
import 'package:guap_mobile/redux/appstate.dart';

class AppReducer {
  static AppState personsFetchedReducer(AppState state, PersonsFetchedAction action) {
    return AppState(persons: action.persons);
  }
  static AppState fetchErrorReducer(AppState state, FetchErrorAction action) {
    return AppState(lastError: action.error);
  }

  static Reducer<AppState> reducer = combineReducers<AppState>([
    TypedReducer<AppState, PersonsFetchedAction>(personsFetchedReducer),
    TypedReducer<AppState, FetchErrorAction>(fetchErrorReducer)
  ]);
}
