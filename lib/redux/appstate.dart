import 'package:guap_mobile/category/redux.dart';
import 'package:guap_mobile/operation/redux.dart';
import 'package:guap_mobile/person/redux.dart';

class AppState {
  final CategoryState categoryState;
  final OperationsState operationsState;
  final PersonsState personsState;
  final String lastError;

  AppState({
    this.categoryState = const CategoryState(),
    this.operationsState = const OperationsState(),
    this.personsState = const PersonsState(),
    this.lastError = ''
  });
}
