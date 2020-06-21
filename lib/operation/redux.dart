import 'package:flutter/foundation.dart';
import 'package:guap_mobile/redux/actions.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:guap_mobile/redux/ajax.dart';

class OperationsState {
  final List<int> operations;
  const OperationsState({this.operations = const []});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is OperationsState &&
              runtimeType == other.runtimeType &&
              listEquals(operations, other.operations);

  @override
  int get hashCode => operations.hashCode;
}

class OperationsFetchedAction {
  final List<int> operations;
  OperationsFetchedAction(this.operations);
}

class OperationsThunk {
  static ThunkAction fetchOperations(String category) {
    return (Store store) async {
      try {
        store.dispatch(OperationsFetchedAction(await Ajax.fetchOperations(category)));
      } catch(e) {
        store.dispatch(ErrorAction(e.toString()));
      }
    };
  }
}
