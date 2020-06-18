import 'package:guap_mobile/category/category.dart';
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
    this.lastError = '',
  }) {
   print("Creating Appstate: categories ${categoryState.categories.length}, operations ${operationsState.operations.length}, persons ${personsState.persons.length}, $lastError");
  }

  AppState withCategories(List<Category> categories) {
    return AppState(
        categoryState: CategoryState(categories: categories),
        operationsState: this.operationsState,
        personsState: this.personsState,
        lastError: this.lastError,
    );
  }

  AppState withOperations(List<int> operations) {
    return AppState(
        categoryState: this.categoryState,
        operationsState: OperationsState(operations: operations),
        personsState: this.personsState,
        lastError: this.lastError,
    );
  }

  AppState withPersons(List<String> persons) {
    return AppState(
        categoryState: this.categoryState,
        operationsState: this.operationsState,
        personsState: PersonsState(persons: persons),
        lastError: this.lastError,
    );
  }

  AppState withLastError(String error) {
    return AppState(
        categoryState: this.categoryState,
        operationsState: this.operationsState,
        personsState: this.personsState,
        lastError: error,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is AppState &&
              runtimeType == other.runtimeType &&
              categoryState == other.categoryState &&
              operationsState == other.operationsState &&
              personsState == other.personsState &&
              lastError == other.lastError;

  @override
  int get hashCode => categoryState.hashCode ^ operationsState.hashCode ^ personsState.hashCode ^ lastError.hashCode;
}
