import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

class ResetAction {}

class ThunkActions {
  static ThunkAction resetAll() => (Store store) {
    store.dispatch(ResetAction());
  };
}

class ErrorAction {
  final String error;
  ErrorAction(this.error);
}
