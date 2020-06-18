import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

class ResetAction {}

class StdActions {
  static ThunkAction resetAll() => (Store store) {
    store.dispatch(ResetAction());
  };
}
