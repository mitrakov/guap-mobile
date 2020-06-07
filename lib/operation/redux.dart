import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:guap_mobile/redux/ajax.dart';

class OperationsState {
  final List<int> operations;
  final String error;

  OperationsState({this.operations = const [], this.error = ''});
}

class OperationsFetchedAction {
  final List<int> operations;

  OperationsFetchedAction(this.operations);
}

class FetchErrorAction {
  final String error;
  FetchErrorAction(this.error);
}

class OperationsReducer {
  static OperationsState operationsFetchedReducer(OperationsState state, OperationsFetchedAction action) {
    return OperationsState(operations: action.operations);
  }
  static OperationsState fetchErrorReducer(OperationsState state, FetchErrorAction action) {
    return OperationsState(error: action.error);
  }

  static Reducer<OperationsState> reducer = combineReducers<OperationsState>([
    TypedReducer<OperationsState, OperationsFetchedAction>(operationsFetchedReducer),
    TypedReducer<OperationsState, FetchErrorAction>(fetchErrorReducer)
  ]);
}

class OperationsThunk {
  static final Ajax ajax = Ajax();

  static ThunkAction fetchOperations() {
    return (Store store) async {
      try {
        store.dispatch(OperationsFetchedAction(await ajax.fetchOperations()));
      } catch(e) {
        store.dispatch(FetchErrorAction(e.toString()));
      }
    };
  }
}
