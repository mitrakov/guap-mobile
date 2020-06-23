import 'package:redux/redux.dart';
import 'package:guap_mobile/category/redux.dart';
import 'package:guap_mobile/item/redux.dart';
import 'package:guap_mobile/operation/redux.dart';
import 'package:guap_mobile/person/redux.dart';
import 'package:guap_mobile/redux/actions.dart';
import 'package:guap_mobile/redux/appstate.dart';

class AppReducer {
  static Reducer<AppState> reducer = combineReducers<AppState>([
    TypedReducer<AppState, CategoriesFetchedAction>((state, action) => state.withCategories(action.categories)), // TODO state.copy
    TypedReducer<AppState, ItemsFetchedAction>((state, action)      => state.withItems(action.items)), // TODO state.copy
    TypedReducer<AppState, OperationsFetchedAction>((state, action) => state.withOperations(action.operations, category: action.category)), // TODO state.copy
    TypedReducer<AppState, PersonsFetchedAction>((state, action)    => state.withPersons(action.persons)), // TODO state.copy
    TypedReducer<AppState, ErrorAction>((state, action)             => state.withLastError(action.error)), // TODO state.copy
    TypedReducer<AppState, ResetAction>((s, a) => AppState()),
  ]);
}
