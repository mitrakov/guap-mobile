import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:flutter/foundation.dart';
import 'package:guap_mobile/operation/global.dart';
import 'package:guap_mobile/operation/operation.dart';
import 'package:guap_mobile/redux/actions.dart';
import 'package:guap_mobile/redux/appstate.dart';
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
  final String category;
  final List<int> operations;
  OperationsFetchedAction(this.category, this.operations);
}

class OperationsThunk {
  static ThunkAction<AppState> fetchOperations(String category) {
    return (Store<AppState> store) async {
      try {
        store.dispatch(OperationsFetchedAction(category, await Ajax.fetchOperations(category)));
      } catch(e) {
        store.dispatch(ErrorAction(e.toString()));
      }
    };
  }

  static ThunkAction<AppState> addOperation(String item, String person, double summa, String date, String currency, double currencyRate) {
    return (Store<AppState> store) {
      try {
        Ajax.addOperation(AddOperationRequest(item, person, summa, date, currency, currencyRate))
            .then((_) => store.dispatch(fetchOperations(store.state.categoryToDisplay)));
      } catch(e) {
        store.dispatch(ErrorAction(e.toString()));
      }
    };
  }

  static ThunkAction<AppState> changeOperation(int id, String item, String person, double summa, String date, String currency, double currencyRate) {
    return (Store<AppState> store) async {
      try {
        Ajax.changeOperation(ChangeOperationRequest(id, item, person, summa, date, currency, currencyRate)).then((_) {
          store.dispatch(fetchOperations(store.state.categoryToDisplay));
          GlobalOperationStore.invalidateAll(); // recreate all operations to update their names
        });
      } catch(e) {
        store.dispatch(ErrorAction(e.toString()));
      }
    };
  }

  static ThunkAction<AppState> removeOperation(int id) {
    return (Store<AppState> store) {
      try {
        Ajax.removeOperation(RemoveOperationRequest(id))
            .then((_) => store.dispatch(fetchOperations(store.state.categoryToDisplay)));
      } catch(e) {
        store.dispatch(ErrorAction(e.toString()));
      }
    };
  }
}
