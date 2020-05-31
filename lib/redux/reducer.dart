import 'package:guap_mobile/redux/actions.dart';
import 'package:guap_mobile/redux/appstate.dart';
import 'package:redux/redux.dart';

class AppReducer {
  static AppState personsFetchedReducer(AppState state, PersonsFetchedAction action) {
    return AppState(persons: action.persons, lastError: "");
  }
  static AppState fetchErrorReducer(AppState state, FetchErrorAction action) {
    return AppState(persons: [], lastError: action.error);
  }

  Reducer<AppState> reducer() => combineReducers<AppState>([
    TypedReducer<AppState, PersonsFetchedAction>(personsFetchedReducer),
    TypedReducer<AppState, FetchErrorAction>(fetchErrorReducer)
  ]);
}
