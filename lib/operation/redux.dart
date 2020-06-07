import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:guap_mobile/redux/ajax.dart';

class OperationsState {
  final List<int> operations;
  const OperationsState({this.operations = const []});
}

class OperationsFetchedAction {
  final List<int> operations;
  OperationsFetchedAction(this.operations);
}

class OperationsFetchErrorAction {
  final String error;
  OperationsFetchErrorAction(this.error);
}

class OperationsThunk {
  static final Ajax ajax = Ajax();

  static ThunkAction fetchOperations() {
    return (Store store) async {
      try {
        store.dispatch(OperationsFetchedAction(await ajax.fetchOperations()));
      } catch(e) {
        store.dispatch(OperationsFetchErrorAction(e.toString()));
      }
    };
  }
}
