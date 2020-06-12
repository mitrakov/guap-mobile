import 'package:guap_mobile/person/redux.dart';
import 'package:redux/redux.dart';
import 'package:guap_mobile/redux/appstate.dart';
import 'package:guap_mobile/category/redux.dart';
import 'package:guap_mobile/operation/redux.dart';

class AppReducer {
  static AppState categoriesFetchedReducer(AppState state, CategoriesFetchedAction action) {
    return AppState(categoryState: CategoryState(categories: action.categories), operationsState: state.operationsState, personsState: state.personsState);
  }
  static AppState categoriesFetchErrorReducer(AppState state, CategoriesFetchErrorAction action) {
    return AppState(categoryState: state.categoryState, operationsState: state.operationsState, personsState: state.personsState, lastError: action.error);
  }
  static AppState operationsFetchedReducer(AppState state, OperationsFetchedAction action) {
    return AppState(categoryState: state.categoryState, operationsState: OperationsState(operations: action.operations), personsState: state.personsState);
  }
  static AppState operationsFetchErrorReducer(AppState state, OperationsFetchErrorAction action) {
    return AppState(categoryState: state.categoryState, operationsState: state.operationsState, personsState: state.personsState, lastError: action.error);
  }
  static AppState personsFetchedReducer(AppState state, PersonsFetchedAction action) {
    return AppState(categoryState: state.categoryState, operationsState: state.operationsState, personsState: PersonsState(persons: action.persons));
  }
  static AppState personsFetchErrorReducer(AppState state, PersonsFetchErrorAction action) {
    return AppState(categoryState: state.categoryState, operationsState: state.operationsState, personsState: state.personsState, lastError: action.error);
  }

  static Reducer<AppState> reducer = combineReducers<AppState>([
    TypedReducer<AppState, CategoriesFetchedAction>(categoriesFetchedReducer),
    TypedReducer<AppState, CategoriesFetchErrorAction>(categoriesFetchErrorReducer),
    TypedReducer<AppState, OperationsFetchedAction>(operationsFetchedReducer),
    TypedReducer<AppState, OperationsFetchErrorAction>(operationsFetchErrorReducer),
    TypedReducer<AppState, PersonsFetchedAction>(personsFetchedReducer),
    TypedReducer<AppState, PersonsFetchErrorAction>(personsFetchErrorReducer),
  ]);
}
