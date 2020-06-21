import 'package:redux/redux.dart';
import 'package:guap_mobile/category/redux.dart';
import 'package:guap_mobile/item/redux.dart';
import 'package:guap_mobile/operation/redux.dart';
import 'package:guap_mobile/person/redux.dart';
import 'package:guap_mobile/redux/actions.dart';
import 'package:guap_mobile/redux/appstate.dart';

class AppReducer {
  static Reducer<AppState> reducer = combineReducers<AppState>([
    TypedReducer<AppState, CategoriesFetchedAction>((state, action) => state.withCategories(action.categories)),
    TypedReducer<AppState, ItemsFetchedAction>((state, action)      => state.withItems(action.items)),
    TypedReducer<AppState, OperationsFetchedAction>((state, action) => state.withOperations(action.operations)),
    TypedReducer<AppState, PersonsFetchedAction>((state, action)    => state.withPersons(action.persons)),
    TypedReducer<AppState, ErrorAction>((state, action)             => state.withLastError(action.error)),
    TypedReducer<AppState, ResetAction>((s, a) => AppState()),
  ]);
}
