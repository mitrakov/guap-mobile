import 'package:guap_mobile/person/redux.dart';
import 'package:guap_mobile/redux/actions.dart';
import 'package:redux/redux.dart';
import 'package:guap_mobile/redux/appstate.dart';
import 'package:guap_mobile/category/redux.dart';
import 'package:guap_mobile/operation/redux.dart';

class AppReducer {
  static Reducer<AppState> reducer = combineReducers<AppState>([
    TypedReducer<AppState, CategoriesFetchedAction>((state, action)    => state.withCategories(action.categories)),
    TypedReducer<AppState, CategoriesFetchErrorAction>((state, action) => state.withLastError(action.error)),
    TypedReducer<AppState, OperationsFetchedAction>((state, action)    => state.withOperations(action.operations)),
    TypedReducer<AppState, OperationsFetchErrorAction>((state, action) => state.withLastError(action.error)),
    TypedReducer<AppState, PersonsFetchedAction>((state, action)       => state.withPersons(action.persons)),
    TypedReducer<AppState, PersonsFetchErrorAction>((state, action)    => state.withLastError(action.error)),
    TypedReducer<AppState, ResetAction>((s, a) => AppState()),
  ]);
}
