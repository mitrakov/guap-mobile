import 'package:redux/redux.dart';
import 'package:guap_mobile/category/redux.dart';
import 'package:guap_mobile/item/redux.dart';
import 'package:guap_mobile/operation/redux.dart';
import 'package:guap_mobile/person/redux.dart';
import 'package:guap_mobile/redux/actions.dart';
import 'package:guap_mobile/redux/appstate.dart';

class AppReducer {
  static Reducer<AppState> reducer = combineReducers<AppState>([
    TypedReducer<AppState, CategoriesFetchedAction>((state, action) => state.copy(categories: action.categories)),
    TypedReducer<AppState, ItemsFetchedAction>((state, action)      => state.copy(items: action.items)),
    TypedReducer<AppState, OperationsFetchedAction>((state, action) => state.copy(operations: action.operations, categoryToDisplay: action.category)),
    TypedReducer<AppState, PersonsFetchedAction>((state, action)    => state.copy(persons: action.persons)),
    TypedReducer<AppState, ErrorAction>((state, action)             => state.copy(lastError: action.error)),
    TypedReducer<AppState, TokenAction>((state, action)             => state.copy(token: action.token)),
    TypedReducer<AppState, ResetAction>((s, a) => AppState()),
  ]);
}
