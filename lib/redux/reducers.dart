import 'package:redux/redux.dart';
import 'package:guap_mobile/redux/appstate.dart';
import 'package:guap_mobile/category/redux.dart';
import 'package:guap_mobile/operation/redux.dart';

class AppReducer {
  static AppState categoriesFetchedReducer(AppState state, CategoriesFetchedAction action) {
    return AppState(categoryState: CategoryState(categories: action.categories), operationsState: state.operationsState);
  }
  static AppState categoriesFetchErrorReducer(AppState state, CategoriesFetchErrorAction action) {
    return AppState(categoryState: state.categoryState, operationsState: state.operationsState, lastError: action.error);
  }
  static AppState operationFetchedReducer(AppState state, OperationsFetchedAction action) {
    return AppState(categoryState: state.categoryState, operationsState: OperationsState(operations: action.operations));
  }
  static AppState operationsFetchErrorReducer(AppState state, OperationsFetchErrorAction action) {
    return AppState(categoryState: state.categoryState, operationsState: state.operationsState, lastError: action.error);
  }

  static Reducer<AppState> reducer = combineReducers<AppState>([
    TypedReducer<AppState, CategoriesFetchedAction>(categoriesFetchedReducer),
    TypedReducer<AppState, CategoriesFetchErrorAction>(categoriesFetchErrorReducer),
    TypedReducer<AppState, OperationsFetchedAction>(operationFetchedReducer),
    TypedReducer<AppState, OperationsFetchErrorAction>(operationsFetchErrorReducer),
  ]);
}
